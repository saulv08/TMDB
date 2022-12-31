//
//  MainController.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit
import CoreData

class MainController: UIViewController {
    private(set) var managedObjectContext: NSManagedObjectContext
    let splashView = SplashView()
    let imageViewLogo = UIImageView()
//    let colorBlue = UIColor(red: 89/255, green: 144/255, blue: 255/255, alpha: 1.00)
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        splashView.animateView {
            self.initialController()
            
        }
    }
    
    private func initialController() {

        if existSession() {
            showHomeController()
        } else {
            let signInController = SignInViewController(context: managedObjectContext)
            signInController.modalPresentationStyle = .fullScreen
            signInController.delegate = self
            present(signInController, animated: false)
        }
    }
    
    private func existSession() -> Bool {
        guard let _ = UserDefaults.standard.object(forKey: "username"),
              let _ = UserDefaults.standard.object(forKey: "password") else {
                  return false
              }
        return true
    }
    
    private func showHomeController() {
        
        let tabBar = TabBarController(context: managedObjectContext)
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.setBackgroundImage("a", contentMode: .scaleAspectFill)
        imageViewLogo.image = UIImage(named: "open-book")
        view.addSubview(imageViewLogo)
        imageViewLogo.translatesAutoresizingMaskIntoConstraints = false
        imageViewLogo.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageViewLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageViewLogo.heightAnchor.constraint(equalToConstant: 200),
            imageViewLogo.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(splashView)
//        splashView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            splashView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            splashView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            splashView.heightAnchor.constraint(equalToConstant: 200),
//            splashView.widthAnchor.constraint(equalToConstant: 200)
//        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainController: SignInDelegate {
    func signInComplete() {
        showHomeController()
        self.setBackgroundImage("asd", contentMode: .scaleAspectFill)

    }
}

