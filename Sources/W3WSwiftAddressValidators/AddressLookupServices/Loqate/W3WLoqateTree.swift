//
//  File.swift
//  
//
//  Created by Dave Duprey on 25/03/2022.
//

import Foundation




/// A tree data structure for holding address information
class W3WLoqateTree {
  
  /// top of the tree
  var tree: W3WLoqateNode
  
  /// three word address that the tree is for
  var words: String

  
  /// A tree data structure for holding address information
  /// - parameter words: three word address that the tree is for
  init(words: String) {
    self.words = words
    self.tree  = W3WLoqateNode(title: words, description: nil, parentNode: nil)
  }
  
  
  /// Given a list of pairs of Loqate data, add child nodes to the current tree
  func buildTree(itemPairs: [(W3WLoqateItems, W3WLoqateItems)]) {
    for (item, detail) in itemPairs {
      let parts = makeParts(from: item, detail: detail)
      add(parts: parts, item: item, detail: detail)
    }
    
    // adjust tree so it's not too deep or shallow
    pruneTree(node: tree)
    
    // Debugging
    //printTree(node: tree)
  }
  
  
  /// adjust a tree begning with a node so it's not too deep or shallow
  /// - parameter node: the node to start the pruning with
  func pruneTree(node: W3WLoqateNode) {
    // organize the children to use the same level
    reorganizeTopLevelIfNeeded(node: node)
    
    // if the tree only has one child then bring it up a level
    collapseNode(node: tree)
    
    // if any child or progeny only has one child then recursively flatten the tree
    flattenOutSingleChildren(node: node)
  }
  
  
  /// if the any of the tree's progeny only has one child then bring it up a level
  /// - parameter node: the node to start with
  func flattenOutSingleChildren(node: W3WLoqateNode) {
    for child in node.children {
      flattenOutSingleChildren(node: child)
      collapseNode(node: child)
    }
  }
  
  
  /// if any child or progeny only has one child then recursively flatten the tree
  /// - parameter node: the node to start with
  func collapseNode(node: W3WLoqateNode) {
    if node.children.count == 1 {
      node.title = (node.children.first?.title ?? node.title) + " " + ((node.children.first?.description ?? node.description) ?? "")
      node.parent = node.children.first?.parent ?? node.parent
      node.description = node.children.first?.description ?? node.description
      node.children = node.children.first?.children ?? []
    }
  }
  
  
  /// make sure the top level of the tree is well balanced
  /// - parameter node: the node to start with
  func reorganizeTopLevelIfNeeded(node: W3WLoqateNode) {
    var reorganizedChildren = [W3WLoqateNode]()
    
    let compactList = titlesWithoutNumbers(node: node)
    
    if compactList.count != node.children.count {
      for titlePart in compactList {

        let newChild = getOrMakeNode(childrenOf: node, containing: titlePart)
        let selectNodes = findNodes(within: node.children, containing: titlePart)
        
        newChild.children.append(contentsOf: selectNodes)
        reorganizedChildren.append(newChild)
      }

      node.children = reorganizedChildren
    }
  }
  
  
  /// find a node or make one for the title in the parameter `containing`
  /// - parameter node: the node to start with
  /// - parameter containing: the title to find in the children
  func getOrMakeNode(childrenOf: W3WLoqateNode, containing: String) -> W3WLoqateNode {
    if let index = childrenOf.children.firstIndex(where: { n in n.title == containing } ) {
      let node = childrenOf.children[index]
      childrenOf.children.remove(at: index)
      return node
    } else {
      return W3WLoqateNode(title: containing, description: childrenOf.title, parentNode: nil)
    }
  }
  
  
  /// find a node
  /// - parameter within: the node to start with
  /// - parameter containing: the title to find in the children
  func findNodes(within: [W3WLoqateNode], containing: String) -> [W3WLoqateNode] {
    var nodes = [W3WLoqateNode]()
    
    for node in within {
      if node.title.contains(containing) {
        nodes.append(node)
      }
    }

    return nodes
  }
  
  
  /// make an array of string with just street names removing the numbers
  /// - parameter node: the node to start with
  func titlesWithoutNumbers(node: W3WLoqateNode) -> [String] {
    var strings = [String]()

    for n in node.children {
      let s = trim(text: n.title, removingNumbers: true)
      if !strings.contains(s) {
        strings.append(s)
      }
    }

    return strings
  }
  
  
  /// make an array of strings from the nodes and details of those nodes
  /// - parameter from: the list of nodes
  /// - parameter detail: the matching nodes with more detail
  func makeParts(from: W3WLoqateItems, detail: W3WLoqateItems) -> [String] {
    var parts = [String]()
    
    let text = detail.text
    let backwardParts = text?.components(separatedBy: ",")
    let untrimmedParts = backwardParts?.reversed()

    if let up = untrimmedParts {
      for part in up {
        parts.append(trim(text: part))
      }
    }
    
    return parts
  }
  
  
  /// add an array of children to the the tree finding the right place for them
  /// - parameter parts: array of strings with street names and such
  /// - parameter items: the list of nodes
  /// - parameter detail: the matching nodes with more detail
  func add(parts: [String], item: W3WLoqateItems, detail: W3WLoqateItems) {
    var currentNode = tree
    var description = ""
    
    for part in parts {
      if let node = currentNode.children.first(where: { n in n.title == part } ) {
        currentNode = node
        
      } else {
        let n = W3WLoqateNode(title: part, description: description, parentNode: detail)
        currentNode.children.append(n)
        currentNode = n
      }
      
      // append 'part' with or without a separating comma depending on position
      description += description.count > 0 ? (", " + part) : part
    }
  }
  
  
  /// print out the tree for debugging purposes
  /// - parameter node: the node to start with
  /// - parameter level: the level of depth for the current recusive call
  func printTree(node: W3WLoqateNode?, level: Int = 0) {
    if level == 0 {
      print("\n==============================")
    }
    if let node = node {
      print(level, String(repeating: "  ", count: level), node.title, "   [", node.description ?? "nil", "]")
      for n in node.children {
        printTree(node: n, level: level + 1)
      }
    }
  }
  
  
  /// trim a string of whitespace and even numbers if you want
  func trim(text: String, removingNumbers: Bool = false) -> String {
    var t = text
    
    t = t.trimmingCharacters(in: .punctuationCharacters)
    t = t.trimmingCharacters(in: .whitespaces)
    if removingNumbers {
      t = t.trimmingCharacters(in: .decimalDigits)
      t = t.trimmingCharacters(in: .whitespaces)
    }
    
    return t
  }

  
}
