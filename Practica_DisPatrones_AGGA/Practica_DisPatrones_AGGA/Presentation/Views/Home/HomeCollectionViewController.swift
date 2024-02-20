//
//  HomeViewController.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 23/1/24.
//

import UIKit

final class HomeCollectionViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Models
    private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
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
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UINib(nibName: HomeCustomCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: HomeCustomCollectionViewCell.identifier)

        viewModel.getHeroes()
        setObservers()
    }
    
    private func setObservers() {
        
        viewModel.statusLoad = { [weak self] status in
           
            switch status {
                
            case .loading(_):
                DispatchQueue.main.async {
                    self?.loadingView.isHidden = false
                }
            case .loaded:
                DispatchQueue.main.async {
                    self?.loadingView.isHidden = true
                    self?.collectionView.reloadData()
                }

            case .networkError(let error):
                self?.showAlert(message: error)
            }
            
        }
        
    }
    
    private func showAlert(message: String){
        let alertController = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Accept", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setRightBar(UInavItem: UINavigationItem,UInavCont: UINavigationController ){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOut))
        
        navigationItem.rightBarButtonItem?.tintColor = .DBYellow
        
    }
    
    @objc
    func logOut(_sender: Any) {
        let nextVM = LoginViewModel()
        let nextVC = LoginViewController(viewModel: nextVM)
        self.navigationController?.setViewControllers([nextVC], animated: true)
        
    }
    

}

//MARK: - Extension Delegate
extension HomeCollectionViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigateDetail(indexPath: indexPath)
        //navigateFAKETransformTableView(indexPath: indexPath)
    }
    
    func navigateDetail(indexPath: IndexPath){
        let nextVM = DetailHeroViewModel(useCase: HeroesUseCase())
        nextVM.nameReceived = viewModel.dataHeroes[indexPath.row].name
        let nextVC = DetailHeroViewController(viewModel: nextVM)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func navigateFAKETransformTableView(indexPath: IndexPath){
        let nextVM = TransformTableViewModel(useCase: TransformUseCase())
        nextVM.idReceived = viewModel.dataHeroes[indexPath.row].id
        let nextVC = TransformTableViewController(viewModel: nextVM)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

//MARK: - Extension DataSource
extension HomeCollectionViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCustomCollectionViewCell.identifier, for: indexPath) as? HomeCustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        let hero = viewModel.dataHeroes[indexPath.row]
        cell.configure(with: hero)
        return cell
        
    }
    
    
    
}
