//
//  LocalDataModel.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import Foundation

struct LocalDataModel {
    
    private enum Constant{
        static let tokenKey = "DBToken"
    }
    
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        userDefaults.string(forKey: Constant.tokenKey)
    }
    
    static func save(token: String){
        userDefaults.set(token, forKey: Constant.tokenKey)
    }
    
    static func deleteToken(){
        userDefaults.removeObject(forKey: Constant.tokenKey)
    }
    
}
