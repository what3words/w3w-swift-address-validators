//
//  File.swift
//  
//
//  Created by Dave Duprey on 14/01/2022.
//

import Foundation
//import CoreLocation


public enum W3WStreeetAddressKey: String {
  case words = "words"
  case address = "address"
  case street = "street"
  case locality = "locality"
  case city = "city"
  case postCode = "postCode"
  case country = "country"
  case unknown = "unknown"
}


/// protocol for what an address should do in it's most basic form
public protocol W3WStreetAddressProtocol: CustomStringConvertible {
  
  /// the three words for the address
  var words: String? { get }
  
  /// maybe add coordinates?
  //var coordinates: CLLocationCoordinate2D
  
  /// a human readable form of the address
  var description: String { get }
  
  /// a short human redable form of the address
  var shortDescription: String { get }
  
  /// an array containing all the available fields
  var values: [W3WStreeetAddressKey:String?] { get }
}
