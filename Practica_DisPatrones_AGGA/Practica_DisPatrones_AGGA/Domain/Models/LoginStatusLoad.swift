//
//  LoginStatusLoad.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 23/1/24.
//

import Foundation

enum LoginStatusLoad {
    case loading(_ isLoading: Bool)
    case loaded
    case showError(_ error: String?)
}
