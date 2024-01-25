//
//  LoginViewModel.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 23/1/24.
//

import Foundation

final class LoginViewModel {
    
    //MARK: - Binding
    var loginViewState: ((LoginStatusLoad) -> Void)?
    private let loginUseCase = LoginUseCase()
    
    //MARK: - Metodo Login
    func onLoginButton(email: String?, password: String?) {
        loginViewState?(.loading(true))
        
        //Check mail y password
        guard let email = email, let password = password, isValid(email,password) else {
            loginViewState?(.loading(false))
            loginViewState?(.loginError("email o contraseña incorrectos"))
            return
        }
        
        doLoginWith(email: email, password: password)
    }
    
    //MARK: - Validation Methods
    private func isValid(_ email: String,_ password: String) -> Bool {
        (email.isEmpty == false && email.contains("@")) || (password.isEmpty == false && password.count >= 4)
    }
    
    //MARK: - Login Methods
    private func doLoginWith(email: String, password: String) {
        //LLAMAR AL CASO DE USO PARA HACER LA PETICION DE LOGIN Y OBTENER EL TOKEN
        loginUseCase.login(user: email, password: password) { [weak self] result in
            
            switch result {
                
            case .success(_):
                DispatchQueue.main.async {
                    self?.loginViewState?(.loaded)
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
                    self?.loginViewState?(.networkError(messageError))
                }
                
            }
        }
    }
    
    
}
