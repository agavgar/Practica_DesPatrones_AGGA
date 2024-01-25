//
//  TransformTableViewModel.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 25/1/24.
//

import Foundation

final class TransformTableViewModel{
    
    //Dato idHero
    var idReceived: String?
    
    //Binding con UI
    var statusLoad: ((GenericStatusLoad) -> Void)?
    var useCase: GenericArrayUseCaseProtocol
    
    var dataTransform: [DragonBallTransforms]?
    
    init(useCase: GenericArrayUseCaseProtocol = GenericArrayUseCase()){
        self.useCase = useCase
    }
    
    func loadTransformations(){
     
        DispatchQueue.main.async {
            self.statusLoad?(.loading(true))
        }
        
        guard let value = idReceived else {
            DispatchQueue.main.async {
                self.statusLoad?(.networkError("Special error: idData non received"))
            }
            return
        }
        
        useCase.login(endpoint:EndPoints.transform.rawValue ,dataRequest: "id", value: value) { [weak self] (result: Result<[DragonBallTransforms], NetworkErrors>) in
            
            switch result{
                
            case .success(let transform):
                self?.dataTransform = transform
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
    
}
