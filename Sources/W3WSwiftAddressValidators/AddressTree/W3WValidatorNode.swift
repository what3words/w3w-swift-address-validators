//
//  File.swift
//  
//
//  Created by Dave Duprey on 15/12/2021.
//

import Foundation
import W3WSwiftApi


/// a basic address node
public class W3WValidatorNode {
  
  /// three word address
  public var words: String?
  
  /// name for this node
  public var name: String = "?"
  
  /// nearest place to this node
  public var nearestPlace: String?
  
  /// code used to ind children nodes on subsequent API calls
  var code: String? = nil
}


