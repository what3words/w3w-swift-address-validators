/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct RawAddress : Codable {
	let organisation : String?
	let department : String?
	let addressKey : Int?
	let organisationKey : Int?
	let postcodeType : String?
	let buildingNumber : Int?
	let subBuildingName : String?
	let buildingName : String?
	let dependentThoroughfareName : String?
	let dependentThoroughfareDesc : String?
	let thoroughfareName : String?
	let thoroughfareDesc : String?
	let doubleDependentLocality : String?
	let dependentLocality : String?
	let locality : String?
	let postcode : String?
	let dps : String?
	let poBox : String?
	let postalCounty : String?
	let traditionalCounty : String?
	let administrativeCounty : String?
	let countryISO2 : String?
	let uniqueReference : String?
	let location : Location?
	let additionalData : [AdditionalData]?

	enum CodingKeys: String, CodingKey {

		case organisation = "Organisation"
		case department = "Department"
		case addressKey = "AddressKey"
		case organisationKey = "OrganisationKey"
		case postcodeType = "PostcodeType"
		case buildingNumber = "BuildingNumber"
		case subBuildingName = "SubBuildingName"
		case buildingName = "BuildingName"
		case dependentThoroughfareName = "DependentThoroughfareName"
		case dependentThoroughfareDesc = "DependentThoroughfareDesc"
		case thoroughfareName = "ThoroughfareName"
		case thoroughfareDesc = "ThoroughfareDesc"
		case doubleDependentLocality = "DoubleDependentLocality"
		case dependentLocality = "DependentLocality"
		case locality = "Locality"
		case postcode = "Postcode"
		case dps = "Dps"
		case poBox = "PoBox"
		case postalCounty = "PostalCounty"
		case traditionalCounty = "TraditionalCounty"
		case administrativeCounty = "AdministrativeCounty"
		case countryISO2 = "CountryISO2"
		case uniqueReference = "UniqueReference"
		case location = "Location"
		case additionalData = "AdditionalData"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		organisation = try values.decodeIfPresent(String.self, forKey: .organisation)
		department = try values.decodeIfPresent(String.self, forKey: .department)
		addressKey = try values.decodeIfPresent(Int.self, forKey: .addressKey)
		organisationKey = try values.decodeIfPresent(Int.self, forKey: .organisationKey)
		postcodeType = try values.decodeIfPresent(String.self, forKey: .postcodeType)
		buildingNumber = try values.decodeIfPresent(Int.self, forKey: .buildingNumber)
		subBuildingName = try values.decodeIfPresent(String.self, forKey: .subBuildingName)
		buildingName = try values.decodeIfPresent(String.self, forKey: .buildingName)
		dependentThoroughfareName = try values.decodeIfPresent(String.self, forKey: .dependentThoroughfareName)
		dependentThoroughfareDesc = try values.decodeIfPresent(String.self, forKey: .dependentThoroughfareDesc)
		thoroughfareName = try values.decodeIfPresent(String.self, forKey: .thoroughfareName)
		thoroughfareDesc = try values.decodeIfPresent(String.self, forKey: .thoroughfareDesc)
		doubleDependentLocality = try values.decodeIfPresent(String.self, forKey: .doubleDependentLocality)
		dependentLocality = try values.decodeIfPresent(String.self, forKey: .dependentLocality)
		locality = try values.decodeIfPresent(String.self, forKey: .locality)
		postcode = try values.decodeIfPresent(String.self, forKey: .postcode)
		dps = try values.decodeIfPresent(String.self, forKey: .dps)
		poBox = try values.decodeIfPresent(String.self, forKey: .poBox)
		postalCounty = try values.decodeIfPresent(String.self, forKey: .postalCounty)
		traditionalCounty = try values.decodeIfPresent(String.self, forKey: .traditionalCounty)
		administrativeCounty = try values.decodeIfPresent(String.self, forKey: .administrativeCounty)
		countryISO2 = try values.decodeIfPresent(String.self, forKey: .countryISO2)
		uniqueReference = try values.decodeIfPresent(String.self, forKey: .uniqueReference)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
		additionalData = try values.decodeIfPresent([AdditionalData].self, forKey: .additionalData)
	}

}