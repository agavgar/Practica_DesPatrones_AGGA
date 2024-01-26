//
//  TransformTableViewCell.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 23/1/24.
//

import UIKit

class TransformTableViewCell: UITableViewCell {

    //MARK: - Identifier
    static let identifier = "TransformTableViewCell"
    
    //MARK: - Outlets
    @IBOutlet weak var transformLabel: UILabel!
    @IBOutlet weak var transformImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    
    
    //MARK: - Configure
    func configure(with transform: DragonBallTransforms){
        transformLabel.text = transform.name
        descriptionText.text = transform.description
        transformImage.setImage(url: transform.photo)
    }
    
}
