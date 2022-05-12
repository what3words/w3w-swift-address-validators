//
//  File.swift
//  
//
//  Created by Dave Duprey on 25/03/2022.
//

import Foundation



/// Node for a tree of loqate information
class W3WLoqateNode {
  
  // title of the node
  var title: String
  
  // description of the node
  var description: String?
  
  // parent node
  var parent: W3WLoqateItems?
  
  // children of this node
  var children: [W3WLoqateNode]
  
  /// Node for a tree of loqate information
  /// - parameter title: title of the node
  /// - parameter description: description of the node
  /// - parameter parentNode: parent node pointer
  /// - parameter children: children of this node
  init(title: String, description: String?, parentNode: W3WLoqateItems? = nil) {
    self.title = title
    self.description = description
    self.parent = parentNode
    self.children = []
  }
  
  
  // return a count of all the children of a particular node
  func countAllChildren() -> Int {
    var count = children.count
    
    for child in children {
      count += child.countAllChildren()
    }
    
    return count
  }
  
}


