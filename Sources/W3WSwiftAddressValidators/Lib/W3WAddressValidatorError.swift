//
//  File.swift
//  
//
//  Created by Dave Duprey on 05/11/2021.
//

import Foundation


/// Main error enum for the w3w API
public enum W3WAddressValidatorError : Error, CustomStringConvertible, Equatable {
  
  // Internal Errors
  case serious(String)
  
  // API Errors
  case badConnection
  case badJson
  case invalidResponse
  case invalidThreeWordAddress
  case infoCalledOnNonLeafValue
  case missingAddressInfo
  case server(String)

  /// human readable error messsage
  public var description : String {
    switch self {
    case .serious(let message):     return "Internal error: " + message
    case .badConnection:            return "Couldn't connect to server"
    case .badJson:                  return "Malformed JSON returned"
    case .invalidResponse:          return "Invalid Response"
    case .invalidThreeWordAddress:  return "Invalid three word address used"
    case .infoCalledOnNonLeafValue: return "Bad value passed to info()"
    case .missingAddressInfo:       return "Address info was missing from the cache"
    case .server(let errorString):  return errorString
    }
  }
  
  /// allow this to conform to Equitable
  public static func == (lhs: W3WAddressValidatorError, rhs: W3WAddressValidatorError) -> Bool {
    return lhs.description == rhs.description
  }
  

}
