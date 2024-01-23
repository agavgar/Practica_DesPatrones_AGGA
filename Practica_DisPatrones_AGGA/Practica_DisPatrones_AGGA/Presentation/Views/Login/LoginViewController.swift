//
//  LoginViewController.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    //MARK: - Models
    private var viewModel: LoginViewModel
    
    //MARK: - Init
    init(viewModel: LoginViewModel = LoginViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservers()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func loginButtonTap(_ sender: UIButton) {
        
        viewModel.onLoginButton(email: emailTextField.text, password: passwordTextField.text)
    }
    
}

extension LoginViewController {
    
    func setObservers(){
        
        
        viewModel.loginViewState = { [weak self] status in
        
            switch status {
            case .loading(let isLoading):
                self?.loadingView.isHidden = !isLoading
            case .loaded:
                DispatchQueue.main.async {
                    self?.loadingView.isHidden = true
                }
                //MARK: - Todo navegar a la home
                self?.navigateToHome()
            case .showError(let error):
                self?.errorLabel.text = error
                self?.errorLabel.isHidden = (error == nil || error?.isEmpty == true)
            }
        }
    }
    
    private func navigateToHome(){
        
        DispatchQueue.main.async {
            let nextVC = HomeCollectionViewController()
            self.navigationController?.setViewControllers([nextVC], animated: true)
        }
        
    }
}
