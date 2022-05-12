//
//  File.swift
//  
//
//  Created by Dave Duprey on 14/01/2022.
//

import Foundation


/// a struct representing a United Kingdom address
public struct W3WStreetAddressUK: W3WStreetAddressProtocol {
  public var words: String?
  public var address: String?
  public var street: String?
  public var locality: String?
  public var postCode: String?
  public var country: String?
  public var values: [String:Any?] {
    get {
      return [
        "words":words,
        "address":address,
        "street":street,
        "locality":locality,
        "postCode":postCode,
        "country":country
        ]
    }
  }


  /// a human readable form of the address
  public var description : String {
    get {
      var output = ""
      if let x = address    { output += x + "\n" }
      if let x = street     { output += x + "\n" }
      if let x = locality   { output += x + "\n" }
      if let x = postCode   { output += x + "\n" }
      if let x = country    { output += x + "\n" }
      return output
    }
  }
  
  
  /// a short human readable form of the address
  public var shortDescription: String {
    get {
      return (address ?? "") + ((((street ?? locality) ?? postCode) ?? country) ?? "")
    }
  }

}
