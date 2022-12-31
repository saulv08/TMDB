//
//  SiginViewController.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit
import CoreData

protocol SignInDelegate: AnyObject {
    func signInComplete()
}

class SignInViewController: UIViewController {
    weak var delegate: SignInDelegate?
    private(set) var managedObjectContext: NSManagedObjectContext
    let signInView = SignInView()
    let viewModel: LoginViewModel
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
        viewModel = LoginViewModel(context: managedObjectContext)
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        self.setBackgroundImage("a", contentMode: .scaleAspectFill)
        setup()
    }

    private func setup() {
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(signInView)
        signInView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signInView.topAnchor.constraint(equalTo: view.topAnchor),
            signInView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        signInView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInViewController: SignInViewDelegate {
    func signUp() {
        
        let signUpController = SignUpViewController(context: managedObjectContext)
        signUpController.modalPresentationStyle = .fullScreen
        signUpController.delegate  = self
        present(signUpController, animated: true)
    }
    
    
    func signInUser(username: String, password: String) {
        if UserModel.isUserRegister(name: username, pwd: password, from: managedObjectContext) {
            viewModel.saveSession(username: username,
                                  password: password)
            signUpComplete()
        } else {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Verifica tu username y password",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            present(alertController,
                    animated: true)
        }
    }
}

extension SignInViewController: SignUpDelegate {
    func signUpComplete() {
        dismiss(animated: true) {
            self.delegate?.signInComplete()
        }
    }
}
