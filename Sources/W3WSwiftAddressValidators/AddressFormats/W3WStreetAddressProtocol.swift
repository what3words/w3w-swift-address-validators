//
//  File.swift
//  
//
//  Created by Dave Duprey on 14/01/2022.
//

import Foundation


/// protocol for what an address should do in it's most basic form
public protocol W3WStreetAddressProtocol: CustomStringConvertible {
  
  /// the three words for the address
  var words: String? { get }
  
  /// a human readable form of the address
  var description: String { get }
  
  /// a short human redable form of the address
  var shortDescription: String { get }
  
  /// an array containing all the available fields
  var values: [String:Any?] { get }
}
