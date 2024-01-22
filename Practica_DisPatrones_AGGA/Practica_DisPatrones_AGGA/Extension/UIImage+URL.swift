//
//  UIImage+URL.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import UIKit

extension UIImageView {
    
    func setImage(url:String){
        guard let urlString = URL(string: url) else { return }
        
        downloadWithURLSession(url: urlString) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    private func downloadWithURLSession(url: URL,completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, _ in
            guard let data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        .resume()
    }
    
}
