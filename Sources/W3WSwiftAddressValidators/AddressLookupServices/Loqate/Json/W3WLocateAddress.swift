/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct W3WLoqateAddress : Codable {
	let streetNumber : String?
	let streetName : String?
	let city : String?
	let province : String?
	let postalCode : String?
	let countryCode : String?
	let distance : Int?
	let latitude : Double?
	let longitude : Double?

	enum CodingKeys: String, CodingKey {

		case streetNumber = "StreetNumber"
		case streetName = "StreetName"
		case city = "City"
		case province = "Province"
		case postalCode = "PostalCode"
		case countryCode = "CountryCode"
		case distance = "Distance"
		case latitude = "Latitude"
		case longitude = "Longitude"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		streetNumber = try values.decodeIfPresent(String.self, forKey: .streetNumber)
		streetName = try values.decodeIfPresent(String.self, forKey: .streetName)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		province = try values.decodeIfPresent(String.self, forKey: .province)
		postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
		countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
		distance = try values.decodeIfPresent(Int.self, forKey: .distance)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
	}

}
