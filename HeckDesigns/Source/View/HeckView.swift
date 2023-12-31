//
//  HeckView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import CoreData
import SwiftUI

struct HeckView: View {
    @State private var showAddModal = false
    @FetchRequest(entity: CoreListItem.entity(), sortDescriptors: [
        NSSortDescriptor(key: "generatedDate", ascending: false)
    ], predicate: NSPredicate(format: "groupType == %@", "heck")) var itemList: FetchedResults<CoreListItem>

    private let columns = [GridItem(.adaptive(minimum: 170))]
    private let imageFileManager = ImageFileManager.shared
    
    var body: some View {
        NavigationStack {
            ScrollView {
                FavoriteSampleView(itemList: itemList, groupType: .heck)
                LazyVGrid(columns: columns) {
                    ForEach(itemList, id: \.uid) { item in
                        NavigationLink {
                            ListItemView(item: item)
                        } label: {
                            VStack(alignment: .leading) {
                                ZStack {
                                    Image(
                                        uiImage: imageFileManager.getSavedImage(
                                            named: item.imageName ?? "addItemDefault")
                                        ?? UIImage(named: "addItemDefault")!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 170, height: 170)
                                        .cornerRadius(10)
                                    if item.isFavorite == true {
                                        VStack {
                                            Spacer()
                                                .frame(height: 140)
                                            HStack {
                                                Spacer()
                                                    .frame(width: 140)
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(Color.white)
                                                    .opacity(0.9)
                                            }
                                        }
                                    }
                                }
                                Text(item.title ?? "")
                                    .font(Font.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color.textBlack)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Hecks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddModal = true
                    } label: {
                        Label("Edit", systemImage: "plus")
                            .navButton()
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $showAddModal) {
                AddItemView()
            }
        }
    }
}


struct HeckView_Previews: PreviewProvider {
    static var previews: some View {
        HeckView()
    }
}
