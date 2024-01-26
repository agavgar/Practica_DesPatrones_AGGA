//
//  NavItem + Confi.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import UIKit

extension UINavigationItem {

    
    func setUpView(UINavItem: UINavigationItem) {
        
        let logo = UIImage(named: "DragonBallLogo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        UINavItem.titleView = imageView
        UINavItem.titleView?.backgroundColor = .clear
        
        UINavItem.rightBarButtonItem?.tintColor = .DBYellow
        UINavItem.leftBarButtonItem?.tintColor = .DBYellow
        UINavItem.backBarButtonItem?.tintColor = .DBYellow
        
    }
    
    
}
