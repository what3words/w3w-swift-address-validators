//
//  File.swift
//  
//
//  Created by Dave Duprey on 29/11/2021.
//

import Foundation


/// an address node containing multiple children
public class W3WValidatorNodeList: W3WValidatorNode, CustomStringConvertible {
  
  /// number of children node (not available with every address service)
  public var subItemCount: Int?
  
  /// the child nodes
  public var children: [W3WValidatorNode]?
  
  /// an address node containing multiple children
  /// - parameter id: id for the node
  /// - parameter words: the three word address for this node
  /// - parameter nearestPlace: a nearest place descriptor
  /// - parameter subItemCount: the number of children this node has (optional)
  public init(id: String?, words: String?, name: String, nearestPlace: String, subItemCount: Int? = nil) { //}, address: W3WStreetAddress? = nil) {
    super.init()

    self.words = words
    self.nearestPlace = nearestPlace
    self.code = id
    self.name = name
    self.subItemCount = subItemCount
  }

  
  /// a text description of the address
  public var description: String {
    get {
      var output = ""
      output += name + "\n"
      if let x = nearestPlace { output += x + "\n" }
      return output
    }
  }
  
  
  /// add a child to the node, this updates the child count
  /// - parameter child: the child node to add
  func add(child: W3WValidatorNode) {
    if children == nil {
      children = []
    }
    
    children?.append(child)
    subItemCount = children?.count
  }
  
}
