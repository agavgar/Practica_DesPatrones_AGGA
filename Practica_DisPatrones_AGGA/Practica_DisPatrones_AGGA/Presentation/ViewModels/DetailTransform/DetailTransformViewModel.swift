//
//  DetailTransformViewModel.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 26/1/24.
//

import Foundation

struct DetailTransformViewModel{
    //Recepcion nameHero
    var transformReceived: DragonBallTransforms
    
    init(transformReceived: DragonBallTransforms) {
        self.transformReceived = transformReceived
    }
}
