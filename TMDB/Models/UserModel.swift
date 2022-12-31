//
//  UserModel.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import CoreData

final class UserModel: NSManagedObject, Managed {
    @NSManaged fileprivate(set) var uid: String
    @NSManaged var username: String
    @NSManaged var password: String
    @NSManaged var imageURL: String
    
    static func insert(into context: NSManagedObjectContext,
                       username: String,
                       password: String,
                       imageName: String)  {
        let userModel: UserModel = context.insertObject()
        userModel.username = username
        userModel.password = password
        userModel.imageURL = imageName
    }
    
    static func fetch(name: String, pwd: String, from context: NSManagedObjectContext) -> UserModel? {
        let predicate = NSPredicate(format: "%K == %@ AND %K == %@",
                                    #keyPath(username),
                                    name,
                                    #keyPath(password),
                                    pwd)
        let request = UserModel.sortedFetchRequest
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            return nil
        }
    }
    
    static func isUserRegister(name: String,
                               pwd: String,
                               from context: NSManagedObjectContext) -> Bool {
        let predicate = NSPredicate(format: "%K == %@ AND %K == %@",
                                    #keyPath(username),
                                    name,
                                    #keyPath(password),
                                    pwd)
        let request = UserModel.sortedFetchRequest
        request.predicate = predicate
        do {
            if let _ =  try context.fetch(request).first {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
