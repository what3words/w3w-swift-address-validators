//
//  File.swift
//  
//
//  Created by Dave Duprey on 14/01/2022.
//

import Foundation


/// generic address struct, for use with unknown countries
public struct W3WStreetAddressGeneric: W3WStreetAddressProtocol {
  public var words: String?
  public var address: String?
  public var street: String?
  public var city: String?
  public var postCode: String?
  public var country: String?
  public var values: [W3WStreeetAddressKey:String?] {
    get {
      return [
        .words:words,
        .address:address,
        .street:street,
        .locality:city,
        .postCode:postCode,
        .country:country
      ]
    }
  }

  
  public var description : String {
    get {
      var output = ""
      if let x = address    { output += x + " " }
      if let x = street     { output += x + "\n" }
      if let x = city       { output += x + "\n" }
      if let x = postCode   { output += x + "\n" }
      if let x = country    { output += x + "\n" }
      return output
    }
  }
  
  
  public var shortDescription: String {
    get {
      return (address ?? "") + ((((street ?? city) ?? postCode) ?? country) ?? "")
    }
  }
  
}
