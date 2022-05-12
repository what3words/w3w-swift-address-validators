//
//  File.swift
//  
//
//  Created by Dave Duprey on 05/05/2022.
//

import Foundation


extension W3WAddressValidatorProtocol {
  
  // Utilty function used by some service implementations
  
  /// given an array of String,Int,Float,nil make a coherent String
  /// of these separated by the given separator (defaults to space)
  func makeField(from: [Any?], separator: String = " ") -> String {
    var nonNulls = [String]()
    
    for field in from {
      if let f = field as? String {
        if f != "" {
          nonNulls.append(f)
        }
      }
      if let f = field as? Int {
        nonNulls.append(String(f))
      }
      if let f = field as? Float {
        nonNulls.append(String(f))
      }
    }
    
    return nonNulls.joined(separator: separator)
  }
  
  
}
