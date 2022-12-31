//
//  SignupViewController.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit
import CoreData

protocol SignUpDelegate: AnyObject {
    func signUpComplete()
}

class SignUpViewController: UIViewController {
    weak var delegate: SignUpDelegate?
    private(set) var managedObjectContext: NSManagedObjectContext
    let signUpView = SignUpView()
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
        //self.setBackgroundImage("asd", contentMode: .scaleAspectFill)
        view.addSubview(signUpView)
        signUpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signUpView.topAnchor.constraint(equalTo: view.topAnchor),
            signUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        signUpView.delegate = self
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            present(imagePicker, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpViewController: SignUpViewDelegate {
    func signUpUser(image: UIImage, username: String, password: String) {
        if let imageURL = viewModel.saveImage(image) {
            viewModel.saveUser(username: username,
                               password: password,
                               imageName: imageURL)
            dismiss(animated: true) {
                self.delegate?.signUpComplete()
            }
        }
    }
    
    func tapImage() {
        let alert = UIAlertController(title: "Usar de tu galeria", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Tomar foto", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tapLogin() {
        dismiss(animated: true)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            signUpView.updateImageUser(pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


