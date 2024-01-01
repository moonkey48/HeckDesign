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
        
    func deleteItem(item: NSManagedObject){
        isEdit = false
        listModel.deleteItem(item) { res in
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
    
//    func updateItem(){
//        item.title = self.title
//        item.description = self.description
//        item.image = self.image
//        isEdit = false
//        fileManager.deleteImage(named: "item\(item.uid)") { _ in
//        }
//        fileManager.saveImage(image: self.image, name: "item\(item.uid)", onSuccess: { _ in
//        })
//        dbHelper.updateData(id: item.id, title: self.title, description: self.description, groupType: item.group, isFavorite: item.isFavorite, imageName: "item\(item.uid)")
//    }
//    


}
