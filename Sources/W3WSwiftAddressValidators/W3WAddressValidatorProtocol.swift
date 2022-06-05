//
//  File.swift
//  
//
//  Created by Dave Duprey on 04/11/2021.
//
//  This is a "wrapper" for address validation services
//  Such as Data8, Loqate, and Swift Complete.  It provides
//  a single interface for applications that is agnostic
//  to the services used.  The protocol defined in this
//  file, `W3WStreetAddressLookupProtocol` is this interface

import Foundation


public protocol W3WAddressValidatorProtocol {
  
  /// the name of the service
  var name: String { get }
  
  /// indicates if the service can provide sub item counts
  var supportsSubitemCounts: Bool { get }
  
  
  /// searches near a three word address
  /// - parameter near: the three word address to search near
  /// - parameter completion: called with new nodes when they are available from the call
  func search(near: String, completion: @escaping  ([W3WValidatorNode], W3WAddressValidatorError?) -> ())
  
  
  /// given a node returned from a previous call, get any child nodes
  /// - parameter from: the node to search with
  /// - parameter completion: called with child tree nodes when they are retrieved
  func list(from: W3WValidatorNodeList, completion: @escaping  ([W3WValidatorNode], W3WAddressValidatorError?) -> ())
  
  
  /// get detailed info for a particular leaf node returned from a previous call
  /// - parameter for: the node to get details for
  /// - parameter completion: called with a detailed address result
  func info(for: W3WValidatorNodeLeaf, completion: @escaping (W3WValidatorNodeLeafInfo?, W3WAddressValidatorError?) -> ())
  
  
  /// cancel any active tasks
  func cancel()
}


