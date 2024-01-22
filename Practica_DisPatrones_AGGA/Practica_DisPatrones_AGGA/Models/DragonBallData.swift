//
//  DragonBallData.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import Foundation

struct DragonBallHero: Decodable {
    let id: String
    let name: String
    let photo: String
    let description: String
    
    let heroTransformations: [DragonBallTransforms]
}

struct DragonBallTransforms: Decodable {
    let name: String
    let photo: String
    let description: String
}
