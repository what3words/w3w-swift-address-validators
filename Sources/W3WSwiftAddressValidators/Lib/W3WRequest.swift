//
//  File.swift
//
//
//  Created by Dave Duprey on 02/11/2020.
//  Copyright © 2020 What3Words. All rights reserved.
//

import Foundation
import CoreLocation
#if canImport(UIKit)
import UIKit
#endif
#if os(watchOS)
import WatchKit
#endif


/// closure definition for internal HTTP requests
public typealias W3WRequestResponse = ((_ code: Int?, _ result: Data?, _ error: W3WAddressValidatorError?) -> Void)


/// the method for the HTTPS request
public enum W3WRequestMethod: String {
  case get = "GET"
  case post = "POST"
}


/// A base class for making API calls to a service
public class W3WRequest {

  var baseUrl        = ""
  var parameters = [String:String]()
  var headers    = [String:String]()
  
  var task: URLSessionDataTask?
  
  // MARK: Constructors
  
  /// Initialize the API wrapper
  /// - Parameters:
  ///     - apiKey: Your api key.  Register for one at: https://accounts.what3words.com/create-api-key
  public init(baseUrl: String, parameters: [String:String] = [:], headers: [String:String] = [:]) {
    self.baseUrl = baseUrl
    set(parameters: parameters)
    set(headers: headers)
  }
  
  
  // MARK: Accessors
  
  /**
   Sets headers for every subsequent call
   - parameter headers: additional HTTP headers to send on requests - for enterprise customers
   */
  public func set(headers: [String: String]) {
    self.headers = headers
  }
  
  
  /**
   Sets parameters for every subsequent call
   - parameter parameters: additional HTTP headers to send on requests - for enterprise customers
   */
  public func set(parameters: [String: String]) {
    self.parameters = parameters
  }
  
  
  // MARK: HTTP Request
  
  
  /**
   Calls w3w URL
   - parameter path: The URL to call
   - parameter params: disctionary of parameters to send on querystring
   - parameter completion: The completion handler
   */
  public func performRequest(path: String, params: [String:String]? = nil, json: [String:Any]? = nil, method: W3WRequestMethod = .get, completion: @escaping W3WRequestResponse) {
    
    // generate the request
    if let request = makeRequest(path: path, params: params, json: json, method: method) {
      
      // make the call
      task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        // deal with the results, and complete with the info
        self.processResults(data: data, response: response, error: error, completion: completion)
      }
      
      // start the call
      task?.resume()
      
    // if the request object couldn't be made
    } else {
      completion(nil, nil, W3WAddressValidatorError.serious("Could not instantiate URLRequest for " + path))
    }
  }
  
  
  public func cancel() {
    task?.cancel()
  }
  
  
  /**
   given a path and parameters, make a URLRequest object
   - parameter path: The URL to call
   - parameter params: disctionary of parameters to send on querystring
   */
  func makeRequest(path: String, params: [String:String]? = nil, json: [String:Any]? = nil, method: W3WRequestMethod = .get) -> URLRequest? {
    // prepare url components
    var urlComponents = URLComponents(string: baseUrl + path)!
    
    // add the persistant and current querystring variables
    var queryItems = [URLQueryItem]()
    for (name, value) in parameters {
      let item = URLQueryItem(name: name, value: value)
      queryItems.append(item)
    }
    
    // add any querystrng parameters
    if let p = params {
      for (name, value) in p {
        if value.contains("§") {
          print("ERROR §!")
        }
        
        let item = URLQueryItem(name: name, value: value)
        queryItems.append(item)
      }
    }
    urlComponents.queryItems = queryItems
    
    // create the URL
    if let url = urlComponents.url {
      // DEBUG
      print("calling: ", url)
      
      // create the request
      var request = URLRequest(url: url)
      
      // set the request method ie: GET, POST, etc
      request.httpMethod = method.rawValue

      // add any json
      if let j = json, let jsonData = try? JSONSerialization.data(withJSONObject: j) {
        request.httpBody = jsonData
      }
      

      // set headers
      for (name, value) in headers {
        request.setValue(value, forHTTPHeaderField: name)
      }
      
      return request
    }
    
    return nil
  }
  
  
  /**
   Calls w3w URL
   - parameter data: the returned data from the API
   - parameter error: an error if any
   - parameter completion: The completion handler
   */
  func processResults(data: Data?, response: URLResponse?, error: Error?, completion: @escaping W3WRequestResponse) {
    
    let code: Int? = (response as? HTTPURLResponse)?.statusCode
    //print("got results: ", code ?? -1)
    
    guard let data = data else {
      completion(code, nil, W3WAddressValidatorError.server(error?.localizedDescription ?? "unknown server error"))
      task = nil
      return
    }
    
    if data.count == 0 {
      completion(code, nil, nil)
      task = nil
      return
    }
    
    completion(code, data, nil)
    task = nil
  }
  
  
}
