//
//  NetworkModel.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import Foundation

final class NetworkModel {
    
    //MARK: - Singleton
    static let share = NetworkModel()
    
    private var token: String? {
        get {
            if let token = LocalDataModel.getToken(){
                return token
            }
            return nil
        }
        set {
            if let token = newValue {
                LocalDataModel.save(token: token)
            }
        }
    }
    
    //MARK: - Models de Network
    private var baseComponents:URLComponents{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func login(user: String, password: String, completion: @escaping (Result<String, DragonBallErrors>)-> Void){
        
        var components = baseComponents
        components.path = "/api/auth/login"
        
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.failDecodingData))
            return
        }
        
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("BASIC \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        client.request(urlRequest, using: String.self){ [weak self] result in
            
            switch result {
                case let .success(token):
                    self?.token = token
                    LocalDataModel.save(token: token)
                    completion(.success(token))
                case let .failure(error):
                    completion(.failure(error))
            }
            
        }
        
    }
    
    func getHeroes(completion: @escaping (Result<[DragonBallHero], DragonBallErrors>)-> Void){
        
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let token else {
            completion(.failure(.tokenNotFound))
            return
        }
                    
        // Crear un objeto URLComponents, para encodificarlo posteriormente
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name:"name", value:"")]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        client.request(urlRequest, using: [DragonBallHero].self, completion: completion)
    }
    
    func getTransformation(id:String,completion: @escaping (Result<[DragonBallTransforms], DragonBallErrors>)-> Void){
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let token else {
            completion(.failure(.tokenNotFound))
            return
        }
                    
        // Crear un objeto URLComponents, para encodificarlo posteriormente
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name:"id", value:id)]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        client.request(urlRequest, using: [DragonBallTransforms].self, completion: completion)
    }
    
}
