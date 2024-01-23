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
    let loginUseCase = LoginUseCase()
    
    //MARK: - Models
    private var token: String? {
        get {
            if let token = LocalDataModel.getToken(){
                return token
            }
            return nil
        }
        set{
            if let token = newValue {
                LocalDataModel.save(token: token)
            }
        }
    }
    
    //MARK: - Metodo Login
    func onLoginButton(email: String?, password: String?) {
        loginViewState?(.loading(true))
        
        //Check mail y password
        guard let email = email, let password = password, isValid(email,password) else {
            loginViewState?(.loading(false))
            loginViewState?(.showError("email o contraseña incorrectos"))
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
            case let .success(token):
                self?.token = token
                LocalDataModel.save(token: token)
                self?.loginViewState?(.loaded)
            case let .failure(error):
                print(error)
                
            }
        }
    }
    
    
}
