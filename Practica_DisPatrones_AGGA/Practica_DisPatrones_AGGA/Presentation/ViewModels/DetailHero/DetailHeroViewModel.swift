//
//  DetailHeroModelView.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 24/1/24.
//

import Foundation

final class DetailHeroViewModel {
    
    //Recepcion nameHero
    var nameReceived: String?
    
    //Bindign con UI
    var statusLoad: ((GenericStatusLoad) -> Void)?
    var useCase: HeroesUseCaseProtocol
    
    var dataHero: DragonBallHero?
    var hasTransform: Bool?

    init(useCase: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCase = useCase
    }
    
    func loadHero(){
        
        DispatchQueue.main.async {
            self.statusLoad?(.loading(true))
        }
        
        guard let idHero = nameReceived else {
            DispatchQueue.main.async {
                self.statusLoad?(.networkError("Error especial, nombre Heroe no recibido"))
            }
            return
        }
        
        useCase.getHeroes { [weak self] (result: Result<[DragonBallHero], NetworkErrors>) in
            
            switch result {
                
            case .success(let hero):
                self?.dataHero = hero.first
                DispatchQueue.main.async {
                    self?.statusLoad?(.loaded)
                }
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
    
    func checkTransform(id: String, completion: @escaping (Bool) -> Void) {
        APIProvider.getData(endpoint: EndPoints.transform.rawValue, dataRequest: "id", value: id) { (result: Result<[DragonBallTransforms], NetworkErrors>) in
            switch result {
            case .success(let transform):
                let hasTransform = !transform.isEmpty
                print(hasTransform)
                completion(hasTransform)

            case .failure(_):
                print(false)
                completion(false)
            }
        }
    }
}
