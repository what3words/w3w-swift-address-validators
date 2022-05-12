//
//  File.swift
//  
//
//  Created by Dave Duprey on 06/01/2022.
//

import Foundation
import W3WSwiftApi


/// usually the top level node of the address tree, it contains a what3words address in a W3WSuggestion
public class W3WValidatorNodeSuggestion: W3WValidatorNodeList {
  
  /// what3words suggestion for this node
  let suggestion: W3WSuggestion
  
  /// usually the top level node of the address tree, it contains a what3words address in a W3WSuggestion
  /// - parameter suggestion: the suggesiton for the three word address
  public init(suggestion: W3WSuggestion) {
    self.suggestion = suggestion
    
    super.init(id: nil, words: suggestion.words, name: suggestion.words ?? "---.---.---", nearestPlace: suggestion.nearestPlace ?? "", subItemCount: nil)
  }
}
