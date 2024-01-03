//
//  Model.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/08.
//

import CoreData
import SwiftUI

enum ModelError: Error {
    case failToSave
    case failToConvertType
    case failToCreate
    case failToUpdate
    case failToDelete
}

struct ListModel {
    private let persistenceController = PersistenceController.shared
    private let imageFileManager = ImageFileManager.shared
    
    private func saveContext() throws {
        do {
            try persistenceController.container.viewContext.save()
        } catch {
            throw ModelError.failToSave
        }
    }
    
    func createItem(
        title: String,
        desciption: String,
        groupType: GroupType,
        imageName: String,
        completion: @escaping (Result<Bool, ModelError>) -> Void
    ) {
        let newItem = CoreListItem(context: persistenceController.container.viewContext)
        newItem.title = title
        newItem.designDescription = desciption
        newItem.groupType = groupType.rawValue
        newItem.imageName = imageName
        newItem.uid = UUID().uuidString
        newItem.isFavorite = false
        newItem.generatedDate = Date()
        
        do {
            try saveContext()
            completion(.success(true))
        } catch {
            completion(.failure(.failToCreate))
        }
    }
    
    func updateItem(
        _ coreListItem: NSManagedObject,
        title: String,
        description: String,
        groupType: GroupType,
        completion: @escaping (Result<Bool, ModelError>) -> Void
    ) {
        guard let listItem = coreListItem as? CoreListItem else {
            completion(.failure(.failToConvertType))
            return
        }
        listItem.title = title
        listItem.designDescription = description
        listItem.groupType = groupType.rawValue
        
        do {
            try saveContext()
            completion(.success(true))
        } catch {
            completion(.failure(.failToUpdate))
        }
    }
    
    func deleteItem(
        _ object: NSManagedObject,
        imageName: String,
        completion: @escaping (Result<Bool, ModelError>) -> Void
    ) {
        persistenceController.container.viewContext.delete(object)
        
        imageFileManager.deleteImage(named: imageName) { res in
            if res {
                print("success to delete Image")
            } else {
                print("fail to delete Image")
            }
        }
        do {
            try saveContext()
            completion(.success(true))
        } catch {
            completion(.failure(.failToDelete))
        }
    }
}

