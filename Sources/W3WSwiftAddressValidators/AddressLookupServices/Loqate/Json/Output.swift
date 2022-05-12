/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Output : Codable {
	let address : String?
	let address1 : String?
	let address2 : String?
	let administrativeArea : String?
	let countryName : String?
	let deliveryAddress : String?
	let deliveryAddress1 : String?
	let geoDistance : String?
	let iSO3166_2 : String?
	let iSO3166_3 : String?
	let iSO3166_N : String?
	let latitude : String?
	let locality : String?
	let longitude : String?
	let postalCode : String?
	let postalCodePrimary : String?
	let premise : String?
	let premiseNumber : String?
	let premiseNumberRangeField : String?
	let subAdministrativeArea : String?
	let thoroughfare : String?

	enum CodingKeys: String, CodingKey {

		case address = "Address"
		case address1 = "Address1"
		case address2 = "Address2"
		case administrativeArea = "AdministrativeArea"
		case countryName = "CountryName"
		case deliveryAddress = "DeliveryAddress"
		case deliveryAddress1 = "DeliveryAddress1"
		case geoDistance = "GeoDistance"
		case iSO3166_2 = "ISO3166-2"
		case iSO3166_3 = "ISO3166-3"
		case iSO3166_N = "ISO3166-N"
		case latitude = "Latitude"
		case locality = "Locality"
		case longitude = "Longitude"
		case postalCode = "PostalCode"
		case postalCodePrimary = "PostalCodePrimary"
		case premise = "Premise"
		case premiseNumber = "PremiseNumber"
		case premiseNumberRangeField = "PremiseNumberRangeField"
		case subAdministrativeArea = "SubAdministrativeArea"
		case thoroughfare = "Thoroughfare"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		address1 = try values.decodeIfPresent(String.self, forKey: .address1)
		address2 = try values.decodeIfPresent(String.self, forKey: .address2)
		administrativeArea = try values.decodeIfPresent(String.self, forKey: .administrativeArea)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		deliveryAddress = try values.decodeIfPresent(String.self, forKey: .deliveryAddress)
		deliveryAddress1 = try values.decodeIfPresent(String.self, forKey: .deliveryAddress1)
		geoDistance = try values.decodeIfPresent(String.self, forKey: .geoDistance)
		iSO3166_2 = try values.decodeIfPresent(String.self, forKey: .iSO3166_2)
		iSO3166_3 = try values.decodeIfPresent(String.self, forKey: .iSO3166_3)
		iSO3166_N = try values.decodeIfPresent(String.self, forKey: .iSO3166_N)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		locality = try values.decodeIfPresent(String.self, forKey: .locality)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
		postalCodePrimary = try values.decodeIfPresent(String.self, forKey: .postalCodePrimary)
		premise = try values.decodeIfPresent(String.self, forKey: .premise)
		premiseNumber = try values.decodeIfPresent(String.self, forKey: .premiseNumber)
		premiseNumberRangeField = try values.decodeIfPresent(String.self, forKey: .premiseNumberRangeField)
		subAdministrativeArea = try values.decodeIfPresent(String.self, forKey: .subAdministrativeArea)
		thoroughfare = try values.decodeIfPresent(String.self, forKey: .thoroughfare)
	}

}
