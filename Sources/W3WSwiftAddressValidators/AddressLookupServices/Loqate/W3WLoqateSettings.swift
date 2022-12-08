//
//  File.swift
//  
//
//  Created by Dave Duprey on 06/01/2022.
//

import Foundation

/// Settings for the Loqate API wrapper
class W3WLocateSettings {

  // Loqate host
  static public let loqateHost         = "https://api.addressy.com/"

  // Loqate endpoints
  static public let reverseGeocodePath = "Geocoding/International/ReverseGeocode/v2.00/json3.ws"
  static public let findPath           = "Capture/Interactive/Find/v1.1/json3.ws"
  static public let geolocationPath    = "Capture/Interactive/GeoLocation/v1/json3.ws"
  static public let retrievePath       = "Capture/Interactive/Retrieve/v1/json3.ws"
  static public let retrievePath1_2    = "Capture/Interactive/Retrieve/v1.2/json3.ws"
  static public let retreiveNearest    = "Geocoding/UK/RetrieveNearestPlaces/v1.2/wsdlnew.ws"
  static public let findUkV2           = "Geocoding/UK/Find/v2.00/csv.ws"
  static public let loqateRadius       = "200"
  static public let loqateNumResults   = "100"
  
  // Constants
  static public let maximumListLengthBeforeBreakingIntoStreets = 6

}
