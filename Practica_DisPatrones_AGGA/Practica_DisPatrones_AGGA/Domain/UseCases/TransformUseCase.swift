//
//  TransformUseCase.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 19/2/24.
//

import Foundation

protocol TransformUseCaseProtocol {
    func getTransform(value: String, completion: @escaping (Result<[DragonBallTransforms], NetworkErrors>)-> Void)
}

final class TransformUseCase: TransformUseCaseProtocol {
    
    func getTransform(value: String, completion: @escaping (Result<[DragonBallTransforms], NetworkErrors>) -> Void) {
        APIProvider.getData(endpoint: EndPoints.heros.rawValue, dataRequest: "id", value: "", completion: completion)
    }
    
}
