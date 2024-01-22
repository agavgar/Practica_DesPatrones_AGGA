//
//  NavItem + Confi.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import UIKit

extension UINavigationItem {

    
    func setUpView(UINavItem: UINavigationItem) {
    
        UINavItem.titleView?.backgroundColor = .DBOrange
        UINavItem.titleView?.tintColor = .DBYellow
        
        let logo = UIImage(named: "DragonBallLogo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        UINavItem.titleView = imageView
    }
    
    func setRightBar(UInavItem: UINavigationItem,UInavCont: UINavigationController ){
        //UInavItem.rightBarButtonItem = UIBarButtonItem(title: "goHeroes", style: .plain, target: self, action: #selector(goHeroes))
        //UInavItem.backBarButtonItem?.title = "Transform"
        
    }
    /*
    @objc
    func goHeroes(_sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    */
    
}
