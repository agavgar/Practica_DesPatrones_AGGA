//
//  LocalDataModel.swift
//  Practica_FundIOS_AGGA
//
//  Created by Alejandro Alberto Gavira García on 9/1/24.
//

import Foundation

struct LocalDataModel {
    private enum Constants{
        static let tokenKey = "DBToken"
    }
    
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        userDefaults.string(forKey: Constants.tokenKey)
    }
    
    static func save(token: String){
        if !checkToken(){
            userDefaults.set(token, forKey: Constants.tokenKey)
        }
    }
    
    static func deleteToken(){
        userDefaults.removeObject(forKey: Constants.tokenKey)
    }
    
    static func checkToken()->Bool{
        guard userDefaults.string(forKey: Constants.tokenKey) != nil else {
            return false
        }
        return true
    }
    
}
