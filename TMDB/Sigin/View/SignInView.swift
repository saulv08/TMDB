//
//  SignInView.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit

protocol SignInViewDelegate: AnyObject {
    func signInUser(username: String, password: String)
    func signUp()
}

class SignInView: UIView {
    weak var delegate: SignInViewDelegate?
    let titleLabel = UILabel()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signUpButton = UIButton()
    let imageViewLogo = UIImageView()
    var saludoLabel : UILabel?
    let colorBlue = UIColor(red: 89/255, green: 144/255, blue: 255/255, alpha: 1.00)
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
       self.backgroundColor = .clear
    }
    
    private func setupView() {
        //saludoLabel = UILabel(frame: CGRect(x: width/3, y: 30, width: width/3, height: 70))

        let date = Date()
        let calendar = Calendar.current
        let hora = calendar.component(.hour, from: date)
        print (hora)
        

        if hora > 0 && hora < 12{
            titleLabel.text = "¡Buenos días!"
        }else if hora >= 12 && hora < 19{
            titleLabel.text = "¡Buenas tardes!"
        }else if hora >= 19{
            titleLabel.text = "¡Buenas noches!"
        }
        
//        saludoLabel?.textAlignment = .left
//        saludoLabel?.textColor = .white
//        saludoLabel?.adjustsFontSizeToFitWidth = true
//        saludoLabel?.font = .boldSystemFont(ofSize: 22)
//        addSubview(saludoLabel!)
//
        

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        titleLabel.textAlignment = .center
        //titleLabel.text = "Iniciar sesión"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textColor = .white
        addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        usernameTextField.placeholder = "usuario"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.delegate = self
        usernameTextField.autocapitalizationType = .none
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        passwordTextField.placeholder = "contraseña"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        imageViewLogo.image = UIImage(named: "open-book")
        addSubview(imageViewLogo)
        imageViewLogo.translatesAutoresizingMaskIntoConstraints = false
        imageViewLogo.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageViewLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageViewLogo.heightAnchor.constraint(equalToConstant: 260),
            imageViewLogo.widthAnchor.constraint(equalToConstant: 260),
            imageViewLogo.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                               constant: 50)
        ])
        addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            signUpButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        signUpButton.setTitle("Registrarse", for: .normal)
        signUpButton.setTitleColor(UIColor.systemGray6, for: .normal)
        signUpButton.addTarget(self,
                               action: #selector(tapSignUp),
                               for: .touchUpInside)
        
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            loginButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        loginButton.setTitle("Ingresar", for: .normal)
        loginButton.backgroundColor = UIColor.systemGray
        loginButton.layer.masksToBounds = true
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 4
        loginButton.isEnabled = false
        loginButton.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
    }
    
    @objc func tapSignUp() {
        delegate?.signUp()
    }
    
    @objc func tapLogin() {
        guard let username = usernameTextField.text,
              !username.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty else {
                  return
              }
        delegate?.signInUser(username: username,
                             password: password)
    }
    
    public func fieldsCompleted() -> Bool {
        guard let username = usernameTextField.text,
              !username.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty else {
                  return false
              }
        return true
    }
    
    private func isCompleted() {
        if fieldsCompleted() {
            loginButton.backgroundColor = UIColor.systemGreen
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = UIColor.gray
            loginButton.isEnabled = false
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        isCompleted()
        return true
    }
}

