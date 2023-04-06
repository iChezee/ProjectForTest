enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
}

protocol Endpoint {
    var path: String { get set }
    var method: HTTPMethod { get set }
    var headers: [String: String]? { get set }
    var queryParameters: [String: String]? { get set }
}
