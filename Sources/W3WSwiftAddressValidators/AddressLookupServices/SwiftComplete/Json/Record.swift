/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Record : Codable {
	let county : County?
	let postcode : Postcode?
	let primarylocality : Primarylocality?
	let secondarylocality : Secondarylocality?
	let road : Road?
	let buildingNumber : BuildingNumber?
  let what3words : What3words?

	enum CodingKeys: String, CodingKey {

		case county = "county"
		case postcode = "postcode"
		case primarylocality = "primarylocality"
		case secondarylocality = "secondarylocality"
		case road = "road"
		case buildingNumber = "buildingNumber"
    case what3words = "what3words"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		county = try values.decodeIfPresent(County.self, forKey: .county)
		postcode = try values.decodeIfPresent(Postcode.self, forKey: .postcode)
		primarylocality = try values.decodeIfPresent(Primarylocality.self, forKey: .primarylocality)
		secondarylocality = try values.decodeIfPresent(Secondarylocality.self, forKey: .secondarylocality)
		road = try values.decodeIfPresent(Road.self, forKey: .road)
		buildingNumber = try values.decodeIfPresent(BuildingNumber.self, forKey: .buildingNumber)
    what3words = try values.decodeIfPresent(What3words.self, forKey: .what3words)
	}

}
