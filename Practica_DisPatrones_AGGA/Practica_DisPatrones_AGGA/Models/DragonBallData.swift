//
//  DragonBallData.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import Foundation

struct DragonBallHero: Decodable {
    let name: String
    let id: String
    let favorite: Bool
    let description: String
    let photo: String
}

struct DragonBallTransforms: Decodable {
    let name: String
    let photo: String
    let description: String
}
