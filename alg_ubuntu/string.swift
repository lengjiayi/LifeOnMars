class MarsTranslator{
	
	//MARK: public Methods
	//convert unicode string to hex array
	func stringToHex(_ string: String) -> [Int]{
		var hexArray:[Int] = []
		for element in string.unicodeScalars{
			let myInt = element.value
			hexArray += intToHex(Int(myInt))
			}
		return hexArray
	}
	
	//convert hex array to unicode string
	func hexToChar(_ hexArray: [Int]) -> String{
		var value = 0
		var string = ""
		for x in hexArray{
			if x < 0{
				string.append(Character(UnicodeScalar(value)!))
				value = 0
			}
			else{
				value *= 16
				value += x
			}
		}
		return string
	}
	
	//MARK: private Methods
	private func intToHex(_ value: Int) -> [Int]{
		var hex = [Int]()
		var tmp = value
		while tmp > 0 {
			hex.insert(tmp%16, at: 0)
			tmp /= 16
		}
		hex.append(-1)
		return hex
	}
}
/*
let t = MarsTranslator()
let result = t.stringToHex("大家好")
for x in result{
	print(x)
}
print(t.hexToChar(result))
*/
