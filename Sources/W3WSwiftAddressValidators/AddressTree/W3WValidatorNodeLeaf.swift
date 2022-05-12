//
//  File.swift
//  
//
//  Created by Dave Duprey on 29/11/2021.
//

import Foundation


/// a result "leaf" node that is at the bottom of the address tree
public class W3WValidatorNodeLeaf: W3WValidatorNode {
  
  /// a result "leaf" node that is at the bottom of the address tree
  /// - parameter id: id for the node
  /// - parameter words: the three word address for this node
  /// - parameter name: the name for this node
  /// - parameter nearestPlace: a nearest place descriptor
  public init(id: String? = nil, words: String?, name: String = "?", nearestPlace: String?) {
    super.init()
    self.words = words
    self.nearestPlace = nearestPlace
    self.code = id
    self.name = name
  }

  
}

