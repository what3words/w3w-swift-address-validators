//
//  File.swift
//  
//
//  Created by Dave Duprey on 29/11/2021.
//

import Foundation


/// a leaf node with the complete address contained within
/// this is usually a child of a plain leaf.  It is an additional
/// node mostly because retrieving the full address from a service
/// is the money call, and we show it's parent `W3WStreetAddressNodeLeaf`
/// to the user first to verify the call to the service
public class W3WValidatorNodeLeafInfo: W3WValidatorNode {
  
  /// full address details
  public var address: W3WStreetAddressProtocol?
  
  /// a leaf node with the complete address contained within
  /// - parameter id: the id for this node
  /// - parameter address: the address to be stored in this node
  init(id: String?, words: String?, address: W3WStreetAddressProtocol) {
    self.address = address
    
    super.init()
    
    self.code = id
    self.words = words
    self.name = address.shortDescription
  }

}






//enum W3WUniversalStreetAddress: CustomStringConvertible {
//  case uk(W3WStreetAddressUK)
//  case other(W3WStreetAddressGeneric)
//
//  public var description : String {
//    switch self {
//    case .uk(let address): return address.description
//    case .other(let address): return address.description
//    }
//}


//  public var placeName: String?
//  public var suite: String?
//  public var number: String?
//  public var street: String?
//  public var locality: String?
//  public var city: String?
//  public var country: String?
//  public var postCode: String?


//  public let address: String?
//  public let street: String?
//  public let city: String?
//  public let postalCode: String?
//  public let country: String?



//  init(id: String?, words: String?, address: String?, street: String?, city: String?, postalCode: String?, country: String?) {
//    self.address = address
//    self.street = street
//    self.city = city
//    self.postalCode = postalCode
//    self.country = country
//
//    super.init()
//
//    self.code = id
//    self.words = words
//    self.type = .address
//    self.name = "\(address ?? "") \(street ?? "")"
//  }

