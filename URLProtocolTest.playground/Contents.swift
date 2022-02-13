import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var request = URLRequest(url: URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/feed")!)
request.httpMethod = "GET"

URLProtocol.registerClass(TestURLProtocol.self)
URLSession.shared.dataTask(with: request) { (data, response, error) in
    if let data = data,
       let dataString = try? JSONDecoder().decode(FeedItems.self, from: data) {
        print("Original response: \(dataString)")
    }
    PlaygroundPage.current.finishExecution()
}.resume()


class TestURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return request.url?.absoluteString.contains("essential") == true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let jsonData = jsonData {
            self.client?.urlProtocol(self, didLoad: jsonData)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
    }
    
    private var jsonData: Data? {
        let JSON = """
        {
        "items": [
            {
                "id": "TestID",
                "description": "Test description",
                "location": "test location",
                "image": "test image"
            }
        ]
        }
        """
        return JSON.data(using: .utf8)!
    }
}

struct FeedItems: Decodable {
    let items: [Feeds]
    
    private enum CodingKeys: String, CodingKey {
        case items
    }
}

extension FeedItems: CustomStringConvertible {
    var description: String {
        var result = ""
        items.enumerated().forEach { (index, item) in
            result += "\(index+1) \(item.id) : \(item.subtitle ?? "") \n"
        }
        return result
    }
}

struct Feeds: Decodable {
    let id: String
    let subtitle: String?
    let location: String?
    let image: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case subtitle = "description"
        case location
        case image
    }
}
