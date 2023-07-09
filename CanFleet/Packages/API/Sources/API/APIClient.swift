import Foundation
import Alamofire
import Logger

public final class BaseSession {
    var session: Session
    
    init(interceptor: RequestInterceptor? = nil) {
        if let interceptor = interceptor {
            session = Session(interceptor: interceptor,
                              eventMonitors: [NetworkLogger()])
        } else {
            session = Session(eventMonitors: [NetworkLogger()])
        }
    }
    
    func updateSession(_ newSession: Session) {
        session = newSession
    }
    
    func invalidateAllRequests() {
        session.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }

        session.cancelAllRequests()
    }
}

struct AuthCredential: AuthenticationCredential {
    let accessToken: String

    // Require refresh if within 5 minutes of expiration
    var requiresRefresh: Bool {
//        if let expirationTime = UserDefaults.tokenExpiredAt {
//                let expireDate = Date(timeIntervalSince1970: expirationTime)
//            return Date(timeIntervalSinceNow: 60 * 5) > expireDate
//        }
        return false
    }
}

class CustomAuthenticator: Authenticator {
    func refresh(_ credential: AuthCredential, for session: Alamofire.Session, completion: @escaping (Result<AuthCredential, Error>) -> Void) {
        completion(.success(AuthCredential(accessToken: "")))
    }
    

    func apply(_ credential: AuthCredential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: "eyJhbGciOiJSUzI1NiIsImtpZCI6ImE1MWJiNGJkMWQwYzYxNDc2ZWIxYjcwYzNhNDdjMzE2ZDVmODkzMmIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vaW50LWNhbnRlYy1lY29tbWVyY2UiLCJhdWQiOiJpbnQtY2FudGVjLWVjb21tZXJjZSIsImF1dGhfdGltZSI6MTY4ODc0NTk0NywidXNlcl9pZCI6IkxQN1hRYzhBOEdWelVDcUUxaVFQY0R2NVgzQjIiLCJzdWIiOiJMUDdYUWM4QThHVnpVQ3FFMWlRUGNEdjVYM0IyIiwiaWF0IjoxNjg4ODkxMDQwLCJleHAiOjE2ODg4OTQ2NDAsImVtYWlsIjoiKzEyNDk0OTYzMzQ0QHBob25lYXNlbWFpbC5jYW50ZWNjb3VyaWVycy5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiKzEyNDk0OTYzMzQ0QHBob25lYXNlbWFpbC5jYW50ZWNjb3VyaWVycy5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.GlDSwdt6wwVAMvDCAsb5_wWOBw8i65hBXVQxbzZeppIZctxi3r64Ydw7OoHD1qDmE9qMlGKhtJhFxEi1F9691XIPEkq2P1QOh4HmgzMSekadVKhYCTxKtqZpJ8F-IE-wVTGukdhS5tJpDpOeIFOCTKry1MzXS2uRPRmCuXos1ZXiF6kXDQ9rcFb79EVAk1mzc1Ndv56l2OaKykc7q6we7kfH-VNt7ZcUGGVcqq_4dwtvbeSZQhlxFXAnHKMoVPaug6NEWPoTDRNGpNZ_IMHDT5RoD8LdK27qmbYUmwSc-iMaAg9LyC_0Uzz8QdL1WNuzwKNoYFlmuy6zTWPRKNSpqw"))
        urlRequest.headers.add(.init(name: "canfleet-org-id", value: "64489c4244de8f93841ef993"))
        urlRequest.headers.add(.init(name: "device", value: "mobile"))
    }
//
//    func refresh(_ credential: AuthCredential,
//                 for session: Session,
//                 completion: @escaping (Result<AuthCredential, Error>) -> Void) {
//        APIClient.shared.refreshToken(retryCount: 0) { result in
//            switch result {
//            case .success(let response):
//                guard let accessToken = response.data?.idToken,
////                let refreshToken = response.data?.refreshToken,
//                let tokenExpireAt = response.data?.idTokenExpiresAt.value else {
//                    completion(.failure(NetworkError.getRefreshTokenFail))
//                    return
//                }
//
//                Log.d("[RefreshToken] Receive new accessToken: \(String(describing: response))")
//
//                UserDefaults.accessToken = accessToken
////                UserDefaults.refreshToken = response.data?.refreshToken
//                UserDefaults.tokenExpiredAt = tokenExpireAt
//                completion(.success(AuthCredential(accessToken: accessToken)))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }

    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
//         If authentication server CANNOT invalidate credentials, return `false`
//        return false
//
//         If authentication server CAN invalidate credentials, then inspect the response matching against what the
//         authentication server returns as an authentication failure. This is generally a 401 along with a custom
//         header value.
         return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: AuthCredential) -> Bool {
        return true
    }

}


public enum AccessTokenType {
    case bearer
    case none
}

public enum APIError: Error, LocalizedError, Equatable, Decodable {
    case unknown(httpCode: Int)
    case custom(error: String?, httpCode: Int)
    case forceLogout
    case failedToDecodeResponse
    case none
    
    public var failureReason: String? {
        switch self  {
        case .unknown:
            return "Something went wrong! Please try again"
        case .custom(let error, _):
            return error
        case .forceLogout:
            return "Your token expired, please login again!"
        case .failedToDecodeResponse:
            return "Failed to decode response"
        case .none:
            return nil
        }
    }
    
    public var errorDescription: String? {
        return "Error"
    }
    
    public var httpCode: Int {
        switch self {
        case .unknown(let httpCode),
                .custom(_ , let httpCode):
            return httpCode
        default:
            return 400
        }
    }
}

public final class APIClient {
    public static let shared  = APIClient()
    
    var bearerSession: BaseSession
    var nonBearerSession: BaseSession
    
    // MARK: - Initialize
    
    init() {
//        if let accessToken = UserDefaults.accessToken {
//            Log.d("accessToken: \(accessToken)")
//            credential = AuthCredential(accessToken: "eyJhbGciOiJSUzI1NiIsImtpZCI6ImE1MWJiNGJkMWQwYzYxNDc2ZWIxYjcwYzNhNDdjMzE2ZDVmODkzMmIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vaW50LWNhbnRlYy1lY29tbWVyY2UiLCJhdWQiOiJpbnQtY2FudGVjLWVjb21tZXJjZSIsImF1dGhfdGltZSI6MTY4ODc0NTk0NywidXNlcl9pZCI6IkxQN1hRYzhBOEdWelVDcUUxaVFQY0R2NVgzQjIiLCJzdWIiOiJMUDdYUWM4QThHVnpVQ3FFMWlRUGNEdjVYM0IyIiwiaWF0IjoxNjg4ODg3MzgwLCJleHAiOjE2ODg4OTA5ODAsImVtYWlsIjoiKzEyNDk0OTYzMzQ0QHBob25lYXNlbWFpbC5jYW50ZWNjb3VyaWVycy5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiKzEyNDk0OTYzMzQ0QHBob25lYXNlbWFpbC5jYW50ZWNjb3VyaWVycy5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.sglsB63LXlpr_gbmR33CCrILnt4AQDY_7EZ7zHQNUMH43i-P8z_GD3lB4tNHlgoYJ-dGrHcoKFK8AX5OFuI2EdEvJ-Ru0iom8rO0luvU2xMgsct1RbiJOrCJKgLKOYYYSyFX_YhsoMm4Px-x0Wh0EzVk7MnNlfwy-lIYhR2PPdpmwguO24RREhIwx_IUnibf5Y3LrgKoKPmY_nuA4c5j_trYsmopkrNvFE_ROzH_WkySNWen61amRUyQBnrrYf1FtQrgTp8WrQhVXAmZv5LTKGI6jwvFJC1fNHuo_6q3HOspEErgjS34MSIpNaJ7BZ-bUGJH594mPMhunhXZapTHUw")
//        } else {
//            credential = AuthCredential(accessToken: "")
//        }
        let credential = AuthCredential(accessToken: "eyJhbGciOiJSUzI1NiIsImtpZCI6ImE1MWJiNGJkMWQwYzYxNDc2ZWIxYjcwYzNhNDdjMzE2ZDVmODkzMmIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vaW50LWNhbnRlYy1lY29tbWVyY2UiLCJhdWQiOiJpbnQtY2FudGVjLWVjb21tZXJjZSIsImF1dGhfdGltZSI6MTY4ODc0NTk0NywidXNlcl9pZCI6IkxQN1hRYzhBOEdWelVDcUUxaVFQY0R2NVgzQjIiLCJzdWIiOiJMUDdYUWM4QThHVnpVQ3FFMWlRUGNEdjVYM0IyIiwiaWF0IjoxNjg4ODkxMDQwLCJleHAiOjE2ODg4OTQ2NDAsImVtYWlsIjoiKzEyNDk0OTYzMzQ0QHBob25lYXNlbWFpbC5jYW50ZWNjb3VyaWVycy5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiKzEyNDk0OTYzMzQ0QHBob25lYXNlbWFpbC5jYW50ZWNjb3VyaWVycy5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.GlDSwdt6wwVAMvDCAsb5_wWOBw8i65hBXVQxbzZeppIZctxi3r64Ydw7OoHD1qDmE9qMlGKhtJhFxEi1F9691XIPEkq2P1QOh4HmgzMSekadVKhYCTxKtqZpJ8F-IE-wVTGukdhS5tJpDpOeIFOCTKry1MzXS2uRPRmCuXos1ZXiF6kXDQ9rcFb79EVAk1mzc1Ndv56l2OaKykc7q6we7kfH-VNt7ZcUGGVcqq_4dwtvbeSZQhlxFXAnHKMoVPaug6NEWPoTDRNGpNZ_IMHDT5RoD8LdK27qmbYUmwSc-iMaAg9LyC_0Uzz8QdL1WNuzwKNoYFlmuy6zTWPRKNSpqw")
        let authenticator = CustomAuthenticator()
        
        let interceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
//        let nonBearerInterceptor = NonBearerApiClientInterceptor()
        bearerSession = BaseSession(interceptor: interceptor)
        nonBearerSession = BaseSession()
    }
    
    // MARK: - Methods
    
    // MARK: - Public methods
    
    public func request<T: Decodable>(_ url: URLRequestConvertible,
                               tokenType: AccessTokenType) async -> Result<T, APIError> {
        do {
            let result = try await self.getSession(by: tokenType).request(url).serializingDecodable(T.self).value
            return .success(result)
        } catch let error {
            if let error = error as? DecodingError {
                return .failure(handleDecodeError(error, for: url.urlRequest!))
            } else {
                let error = error as NSError
                return .failure(.custom(error: error.localizedDescription, httpCode: error.code))
            }
        }
    }
    
    // MARK: Private methods
    
    private func getSession(by accessTokenType: AccessTokenType) -> Session {
        switch accessTokenType {
        case .bearer:
            return bearerSession.session
        case .none:
            return nonBearerSession.session
        }
    }
    
    private func decode<Response: Decodable>(data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
    
    private func handleDecodeError(_ error: DecodingError, for request: URLRequest) -> APIError {
        var decodeError = APIError.failedToDecodeResponse
        
        switch error {
        case .typeMismatch(let key, let value):
            let error = "typeMismatch error \(key), value \(value) and ERROR: \(error.localizedDescription)"
            Logger.shared.error("\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "") \(error)")
            decodeError = APIError.custom(error: error, httpCode: 500)
        case .valueNotFound(let key, let value):
            let error = "valueNotFound error \(key), value \(value) and ERROR: \(error.localizedDescription)"
            Logger.shared.error("\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "") \(error)")
            decodeError = APIError.custom(error: error, httpCode: 500)
        case .keyNotFound(let key, let value):
            let error = "keyNotFound error \(key), value \(value) and ERROR: \(error.localizedDescription)"
            Logger.shared.error("\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "") \(error)")
            decodeError = APIError.custom(error: error, httpCode: 500)
        case .dataCorrupted(let key):
            let error = "dataCorrupted error \(key), and ERROR: \(error.localizedDescription)"
            Logger.shared.error("\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "") \(error)")
            decodeError = APIError.custom(error: error, httpCode: 500)
        default:
            let error = "Decode error: \(error.localizedDescription)"
            Logger.shared.error("\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "") \(error)")
            decodeError = APIError.custom(error: error, httpCode: 500)
        }
        
#if DEBUG
        return decodeError
#else
        return APIError.failedToDecodeResponse
#endif
    }
}
