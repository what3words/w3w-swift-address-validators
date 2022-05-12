/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct W3WLoqateFullAddress : Codable {
	let id : String?
	let domesticId : String?
	let language : String?
	let languageAlternatives : String?
	let department : String?
	let company : String?
	let subBuilding : String?
	let buildingNumber : String?
	let buildingName : String?
	let secondaryStreet : String?
	let street : String?
	let block : String?
	let neighbourhood : String?
	let district : String?
	let city : String?
	let line1 : String?
	let line2 : String?
	let line3 : String?
	let line4 : String?
	let line5 : String?
	let adminAreaName : String?
	let adminAreaCode : String?
	let province : String?
	let provinceName : String?
	let provinceCode : String?
	let postalCode : String?
	let countryName : String?
	let countryIso2 : String?
	let countryIso3 : String?
	let countryIsoNumber : Int?
	let sortingNumber1 : String?
	let sortingNumber2 : String?
	let barcode : String?
	let pOBoxNumber : String?
	let label : String?
	let type : String?
	let dataLevel : String?
	let field1 : String?
	let field2 : String?
	let field3 : String?
	let field4 : String?
	let field5 : String?
	let field6 : String?
	let field7 : String?
	let field8 : String?
	let field9 : String?
	let field10 : String?
	let field11 : String?
	let field12 : String?
	let field13 : String?
	let field14 : String?
	let field15 : String?
	let field16 : String?
	let field17 : String?
	let field18 : String?
	let field19 : String?
	let field20 : String?

	enum CodingKeys: String, CodingKey {

		case id = "Id"
		case domesticId = "DomesticId"
		case language = "Language"
		case languageAlternatives = "LanguageAlternatives"
		case department = "Department"
		case company = "Company"
		case subBuilding = "SubBuilding"
		case buildingNumber = "BuildingNumber"
		case buildingName = "BuildingName"
		case secondaryStreet = "SecondaryStreet"
		case street = "Street"
		case block = "Block"
		case neighbourhood = "Neighbourhood"
		case district = "District"
		case city = "City"
		case line1 = "Line1"
		case line2 = "Line2"
		case line3 = "Line3"
		case line4 = "Line4"
		case line5 = "Line5"
		case adminAreaName = "AdminAreaName"
		case adminAreaCode = "AdminAreaCode"
		case province = "Province"
		case provinceName = "ProvinceName"
		case provinceCode = "ProvinceCode"
		case postalCode = "PostalCode"
		case countryName = "CountryName"
		case countryIso2 = "CountryIso2"
		case countryIso3 = "CountryIso3"
		case countryIsoNumber = "CountryIsoNumber"
		case sortingNumber1 = "SortingNumber1"
		case sortingNumber2 = "SortingNumber2"
		case barcode = "Barcode"
		case pOBoxNumber = "POBoxNumber"
		case label = "Label"
		case type = "Type"
		case dataLevel = "DataLevel"
		case field1 = "Field1"
		case field2 = "Field2"
		case field3 = "Field3"
		case field4 = "Field4"
		case field5 = "Field5"
		case field6 = "Field6"
		case field7 = "Field7"
		case field8 = "Field8"
		case field9 = "Field9"
		case field10 = "Field10"
		case field11 = "Field11"
		case field12 = "Field12"
		case field13 = "Field13"
		case field14 = "Field14"
		case field15 = "Field15"
		case field16 = "Field16"
		case field17 = "Field17"
		case field18 = "Field18"
		case field19 = "Field19"
		case field20 = "Field20"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		domesticId = try values.decodeIfPresent(String.self, forKey: .domesticId)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		languageAlternatives = try values.decodeIfPresent(String.self, forKey: .languageAlternatives)
		department = try values.decodeIfPresent(String.self, forKey: .department)
		company = try values.decodeIfPresent(String.self, forKey: .company)
		subBuilding = try values.decodeIfPresent(String.self, forKey: .subBuilding)
		buildingNumber = try values.decodeIfPresent(String.self, forKey: .buildingNumber)
		buildingName = try values.decodeIfPresent(String.self, forKey: .buildingName)
		secondaryStreet = try values.decodeIfPresent(String.self, forKey: .secondaryStreet)
		street = try values.decodeIfPresent(String.self, forKey: .street)
		block = try values.decodeIfPresent(String.self, forKey: .block)
		neighbourhood = try values.decodeIfPresent(String.self, forKey: .neighbourhood)
		district = try values.decodeIfPresent(String.self, forKey: .district)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		line1 = try values.decodeIfPresent(String.self, forKey: .line1)
		line2 = try values.decodeIfPresent(String.self, forKey: .line2)
		line3 = try values.decodeIfPresent(String.self, forKey: .line3)
		line4 = try values.decodeIfPresent(String.self, forKey: .line4)
		line5 = try values.decodeIfPresent(String.self, forKey: .line5)
		adminAreaName = try values.decodeIfPresent(String.self, forKey: .adminAreaName)
		adminAreaCode = try values.decodeIfPresent(String.self, forKey: .adminAreaCode)
		province = try values.decodeIfPresent(String.self, forKey: .province)
		provinceName = try values.decodeIfPresent(String.self, forKey: .provinceName)
		provinceCode = try values.decodeIfPresent(String.self, forKey: .provinceCode)
		postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		countryIso2 = try values.decodeIfPresent(String.self, forKey: .countryIso2)
		countryIso3 = try values.decodeIfPresent(String.self, forKey: .countryIso3)
		countryIsoNumber = try values.decodeIfPresent(Int.self, forKey: .countryIsoNumber)
		sortingNumber1 = try values.decodeIfPresent(String.self, forKey: .sortingNumber1)
		sortingNumber2 = try values.decodeIfPresent(String.self, forKey: .sortingNumber2)
		barcode = try values.decodeIfPresent(String.self, forKey: .barcode)
		pOBoxNumber = try values.decodeIfPresent(String.self, forKey: .pOBoxNumber)
		label = try values.decodeIfPresent(String.self, forKey: .label)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		dataLevel = try values.decodeIfPresent(String.self, forKey: .dataLevel)
		field1 = try values.decodeIfPresent(String.self, forKey: .field1)
		field2 = try values.decodeIfPresent(String.self, forKey: .field2)
		field3 = try values.decodeIfPresent(String.self, forKey: .field3)
		field4 = try values.decodeIfPresent(String.self, forKey: .field4)
		field5 = try values.decodeIfPresent(String.self, forKey: .field5)
		field6 = try values.decodeIfPresent(String.self, forKey: .field6)
		field7 = try values.decodeIfPresent(String.self, forKey: .field7)
		field8 = try values.decodeIfPresent(String.self, forKey: .field8)
		field9 = try values.decodeIfPresent(String.self, forKey: .field9)
		field10 = try values.decodeIfPresent(String.self, forKey: .field10)
		field11 = try values.decodeIfPresent(String.self, forKey: .field11)
		field12 = try values.decodeIfPresent(String.self, forKey: .field12)
		field13 = try values.decodeIfPresent(String.self, forKey: .field13)
		field14 = try values.decodeIfPresent(String.self, forKey: .field14)
		field15 = try values.decodeIfPresent(String.self, forKey: .field15)
		field16 = try values.decodeIfPresent(String.self, forKey: .field16)
		field17 = try values.decodeIfPresent(String.self, forKey: .field17)
		field18 = try values.decodeIfPresent(String.self, forKey: .field18)
		field19 = try values.decodeIfPresent(String.self, forKey: .field19)
		field20 = try values.decodeIfPresent(String.self, forKey: .field20)
	}

}
