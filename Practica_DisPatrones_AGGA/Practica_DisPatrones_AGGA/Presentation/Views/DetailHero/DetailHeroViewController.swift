//
//  DetailHeroViewController.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 24/1/24.
//

import UIKit

class DetailHeroViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UITextView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var transformButton: UIButton!
    
    //MARK: - Binding ViewModel
    private var viewModel: DetailHeroViewModel
    
    //MARK: - Inits
    init(viewModel: DetailHeroViewModel = DetailHeroViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setUpView(UINavItem: self.navigationItem)
        self.navigationController?.navigationBar.tintColor = .DBYellow
        
        viewModel.loadHero()
        setObservers()
    }
    
    //MARK: - IBAction
    @IBAction func transformButtonTap(_ sender: UIButton) {
        navigateTable()
    }
    
}

extension DetailHeroViewController {
    
    private func setObservers() {
        
        viewModel.statusLoad = { [weak self] status in
            
            switch status {
                
            case .loading(_):
                DispatchQueue.main.async {
                    self?.loadingView.isHidden = false
                }
            case .loaded:
                
                DispatchQueue.main.async {
                    
                    guard let hero = self?.viewModel.dataHero else {
                        self?.viewModel.statusLoad?(.networkError("Error al recuperar los datos del heroe"))
                        return
                    }
                    
                    self?.configure(with: hero)
                    
                    self?.viewModel.checkTransform(id: hero.id) { isEmpty in
                        DispatchQueue.main.async {
                            self?.transformButton.isHidden = !isEmpty
                            self?.transformButton.tintColor = .DBYellow
                        }
                    }
                    
                    self?.loadingView.isHidden = true
                }
                
            case .networkError(let error):
                self?.showAlert(message: error)
            }
            
        }
        
    }
    
    func configure(with hero: DragonBallHero){
        
        heroName.text = hero.name
        heroImage.setImage(url: hero.photo)
        heroDescription.text = hero.description
    }
    
    func navigateTable(){
        let nextVM = TransformTableViewModel(useCase: TransformUseCase())
        nextVM.idReceived = viewModel.dataHero?.id
        let nextVC = TransformTableViewController(viewModel: nextVM)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func showAlert(message: String){
        let alertController = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Accept", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
