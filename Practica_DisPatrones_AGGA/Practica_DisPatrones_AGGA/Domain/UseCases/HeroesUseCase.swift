//
//  HeroesUseCase.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 19/2/24.
//

import Foundation

protocol HeroesUseCaseProtocol {
    func getHeroes(completion: @escaping (Result<[DragonBallHero], NetworkErrors>)-> Void)
}

final class HeroesUseCase: HeroesUseCaseProtocol {
    
    func getHeroes(completion: @escaping (Result<[DragonBallHero], NetworkErrors>) -> Void) {
        APIProvider.getData(endpoint: EndPoints.heros.rawValue, dataRequest: "name", value: "", completion: completion)
    }
    
}
