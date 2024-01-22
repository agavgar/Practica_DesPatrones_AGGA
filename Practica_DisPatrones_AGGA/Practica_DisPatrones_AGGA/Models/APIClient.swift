//
//  APIClient.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import Foundation


//MARK: - Custom Errors
enum DragonBallErrors: Error {
    case malformedURL
    case statusCode(code:Int?)
    case failDecodingData
    case noData
    case tokenNotFound
    case unknown
}

extension DragonBallErrors{
    
    static func error(for code: Int) -> DragonBallErrors? {
        
        switch code {
        case 0: return .malformedURL
        case 1: return .statusCode(code: 400)
        case 2: return .failDecodingData
        case 3: return .noData        
        case 4: return .failDecodingData
        case 5: return .tokenNotFound
        case 6: return .statusCode(code: nil)
        case 7: return .unknown
        default: return nil
        }
        
    }

}

//MARK: - API Client

protocol APIClientProtocol{
    var session: URLSession { get }
    
    func request<T: Decodable>(_ request: URLRequest,using type: T.Type, completion: @escaping (Result<T,DragonBallErrors>) -> Void)
    
}

struct APIClient: APIClientProtocol {
    var session: URLSession
    
    init(session: URLSession = .shared){
        self.session = session
    }
    
    func request<T>(_ request: URLRequest, using type: T.Type, completion: @escaping (Result<T, DragonBallErrors>) -> Void) where T : Decodable {
        
        session.dataTask(with: request) { data,response,error in
            
            var result: Result<T, DragonBallErrors>
                
            defer {
                completion(result)
            }
               
            guard error == nil else {
                if let error = error as? NSError,
                   let error = DragonBallErrors.error(for: error.code){
                    result = .failure(error)
                }else{
                    result = .failure(.unknown)
                }
                return
            }
            
            guard let data else {
                result = .failure(.noData)
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            
            guard let resource = try? JSONDecoder().decode(T.self, from: data) else {
                result = .failure(.failDecodingData)
                return
            }
            
            
            if resource is String {
                    
                guard let jwt = String(data: data, encoding: .utf8) else {
                    result = .failure(.failDecodingData)
                    return
                }
                
                result = .success(jwt as! T)
                
            }
    
            result = .success(resource)
            
            }
        .resume()
            
        }
    
        
        
    
    
    
}

