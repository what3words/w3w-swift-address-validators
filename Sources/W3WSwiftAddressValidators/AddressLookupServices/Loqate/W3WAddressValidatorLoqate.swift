//
//  File.swift
//  
//
//  Created by Dave Duprey on 05/11/2021.
//

import Foundation
import W3WSwiftApi
import CoreLocation



/// Loqate Api wrapper
public class W3WAddressValidatorLoqate: W3WAddressValidatorProtocol {
 
  /// the loqate Api service
  let loqate: W3WRequest!

  /// the what3words SDK or API
  let w3w: W3WProtocolV3!
  
  /// the API results stored in a tree of loqate nodes
  var resultsTree: W3WLoqateTree!
  
  
  /// the name of the service
  public var name: String {
    get {
      return "Loqate"
    }
  }
  
  
  /// this service does support sub item counts
  public var supportsSubitemCounts: Bool {
    get {
      return true
    }
  }

  
  
  /// Loqate Api wrapper
  /// - parameter w3w: the what3words API or SDK
  /// - parameter key: your Loqate Api key
  public init(w3w: W3WProtocolV3, key: String) {
    self.w3w    = w3w
    self.loqate = W3WRequest(baseUrl: W3WLocateSettings.loqateHost, parameters: ["Key" : key])
  }
  
  
  deinit {
    cancel()
  }

  
  
  /// searches near a three word address
  /// - parameter near: the three word address to search near
  /// - parameter completion: called with new nodes when they are available from the call
  public func search(near: String, completion: @escaping  ([W3WValidatorNode], W3WAddressValidatorError?) -> ()) {

    // convert three word address to coordinates
    w3w.convertToCoordinates(words: near) { square, error in
      if let square = square {
        if let coordinates = square.coordinates {
          let params = [
            "Latitude":   String(coordinates.latitude),
            "Longitude":  String(coordinates.longitude),
            "Items":      "100",
            "Radius":     "200"
          ]
          
          // make the top node in the reaults tree
          self.resultsTree = W3WLoqateTree(words: square.words ?? "?")
          
          // call the  Loqate Api
          self.loqate.performRequest(path: W3WLocateSettings.geolocationPath, params: params) { [square] code, json, error in
            self.makeAddressReverseGeoloate(square: square, code: code, json: json, error: error, completion: completion)
          }
        }
      }
    }
  }
  

  /// given a node in the tree, call for sub nodes
  /// - parameter from: the node to search with
  /// - parameter completion: called with child tree nodes when they are retrieved
  public func list(from: W3WValidatorNodeList, completion: @escaping ([W3WValidatorNode], W3WAddressValidatorError?) -> ()) {
    
    // if the data we want is already in the tree, then return it
    if let children = from.children {
      completion(children, nil)

    // if the data we want isn't found then call Loqate
    } else  if let id = from.code {
      
      // set up the call
      let params = [
        "Id": id,
      ]
      
      // call Loqate
      self.loqate.performRequest(path: W3WLocateSettings.retrievePath, params: params) { [from] code, json, error in
        self.makeAddressRetrieveResponse(words: from.words ?? "", code: code, json: json, error: error, completion: completion)
      }
    }
  }
  
  
  /// get detialed info for a particular node
  /// - parameter for: the node to get details from
  public func info(for leaf: W3WValidatorNodeLeaf, completion: @escaping (W3WValidatorNodeLeafInfo?, W3WAddressValidatorError?) -> ()) {
    // set up the call
    let params = [
      "Id": leaf.code ?? ""
    ]
    
    // call Loqate
    self.loqate.performRequest(path: W3WLocateSettings.retrievePath1_2, params: params) { code, json, error in

      // notify about any error
      if let e = error {
        completion(nil, W3WAddressValidatorError.server(e.description))

      // parse the resulting JSON
      } else {
        self.parseAddress(words: leaf.words ?? "", lastResult: leaf, json: json, completion: completion)
      }
    }
  }
  
  
  /// cancel any active API calls
  public func cancel() {
    loqate.cancel()
  }

  
  
  /// parse the JSON for an address
  func parseAddress(words: String, lastResult: W3WValidatorNodeLeaf?, json: Data?, completion: @escaping (W3WValidatorNodeLeafInfo, W3WAddressValidatorError?) -> ()) {
    let jsonDecoder = JSONDecoder()

    // if the JSON looks good
    if let j = json {
      if let data = try? jsonDecoder.decode(W3WLoqateRetrieve.self, from: j) {
        if let item = data.items?.first {
          let id = (item.id ?? lastResult?.code) ?? ""

          // note the country
          let country = item.countryIso2

          // set up the variable for the result
          var address: W3WStreetAddressProtocol!

          let fields = [item.company, item.line1, item.line2, item.line3, item.line4, item.line5]
          let topField = firstNonNull(of: fields).first
          let restOfFields = fields.filter({ x in x != topField })

          // if the address is in the United Kindgom, make one for that
          if country == "GB" {
            address = W3WStreetAddressUK(
              words: words,
              address: topField, // makeField(from: [item.company]),
              street: makeField(from: restOfFields, separator: ", "), // makeField(from: [item.subBuilding, item.buildingNumber, item.street]),
              locality: nil, //makeField(from: [item.line1, item.line2, item.line3, item.line4]),
              postCode: makeField(from: [item.postalCode]),
              country: country
            )
          
          // if the address is not in a country for which we have a specific structure then make a generic one
          } else {
            address = W3WStreetAddressGeneric(
              words: words,
              address: topField, // makeField(from: [item.line1, item.department, item.company]),
              street: makeField(from: restOfFields, separator: ", "), // makeField(from: [item.buildingNumber, item.subBuilding, item.street]),
              city: makeField(from: [item.city]),
              postCode: makeField(from: [item.postalCode]),
              country: country
            )
          }

          // send the result back to whoever wants it
          completion(W3WValidatorNodeLeafInfo(id: id, words: words, address: address), nil)
        }
      }
    }
  }

  
  /// given raw JSON data, and a w3w square, build out the result tree
  func makeAddressReverseGeoloate(square: W3WSquare, code: Int?, json: Data?, error: W3WAddressValidatorError?, completion: @escaping ([W3WValidatorNode], W3WAddressValidatorError?) -> ()) {
    
    // if the JSON is good
    if let j = json {
      let jsonDecoder = JSONDecoder()
      
      // decode the JSON
      if let data = try? jsonDecoder.decode(W3WLoqateGeolocationResponse.self, from: j) {
        
        // pull the data out of the JSON
        self.loqateGeolocationResponse(square: square, data: data, completion: completion)
      }
    }
  }


  /// pull data out of a JSON structure and build the results tree
  func loqateGeolocationResponse(square: W3WSquare, data: W3WLoqateGeolocationResponse, completion: @escaping ([W3WValidatorNode], W3WAddressValidatorError?) -> ()) {
    var itemPairs = [(W3WLoqateItems, W3WLoqateItems)]()
    
    // launch into multiple API calls, but wait until they are all complate
    let group = DispatchGroup()
    for item in data.items ?? [] {
      
      // check for error
      if item.id == nil && item.type == nil && item.text == nil {
        completion([], W3WAddressValidatorError.server(item.description ?? "unknown error"))
        return
                   
      // data looks good, make items
      } else {
        group.enter()
        self.captureInteractiveFind(square: square, item: item) { [item] items in
          if let i = items?.first {
            itemPairs.append((item, i))
          }
          group.leave()
        }
      }
    }
    
    // once all calls are finished we run this closure
    group.notify(queue: .main) {
      // build out the reults tree with the data
      self.resultsTree.buildTree(itemPairs: itemPairs)
      
      // take the Loqate nodes and convert them to data compatible with the AddressVerificationProtocol
      let nodes = self.loqateTreeToAddressList(square: square)
      
      // send back the results
      completion(nodes, nil)
    }
  }


  
  /// take the Loqate nodes and convert them to data compatible with the AddressVerificationProtocol
  func loqateTreeToAddressList(square: W3WSquare) -> [W3WValidatorNode] {
    return makeNode(from: resultsTree.tree, square: square)
  }
    
  
  /// recursively take the Loqate nodes and convert them to data compatible with the AddressVerificationProtocol
  func makeNode(from: W3WLoqateNode?, square: W3WSquare) -> [W3WValidatorNode] {
    var results = [W3WValidatorNode]()

    for node in from?.children ?? [] {
      if node.children.count > 0 {
        let listNode = W3WValidatorNodeList(id: node.parent?.id, words: square.words, name: node.title, nearestPlace: divineDescription(node: node, square: square), subItemCount: node.countAllChildren())
        results.append(listNode)
        listNode.children = makeNode(from: node, square: square)
      } else {
        results.append(W3WValidatorNodeLeaf(id: node.parent?.id, words: square.words, name: node.title, nearestPlace: divineDescription(node: node, square: square)))
      }
    }
    
    return results
  }
  
  
  /// extrapolate a description from the loqate data
  func divineDescription(node: W3WLoqateNode, square: W3WSquare) -> String {
    var description = node.description
    
    if description == nil || description?.count == 0 {
      description = square.nearestPlace
    }
    
    if description == nil || description?.count == 0 {
      description = node.parent?.description
    }
    
    return description ?? ""
  }
  
  
  /// debug printout for the loqate results tree
  func printTree(node: W3WLoqateNode?, level: Int = 0) {
    if level == 0 {
      print("\n==============================")
    }
    if let node = node {
      print(level, String(repeating: "  ", count: level), node.title, "   [", node.description ?? "nil", "]")
      for n in node.children {
        printTree(node: n, level: level + 1)
      }
    }
  }
  
  
  /// call Loqate's findPath for a given item and return a list of Loqate nodes
  func captureInteractiveFind(square: W3WSquare, item: W3WLoqateItems, completion: @escaping ([W3WLoqateItems]?) -> ()) {
    
    // set up the call
    var params = [
      "Text":   (item.text ?? "") + " " + (item.description ?? ""),
      "IsMiddleware":   "true",
    ]

    // include the coordinates if any
    if let coordinates = square.coordinates {
      params["Origin"] = String(coordinates.latitude) + "," + String(coordinates.longitude)
    }
    
    // make the API call
    self.loqate.performRequest(path: W3WLocateSettings.findPath, params: params) { code, json, error in
      if let j = json {
        let jsonDecoder = JSONDecoder()
        
        // if the data is good then return it
        if let data = try? jsonDecoder.decode(W3WLocateFindpathResponse.self, from: j) {
          completion(data.items)
        }
      }
    }
  }
  
  
  /// given some JSON make a list of addresses
  func makeAddressRetrieveResponse(words: String, code: Int?, json: Data?, error: W3WAddressValidatorError?, completion: @escaping ([W3WValidatorNodeList], W3WAddressValidatorError?) -> ()) {
      if let j = json {
        let jsonDecoder = JSONDecoder()
        
        if let data = try? jsonDecoder.decode(W3WLoqateFullAddresses.self, from: j) {
          var addresses = [W3WValidatorNodeList]()
          for item in data.items ?? [] {
            var addressStringArray = [String]()
            if let a = item.line1 { addressStringArray.append(a) }
            if let a = item.line2 { addressStringArray.append(a) }
            if let a = item.line3 { addressStringArray.append(a) }
            if let a = item.line4 { addressStringArray.append(a) }
            if let a = item.line5 { addressStringArray.append(a) }

            let address = W3WValidatorNodeList(
              //type: (item.id == nil || item.id == "") ? .list : .address,
              id: item.id,
              words: words,
              name: (item.label ?? "Unknown:").replacingOccurrences(of: "\n", with: " "),
              nearestPlace: (((item.neighbourhood ?? item.district) ?? item.province) ?? item.street) ?? ""
              //address: W3WStreetAddress(address: item.line1, street: item.street, city: item.city, postalCode: item.postalCode, country: item.countryName)
            )
            addresses.append(address)
          }
          completion(addresses, nil)
          return
        }
      }
      completion([], nil)
  }
  
  
  /// Convert array of coordinates to the following format
  /// [[{"lat":52.19400128,"lon":-2.225029029},{"lat":52.18557324,"lon":-2.220275221},{"lat":52.18708847,"lon":-2.205246038},{"lat":52.19734151,"lon":-2.211512537},{"lat":52.19400128,"lon":-2.225029029}]]
  func toParameterString(coordinates: [CLLocationCoordinate2D]) -> String {
    var stringCoordinateArray = [String]()
    
    for coordinate in coordinates {
      stringCoordinateArray.append("{\"lat\":\(coordinate.latitude),\"lon\":\(coordinate.longitude)}")
    }
    
    return "[[" + stringCoordinateArray.joined(separator: ",") + "]]"
  }
  
  
  // MARK: Geographical math
  
  
  func geofence(around: CLLocationCoordinate2D, radiusDegrees: Double, points: Double = 8.0) -> [CLLocationCoordinate2D] {
    var fence = [CLLocationCoordinate2D]()

    // make a circle around the central point
    for i in stride(from: 0.0, to: .pi * 2.0, by: .pi / points * 2.0)  {
      fence.append(CLLocationCoordinate2D(latitude: cos(i) * radiusDegrees + around.latitude, longitude: sin(i) * radiusDegrees + around.longitude))
    }
    
    // cloase the fence
    fence.append(CLLocationCoordinate2D(latitude: cos(0.0) * radiusDegrees + around.latitude, longitude: sin(0.0) * radiusDegrees + around.longitude))

    return fence
  }
  
  
}
