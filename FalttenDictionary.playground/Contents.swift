func flattenDictionary(dict: Dictionary<String, Any>) -> Dictionary<String, String> {
  // your code goes here
  
    let resultDictionary = fetchResult(dict: dict)
    return resultDictionary
}

func fetchResult(dict: Dictionary<String, Any>) -> Dictionary<String, String> {
    var resultDictionary = Dictionary<String, String>()
    
    for (key, value) in dict {
        print("key: \(key) value:\(value)")
      if let strValue = value as? String {
          print("found string-----\(strValue)")
          resultDictionary[key] = strValue
          
          print("resultDictionary-----\(resultDictionary)")
      }
      else if let dictValue = value as? Dictionary<String, Any> {
         let fetchedResult = fetchResult(dict: dictValue)
          print("found dictonary-----: \(fetchedResult)")
          for (key1, value1) in fetchedResult {
              var keyValue = ""
              if !key.isEmpty {
                  keyValue = "\(key)"
              }
              if !key.isEmpty && !key1.isEmpty {
                  keyValue += "."
              }
              if !key1.isEmpty {
                  keyValue += "\(key1)"
              }
              
              resultDictionary["\(keyValue)"] = value1
          }
      }
    }
    
    return resultDictionary
}

let dict: Dictionary<String, Any> =  ["":["a":"1"],"b":"3"]

let result = flattenDictionary(dict: dict)
print("Result: \(result)")
