//
//  TransformTableViewController.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 25/1/24.
//

import UIKit

class TransformTableViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    private var viewModel: TransformTableViewModel
    
    init(viewModel: TransformTableViewModel = TransformTableViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setUpView(UINavItem: self.navigationItem)
        self.navigationController?.navigationBar.tintColor = .DBYellow
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TransformTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TransformTableViewCell.identifier)
        
        tableView.backgroundColor = .clear
        tableView.rowHeight = 155
        
        
        
        viewModel.loadTransformations()
        setObservers()
        // Do any additional setup after loading the view.
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
                    self?.tableView.reloadData()
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



}

extension TransformTableViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigateDetail(indexPath: indexPath)
        
        
    }
    
    func navigateDetail(indexPath: IndexPath){
        
        guard let transform = viewModel.dataTransform?[indexPath.row] else {
            return
        }
        
        let nextVM = DetailTransformViewModel(transformReceived: transform)
        let nextVC = DetailTransformViewController(viewModel: nextVM)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension TransformTableViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataTransform?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransformTableViewCell.identifier, for: indexPath) as? TransformTableViewCell else {
            return UITableViewCell()
        }
        
        guard let transform = viewModel.dataTransform?[indexPath.row] else {
            viewModel.statusLoad?(.networkError("Error asigning transformations"))
            return UITableViewCell()
        }
        cell.configure(with: transform)
        return cell
        
    }
    
    
}
