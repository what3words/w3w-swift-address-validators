//
//  File.swift
//  
//
//  Created by Dave Duprey on 29/11/2021.
//

import Foundation
import W3WSwiftApi


/// Swift Complete's index of field ids
enum W3WStreetAddressParts: Int {
  case address = 0
  case number = 1
  case street = 2
  case locality = 3
  case city = 4
  case postCode = 5
  case country = 6
}


/// Swift Complete Api wrapper
public class W3WAddressValidatorSwiftComplete: W3WAddressValidatorProtocol {

  /// the Swift Complete Apiservice
  let swiftComplete: W3WRequest!
  
  /// the name of this service
  public var name: String {
    get {
      return "Swift Complete"
    }
  }
  
  /// this serice does not support sub item counts
  public var supportsSubitemCounts: Bool {
    get {
      return false
    }
  }
  
  
  /// Swift Complete Api wrapper
  /// - parameter key: your Loqate Swift Complete key
  public init(key: String) {
    self.swiftComplete = W3WRequest(baseUrl: W3WSwiftCompleteSettings.swiftCompleteHost, parameters: ["key" : key])
  }

  
  /// searches near a three word address
  /// - parameter near: the three word address to search near
  /// - parameter completion: called with new nodes when they are available from the call
  public func search(near: String, completion: @escaping ([W3WValidatorNode], W3WAddressFinderError?) -> ()) {

    // set up call
    let params = [
      "biasTowards":    "///" + near,
      "distanceUnits":  "M",
      //"maxResults":     "5",
      "groupBy":        "road,emptyRoad"
    ]
    
    // make API call, and deal with the results
    self.swiftComplete.performRequest(path: W3WSwiftCompleteSettings.swiftCompletePath, params: params) { code, json, error in
      self.makeAddressDescriptionResponse(words: near, lastResult: nil, code: code, json: json, error: error, completion: completion)
    }
  }
  
  
  
  /// given a node in the tree, call for sub nodes
  /// - parameter from: the node to search with
  /// - parameter completion: called with child tree nodes when they are retrieved
  public func list(from: W3WValidatorNodeList, completion: @escaping ([W3WValidatorNode], W3WAddressFinderError?) -> ()) {

    // set up the parameters
    var params:[String:String] = [
      "distanceUnits":  "METRIC"
    ]

    // add optional parameters
    if let id = from.code {
      if id.contains("§") {
        let pieces = id.split(separator: "§")
        if pieces.count == 2 {
          params["container"] = String(pieces[1])
        } else {
          print("possible error, investigate")
        }
      } else {
        params["container"] = id
      }
    }

    // add the three word address if available
    if let words = from.words {
      params["biasTowards"] = "///" + words
    }
    
    params["maxResults"] = "100"

    // call the api and deal with the result
    self.swiftComplete.performRequest(path: W3WSwiftCompleteSettings.swiftCompletePath, params: params) { code, json, error in
      self.makeAddressDescriptionResponse(words: from.words ?? "", lastResult: from, code: code, json: json, error: error, completion: completion)
    }
  }

  
  /// get detialed info for a particular node
  /// - parameter for: the node to get details from
  /// - parameter completion: called with a detailed address result
  public func info(for leaf: W3WValidatorNodeLeaf, completion: @escaping (W3WValidatorNodeLeafInfo?, W3WAddressFinderError?) -> ()) {
    
    // if there is an id for this node
    if let encodedId = leaf.code {
      // ids are stored before a `§` separator in the code
      if encodedId.contains("§") {
        let pieces = encodedId.split(separator: "§")
        if pieces.count == 2 {
          let index = pieces[0]
          let code = pieces[1]

          // set up the parameters for the api call
          let params:[String:String] = [
            "distanceUnits":  "METRIC",
            "populateIndex":  "\(index)",
            "lineFormat\(W3WStreetAddressParts.address.rawValue)":   "Company, SubBuilding, BuildingName",
            "lineFormat\(W3WStreetAddressParts.number.rawValue)":    "BuildingNumber",
            "lineFormat\(W3WStreetAddressParts.street.rawValue)":    "SecondaryRoad, Road",
            "lineFormat\(W3WStreetAddressParts.locality.rawValue)":  "TertiaryLocality, SecondaryLocality, PRIMARYLOCALITY",
            "lineFormat\(W3WStreetAddressParts.city.rawValue)":      "TertiaryLocality, SecondaryLocality, PRIMARYLOCALITY",
            "lineFormat\(W3WStreetAddressParts.postCode.rawValue)":  "POSTCODE",
            "lineFormat\(W3WStreetAddressParts.country.rawValue)":   "Country",
            "maxResults":     "100",
            "container":      String(code)
          ]

          // call the service and deal with results, and error out gracefully on any issues that arise
          self.swiftComplete.performRequest(path: W3WSwiftCompleteSettings.swiftCompletePath, params: params) { code, json, error in
            if let j = json {
              self.parseAddress(index: Int(index) ?? 0, words: leaf.words ?? "", lastResult: leaf, json: j) { address, error in
                completion(address, error)
              }
              
            } else {
              completion(nil, W3WAddressFinderError.server(error?.localizedDescription ?? "Unknown"))
            }
          }
        } else {
          completion(nil, W3WAddressFinderError.serious("No address found at the index returned by Swift Complete"))
        }
        
      } else {
        completion(nil, W3WAddressFinderError.serious("internal error: leafId - bad encoding"))
      }
      
    } else {
      //completion(W3WStreetAddress(id: leaf.code, address: leaf.name, street: nil, city: nil, postalCode: nil, country: nil))
      completion(nil, W3WAddressFinderError.infoCalledOnNonLeafValue)
    }
  }
  
  
  /// parse JSON data
  func makeAddressDescriptionResponse(words: String, lastResult: W3WValidatorNodeList?, code: Int?, json: Data?, error: W3WAddressFinderError?, completion: @escaping ([W3WValidatorNode], W3WAddressFinderError?) -> ()) {
    if let j = json {
      if code == 200 {
        parseAddresses(words: words, lastResult: lastResult, json: j, completion: completion)
      } else {
        parseErrors(json: j, completion: completion)
      }
    }
  }
  
  
  /// parse errors from JSON data
  func parseErrors(json: Data, completion: @escaping ([W3WValidatorNodeList], W3WAddressFinderError?) -> ()) {
    let jsonDecoder = JSONDecoder()
    
    if let errors = try? jsonDecoder.decode(SwiftCompleteErrors.self, from: json) {
      print(errors)
      completion([], W3WAddressFinderError.server(errors.error?.description ?? "Unknown Error"))
      return
      
    } else if let errors = try? jsonDecoder.decode(SwiftCompleteSimpleError.self, from: json) {
      print(errors)
      completion([], W3WAddressFinderError.server(errors.error?.description ?? "Unknown Error"))
      return
    }
    
    completion([], W3WAddressFinderError.server("Unknown Error"))
  }
  
  
  /// parse out address info from JSON data
  func parseAddress(index: Int, words: String, lastResult: W3WValidatorNodeLeaf?, json: Data, completion: @escaping (W3WValidatorNodeLeafInfo, W3WAddressFinderError?) -> ()) {
    let jsonDecoder = JSONDecoder()
    
    if let data = try? jsonDecoder.decode([SwiftCompleteJson].self, from: json) {
      let result = data[index]
      if let record = result.populatedRecord {
        let id = (result.container ?? lastResult?.code) ?? ""
        
        let country = record.lines?[W3WStreetAddressParts.country.rawValue]
        
        var address: W3WStreetAddressProtocol!
        if country == "United Kingdom" {
          
          address = W3WStreetAddressUK(
            words: words,
            address: getValue(values: record.lines, index: W3WStreetAddressParts.address.rawValue),
            street: getValues(values: record.lines, indexes: [W3WStreetAddressParts.number.rawValue, W3WStreetAddressParts.street.rawValue], separator: " "),
            locality: getValue(values: record.lines, index: W3WStreetAddressParts.locality.rawValue),
            postCode: getValue(values: record.lines, index: W3WStreetAddressParts.postCode.rawValue),
            country: getValue(values: record.lines, index: W3WStreetAddressParts.country.rawValue)
          )
        } else {
          address = W3WStreetAddressGeneric(
            words: words,
            address: getValue(values: record.lines, index: W3WStreetAddressParts.address.rawValue),
            street: getValues(values: record.lines, indexes: [W3WStreetAddressParts.number.rawValue, W3WStreetAddressParts.street.rawValue], separator: " "),
            city: getValue(values: record.lines, index: W3WStreetAddressParts.city.rawValue),
            postCode: getValue(values: record.lines, index: W3WStreetAddressParts.postCode.rawValue),
            country: getValue(values: record.lines, index: W3WStreetAddressParts.country.rawValue)
          )
        }
        
        completion(W3WValidatorNodeLeafInfo(id: id, words: words, address: address), nil)
      }
    }
  }
  
  
  /// parse out address info from JSON data
  func parseAddresses(words: String, lastResult: W3WValidatorNodeList?, json: Data, completion: @escaping ([W3WValidatorNode], W3WAddressFinderError?) -> ()) {
    let jsonDecoder = JSONDecoder()
    
    if let data = try? jsonDecoder.decode([SwiftCompleteJson].self, from: json) {
      var addresses = [W3WValidatorNode]()
      
      for (index, result) in data.enumerated() {

        if result.isContainer == true {
          addresses.append(W3WValidatorNodeList(id: result.container ?? "", words: words, name: result.primary?.text ?? "", nearestPlace: result.secondary?.text ?? "")) //, address: address))
          
        } else {
          addresses.append(W3WValidatorNodeLeaf(id: "\(index)§\(lastResult?.code ?? "")", words: words, name: result.primary?.text ?? "", nearestPlace: result.secondary?.text ?? "")) //, address: address))
        }
      }
      
      completion(addresses, nil)
      return
    }
  }
  
  
  /// get the value from an array, but if the value is a string on length zero, return nil
  func getValue(values: [String]?, index: Int) -> String? {
    if let v = values {
      if v.count > index {
        let x = v[index]
        if x.count == 0 {
          return nil
        } else {
          return x
        }
      }
    }

    return nil
  }
  
  
  /// get a bunch of values on one line
  func getValues(values: [String]?, indexes: [Int], separator: String = ", ") -> String? {
    var retval = [String]()
    
    for index in indexes {
      if let v = getValue(values: values, index: index) {
        retval.append(v)
      }
    }
    
    let r = retval.joined(separator: separator)
    
    if r.count == 0 {
      return nil
    } else {
      return r
    }
  }
  
}

