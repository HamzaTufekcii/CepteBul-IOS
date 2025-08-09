import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import XCTest

final class MockURLProtocol: URLProtocol {
    typealias Handler = (URLRequest) throws -> (HTTPURLResponse, Data)
    static var handlers: [Handler] = []
    static var requestCount = 0
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        MockURLProtocol.requestCount += 1
        guard !MockURLProtocol.handlers.isEmpty else {
            client?.urlProtocol(self, didFailWithError: NSError(domain: "No handler", code: 0))
            return
        }
        let handler = MockURLProtocol.handlers.removeFirst()
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
