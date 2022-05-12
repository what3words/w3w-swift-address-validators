//
//  File.swift
//  
//
//  Created by Dave Duprey on 29/11/2021.
//

import Foundation


/// Data8 Api wrapper
public class W3WAddressValidatorData8: W3WAddressValidatorProtocol {

  /// represents the Data8 Api
  let data8: W3WRequest!
  
  /// obligatory service name
  public var name: String {
    get {
      return "Data8"
    }
  }
  
  /// this service supports sub item counting
  public var supportsSubitemCounts: Bool {
    get {
      return true
    }
  }

  
  /// Data8 Api wrapper
  /// - parameter key: your Data8 API key
  public init(key: String) {
    self.data8 = W3WRequest(baseUrl: W3WData8Settings.data8Host, parameters: ["key" : key])
    self.data8.set(headers: ["Referer": "w3w.co"])
  }

  
  /// searches near a three word address
  /// - parameter near: the three word address to search near
  /// - parameter completion: called with new nodes when they are available from the call
  public func search(near: String, completion: @escaping ([W3WValidatorNode], W3WAddressFinderError?) -> ()) {

    // set the Api parameters
    let json: [String: Any] = [
      "key":             data8.parameters["key"] ?? "",
      "search":          near,
      "country":         "GB",
      "options":         ["ApplicationName":Bundle.main.bundleIdentifier ?? "what3words"]
    ]
    
    // call Data8
    self.data8.performRequest(path: W3WData8Settings.data8Search, json: json, method: .post) { code, json, error in
      if error != nil {
        completion([], error)
        
      } else {
        if let j = json {
          if code == 200 {
            self.parseAddress(words: near, lastResult: nil, json: j, completion: completion)
          } else {
            self.parseErrors(code: code, json: j, completion: completion)
          }
        }
      }
      
    }
  }

  
  /// given a node in the tree, call for sub nodes
  /// - parameter from: the node to search with
  /// - parameter completion: called with child tree nodes when they are retrieved
  public func list(from: W3WValidatorNodeList, completion: @escaping ([W3WValidatorNode], W3WAddressFinderError?) -> ()) {
    
    // set up parameters
    let json: [String: Any] = [
      "key":             data8.parameters["key"] ?? "",
      "id":              from.code ?? "",
      "country":         "GB",
      "options":         ["ApplicationName":Bundle.main.bundleIdentifier ?? "what3words"]
    ]
    
    // call the Api
    self.data8.performRequest(path: W3WData8Settings.data8DrillDown, json: json, method: .post) { code, json, error in
      if error != nil {
        completion([], error)
      } else {
        if let j = json {
          if code == 200 {
            self.parseAddress(words: from.words ?? "", lastResult: nil, json: j, completion: completion)
          } else {
            self.parseErrors(code: code, json: j, completion: completion)
          }
        }
      }
      
    }
  }

  
  /// get detialed info for a particular node
  /// - parameter for: the node to get details from
  public func info(for leaf: W3WValidatorNodeLeaf, completion: @escaping (W3WValidatorNodeLeafInfo?, W3WAddressFinderError?) -> ()) {
  
    // set up parameters
    let json: [String: Any] = [
      "key":             data8.parameters["key"] ?? "",
      "id":              leaf.code ?? "",
      "country":         "GB",
      "options":         ["ApplicationName":Bundle.main.bundleIdentifier ?? "what3words"]
    ]
    
    // call the Api
    self.data8.performRequest(path: W3WData8Settings.data8Retrieve, json: json, method: .post) { code, json, error in
      if error != nil {
        completion(nil, error)
      } else {
        if let j = json {
          if code == 200 {
            self.parseLeaf(words: leaf.words ?? "", lastResult: nil, json: j, completion: completion)
          } else {
            self.parseErrors(code: code, json: j) { list, error in
              completion(nil, error)
            }
          }
        }
      }
      
    }
  }

  
  /// if an error was returned then parse it for error informaiton
  func parseErrors(code: Int?, json: Data, completion: @escaping ([W3WValidatorNodeList], W3WAddressFinderError?) -> ()) {
    let jsonDecoder = JSONDecoder()
    
    if let errors = try? jsonDecoder.decode(Data8Errors.self, from: json) {
      print(errors)
      completion([], W3WAddressFinderError.server(errors.status?.errorMessage ?? "Unknown Error"))
      return
      
    } else if let errors = try? jsonDecoder.decode(SwiftCompleteSimpleError.self, from: json) {
      print(errors)
      completion([], W3WAddressFinderError.server(errors.error?.description ?? "Unknown Error"))
      return

    } else if let code = code {
        completion([], W3WAddressFinderError.server("Error code \(code) returned from server"))

    } else {
      completion([], W3WAddressFinderError.server("Unknown error from server"))
    }
    
  }
  
  
  /// given result data, make the result ndoes
  func parseAddress(words: String, lastResult: W3WValidatorNodeLeaf?, json: Data, completion: @escaping ([W3WValidatorNode], W3WAddressFinderError?) -> ()) {
    let jsonDecoder = JSONDecoder()
    
    // decode JSON
    if let data = try? jsonDecoder.decode(Data8Json.self, from: json) {

      // prepare an array
      var addresses = [W3WValidatorNode]()
      
      // loop through JSON data
      for result in data.results ?? [] {
        
        // make a list node if there are a bunch of results
        if result.container == true {
          addresses.append(W3WValidatorNodeList(id: result.value, words: words, name: result.label ?? "", nearestPlace: "", subItemCount: result.items))
          
        // make a leaf node if this is a final address
        } else {
          addresses.append(W3WValidatorNodeLeaf(id: result.value, words: words, name: result.label ?? "", nearestPlace: ""))
        }
      }
      
      // complte this call
      completion(addresses, nil)
      return

    // return any error
    } else {
      completion([], W3WAddressFinderError.badJson)
    }
  }

  
  
  /// parse Json data for a leaf node
  func parseLeaf(words: String, lastResult: W3WValidatorNodeLeaf?, json: Data, completion: @escaping (W3WValidatorNodeLeafInfo?, W3WAddressFinderError?) -> ()) {
    let jsonDecoder = JSONDecoder()
    
    // parse JSON
    if let data = try? jsonDecoder.decode(FullAddress.self, from: json) {

      // prepare a variable to hold the result
      var address: W3WStreetAddressProtocol!
      
      // get address info
      if let fullAddress = data.result?.rawAddress {
      
        // if it's UK address make a UK result
        if fullAddress.countryISO2 == "GB" {
          
          address = W3WStreetAddressUK(
            words: words,
            address: makeField(from: [fullAddress.organisation]),
            street: makeField(from: [fullAddress.buildingNumber, fullAddress.subBuildingName, fullAddress.buildingName, fullAddress.thoroughfareName, fullAddress.dependentThoroughfareName, fullAddress.thoroughfareDesc, fullAddress.dependentThoroughfareDesc]),
            locality: fullAddress.locality,
            postCode: fullAddress.postcode,
            country: fullAddress.countryISO2
          )
          
        // otherwise we make a generic address struct and make some guesses
        } else {
          address = W3WStreetAddressGeneric(
            words: words,
            address: makeField(from: [fullAddress.organisation]),
            street: makeField(from: [fullAddress.buildingNumber, fullAddress.subBuildingName, fullAddress.buildingName, fullAddress.thoroughfareName, fullAddress.dependentThoroughfareName, fullAddress.thoroughfareDesc, fullAddress.dependentThoroughfareDesc]),
            city: fullAddress.locality,
            postCode: fullAddress.postcode,
            country: fullAddress.countryISO2
          )
        }
        
        // let the system know an address is founda nd ready
        completion(W3WValidatorNodeLeafInfo(id: lastResult?.code, words: words, address: address), nil)
        return
      }
    }

    // if nothing found then error out
    completion(nil, W3WAddressFinderError.badJson)
  }

  
}
