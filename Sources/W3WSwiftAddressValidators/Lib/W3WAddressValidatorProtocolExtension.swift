//
//  File.swift
//  
//
//  Created by Dave Duprey on 05/05/2022.
//

import Foundation


extension W3WStreetAddressProtocol {
  
  // Utilty function used by some service implementations
  
  /// given an array of String,Int,Float,nil make a coherent String
  /// of these separated by the given separator (defaults to space)
  public func makeField(from: [Any?], separator: String = " ") -> String {
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



extension W3WAddressValidatorProtocol {
  
  // Utilty function used by some service implementations
  
  /// given an array of String,Int,Float,nil make a coherent String
  /// of these separated by the given separator (defaults to space)
  public func makeField(from: [Any?], separator: String = " ") -> String {
//    var nonNulls = [String]()
//
//    for field in from {
//      if let f = field as? String {
//        if f != "" {
//          nonNulls.append(f)
//        }
//      }
//      if let f = field as? Int {
//        nonNulls.append(String(f))
//      }
//      if let f = field as? Float {
//        nonNulls.append(String(f))
//      }
//    }
//
//    return nonNulls.joined(separator: separator)
    return allNonNull(from: from).joined(separator: separator)
  }
  
  
  public func allNonNull(from: [Any?]) -> [String] {
    var nonNulls = [String]()
    
    for field in from {
      if let f = field as? String {
        if f != "" {
          nonNulls.append(f.trimmingCharacters(in: .whitespaces))
        }
      }
      
      if let f = field as? Int {
        nonNulls.append(String(f).trimmingCharacters(in: .whitespaces))
      }
      
      if let f = field as? Float {
        nonNulls.append(String(f).trimmingCharacters(in: .whitespaces))
      }
      
      if let f = field as? String.SubSequence {
        nonNulls.append(String(f).trimmingCharacters(in: .whitespaces))
      }
    }
    
    return nonNulls
  }
  
  
  public func firstNonNull(of: [Any?]) -> [String] {
    for field in of {
      if let f = field as? String {
        if f != "" {
          return [f.trimmingCharacters(in: .whitespaces)]
        }
      }
      
      if let f = field as? Int {
        return [String(f).trimmingCharacters(in: .whitespaces)]
      }
      
      if let f = field as? Float {
        return [String(f).trimmingCharacters(in: .whitespaces)]
      }
      
      if let f = field as? String.SubSequence {
        return [String(f).trimmingCharacters(in: .whitespaces)]
      }
    }
    
    return []
  }
}
