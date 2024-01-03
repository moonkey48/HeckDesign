//
//  AddItemViewModel.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 1/2/24.
//

import SwiftUI

class AddItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var selectedType: GroupType = .heck
    @Published var selectedImage = UIImage(named: "addItemDefault")!
    @Published var isSelecting = false
    @Published var isLoading = false
    @Published var newId = UUID().uuidString
    
    private let listModel = ListModel()
    private let fileManager = ImageFileManager.shared
    
    func addNewItem() {
        fileManager.saveImage(image: self.selectedImage, name: newId, onSuccess: { _ in
            self.listModel.createItem(
                title: self.title,
                desciption: self.description,
                groupType: self.selectedType,
                imageName: self.newId) { res in
                    switch res {
                    case .success(let success):
                        print("success to create new Item \(success)")
                    case .failure(let failure):
                        print("fail to create new Item \(failure)")
                    }
                }
            self.isLoading = false
        })
    }
}
