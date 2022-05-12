/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Location : Codable {
	let easting : Int?
	let northing : Int?
	let gridReference : String?
	let longitude : Double?
	let latitude : Double?
	let countyCode : String?
	let county : String?
	let districtCode : String?
	let district : String?
	let wardCode : String?
	let ward : String?
	let country : String?

	enum CodingKeys: String, CodingKey {

		case easting = "Easting"
		case northing = "Northing"
		case gridReference = "GridReference"
		case longitude = "Longitude"
		case latitude = "Latitude"
		case countyCode = "CountyCode"
		case county = "County"
		case districtCode = "DistrictCode"
		case district = "District"
		case wardCode = "WardCode"
		case ward = "Ward"
		case country = "Country"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		easting = try values.decodeIfPresent(Int.self, forKey: .easting)
		northing = try values.decodeIfPresent(Int.self, forKey: .northing)
		gridReference = try values.decodeIfPresent(String.self, forKey: .gridReference)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		countyCode = try values.decodeIfPresent(String.self, forKey: .countyCode)
		county = try values.decodeIfPresent(String.self, forKey: .county)
		districtCode = try values.decodeIfPresent(String.self, forKey: .districtCode)
		district = try values.decodeIfPresent(String.self, forKey: .district)
		wardCode = try values.decodeIfPresent(String.self, forKey: .wardCode)
		ward = try values.decodeIfPresent(String.self, forKey: .ward)
		country = try values.decodeIfPresent(String.self, forKey: .country)
	}

}