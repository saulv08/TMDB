//
//  SignUpView.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit

protocol SignUpViewDelegate: AnyObject {
    func tapImage()
    func signUpUser(image: UIImage, username: String, password: String)
    func tapLogin()
}

class SignUpView: UIView {
    weak var delegate: SignUpViewDelegate?
    let titleLabel = UILabel()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let imageUserView = UIImageView()
    let nextButton = UIButton()
    let loginButton = UIButton()
    var imageSelected: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
    }

    private func setupView() {
       
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
        titleLabel.textAlignment = .center
        titleLabel.text = "Registrarse"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textColor = .white
        addSubview(imageUserView)
        imageUserView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageUserView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageUserView.heightAnchor.constraint(equalToConstant: 140),
            imageUserView.widthAnchor.constraint(equalToConstant: 140),
            imageUserView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                               constant: 20)
        ])
        imageUserView.image = UIImage(systemName: "photo.circle")
        imageUserView.clipsToBounds = true
        imageUserView.layer.masksToBounds = true
        imageUserView.layer.borderColor = UIColor.white.cgColor
        imageUserView.layer.borderWidth = 3
        imageUserView.isUserInteractionEnabled = true
        imageUserView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(tapImageUserView)))
        imageUserView.contentMode = .scaleAspectFill
        
        addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            usernameTextField.topAnchor.constraint(equalTo: imageUserView.bottomAnchor, constant: 40),
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
        
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        loginButton.setTitle("regresar", for: .normal)
        loginButton.setTitleColor(UIColor.systemGray6, for: .normal)
        loginButton.addTarget(self,
                              action: #selector(tapLogin),
                              for: .touchUpInside)
        
        addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            nextButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -10),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        nextButton.setTitle("Aceptar", for: .normal)
        nextButton.backgroundColor = UIColor.systemGray
        nextButton.layer.masksToBounds = true
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 4
        nextButton.isEnabled = false
        nextButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapLogin() {
        delegate?.tapLogin()
    }
    
    @objc func tapButton() {
        guard let image = imageSelected,
              let username = usernameTextField.text,
              let password = passwordTextField.text else {
                  return
              }
        delegate?.signUpUser(image: image, username: username, password: password)
    }
    
    public func updateImageUser(_ image: UIImage) {
        imageUserView.image = image
        imageSelected = image
        isCompleted()
    }
    
    @objc func tapImageUserView() {
        delegate?.tapImage()
    }
    
    public func fieldsCompleted() -> Bool {
        guard let _ = imageSelected,
              let username = usernameTextField.text,
              !username.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty else {
                  return false
              }
        return true
    }
    
    private func isCompleted() {
        if fieldsCompleted() {
            nextButton.backgroundColor = UIColor.systemBlue
            nextButton.isEnabled = true
        } else {
            nextButton.backgroundColor = UIColor.gray
            nextButton.isEnabled = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageUserView.layer.cornerRadius = imageUserView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        isCompleted()
        return true
    }
}
