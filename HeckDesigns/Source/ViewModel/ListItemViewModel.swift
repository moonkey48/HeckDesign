//
//  ListItemViewModel.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 1/1/24.
//

import CoreData
import SwiftUI

class ListItemViewModel: ObservableObject {
    @Published var isEdit = false
    @Published var isDelete = false
    @Published var isSelectingImage = false
    @Published var image = UIImage(named: "addItemDefault")!
    @Published var title = ""
    @Published var description = ""
    @Published var isFavorite = false
    
    private let listModel = ListModel()
    private let fileManager = ImageFileManager.shared
        
    func deleteItem(item: NSManagedObject, imageName: String){
        isEdit = false
        listModel.deleteItem(item, imageName: imageName) { res in
            switch res {
            case .success(let isSuccess):
                print("success to delete item \(isSuccess)")
            case .failure(let error):
                print("fail to delete error \(error)")
            }
        }
        guard let item = item as? CoreListItem else {
            return
        }
        fileManager.deleteImage(named: "item\(item.id)") { _ in
        }
    }
    
    func toggleIsFavorite(item: CoreListItem) {
        item.isFavorite.toggle()
        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            print("fail to toggle isFavorite")
        }
    }

}
