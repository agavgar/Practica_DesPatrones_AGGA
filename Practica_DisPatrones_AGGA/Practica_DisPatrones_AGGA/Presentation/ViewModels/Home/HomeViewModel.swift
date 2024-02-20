//
//  HomeViewModel.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 23/1/24.
//

import Foundation

var dispatchQ = DispatchQueue.main

final class HomeViewModel {
    
    //MARK: - Binding con UI
    var statusLoad: ((GenericStatusLoad) -> Void)?
    
    //MARK: - Conection useCase
    private let useCase: HeroesUseCaseProtocol
    
    //MARK: - Models
    var dataHeroes: [DragonBallHero] = []
    
    //MARK: - Init
    init(useCase: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCase = useCase
    }
    
    //MARK: - metodo Login
    func getHeroes(){
        
        DispatchQueue.main.async {
            self.statusLoad?(.loading(true))
        }
        
        useCase.getHeroes { [weak self] (result: Result<[DragonBallHero], NetworkErrors>) in
            
            switch result {

            case .success(let heroes):
                self?.dataHeroes = heroes
                self?.statusLoad?(.loaded)
                
            case .failure(let error):
                var messageError = "Unknown Error"
                switch error {
                case .malformedURL:
                    messageError = "malformedURL"
                case .statusCode(code: let code):
                    messageError = "statusCode \(String(describing: code))"
                case .failDecodingData:
                    messageError = "failDecodingData"
                case .noData:
                    messageError = "noData"
                case .tokenNotFound:
                    messageError = "tokenNotFound"
                case .unknown:
                    messageError = "unknown"
                }
                DispatchQueue.main.async {
                    self?.statusLoad?(.networkError(messageError))
                }
                
            }
        }
    }
    
    
    
}
