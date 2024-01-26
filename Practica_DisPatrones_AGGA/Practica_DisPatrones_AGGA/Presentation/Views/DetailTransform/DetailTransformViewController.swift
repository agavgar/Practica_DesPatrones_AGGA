//
//  DetailTransformViewController.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 26/1/24.
//

import UIKit

final class DetailTransformViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var transformName: UILabel!
    @IBOutlet weak var transformImage: UIImageView!
    @IBOutlet weak var transformDescription: UITextView!
    
    //MARK: - Binding ViewModel
    private var viewModel: DetailTransformViewModel
    
    init(viewModel: DetailTransformViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setUpView(UINavItem: self.navigationItem)
        setRightBar(UInavItem: self.navigationItem, UInavCont: self.navigationController!)
        
        configure(with: viewModel.transformReceived)
        
        
    }

    func configure(with transform: DragonBallTransforms){
        
        transformName.text = transform.name
        transformImage.setImage(url: transform.photo)
        transformDescription.text = transform.description
    }
    
    func setRightBar(UInavItem: UINavigationItem,UInavCont: UINavigationController ){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "goHeroes", style: .plain, target: self, action: #selector(goHeroes))
        
        navigationItem.rightBarButtonItem?.tintColor = .DBYellow
        
    }
    
    @objc
    func goHeroes(_sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }


}
