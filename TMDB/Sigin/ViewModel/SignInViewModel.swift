//
//  SignInViewModel.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import Foundation
import UIKit
import CoreData

class LoginViewModel {
    private(set) var managedObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
    }
    
    public func saveImage(_ image: UIImage) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let nameFile = "imageUser_\(UUID().uuidString.dropLast(4)).jpg"
        let fileURL = documentsDirectory.appendingPathComponent(nameFile)
        guard let data = image.jpegData(compressionQuality: 1) else { return nil }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch let removeError {
                print("couldn't remove file at path", removeError)
                return nil
            }
        }
        do {
            try data.write(to: fileURL)
            return nameFile
        } catch let error {
            print("error saving file with error", error)
            return nil
        }
    }
    
    func saveUser(username: String, password: String, imageName: String) {
        managedObjectContext.performChanges {
            UserModel.insert(into: self.managedObjectContext,
                             username: username,
                             password: password,
                             imageName: imageName)
        }
        saveSession(username: username, password: password)
    }
    
    public func saveSession(username: String, password: String) {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
    }
    
}

