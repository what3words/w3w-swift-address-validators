//
//  File.swift
//
//
//  Created by Dave Duprey on 06/01/2022.
//

import Foundation


/// settings for the Data8 service
class W3WData8Settings {
  
  /// Data8 API host name
  static public let data8Host  = "https://webservices.data-8.co.uk/"

  /// Data8 search endpoint
  static public let data8Search  = "PredictiveAddress/Search.json"

  /// Data8 address detail endpoint
  static public let data8Retrieve  = "PredictiveAddress/Retrieve.json"

  /// Swift Complete search endpoint
  static public let data8DrillDown  = "PredictiveAddress/DrillDown.json"

}
