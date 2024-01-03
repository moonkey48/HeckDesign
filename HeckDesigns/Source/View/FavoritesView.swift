//
//  FavoritesView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/16.
//

import SwiftUI

struct FavoritesView: View {
    @FetchRequest(entity: CoreListItem.entity(), sortDescriptors: [NSSortDescriptor(key: "generatedDate", ascending: false)], predicate: NSPredicate(format: "isFavorite == TRUE")) var favoriteList: FetchedResults<CoreListItem>
    
    var groupType: GroupType
    private let columns = [ GridItem(.adaptive(minimum: 170)) ]
    private let imageFileManager = ImageFileManager.shared
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(favoriteList, id: \.self) { item in
                    NavigationLink {
                        ListItemView(item: item)
                    } label: {
                        VStack(alignment: .leading) {
                            Image(uiImage: imageFileManager.getSavedImage(named: item.imageName ?? "addItemDefault")
                                   ?? UIImage(named: "addItemDefault")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170, height: 170)
                                .cornerRadius(10)
                            Text(item.title ?? "")
                                .font(Font.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.textBlack)
                        }
                    }
                    
                }
            }
        }
        .onAppear {
            favoriteList.nsPredicate = NSPredicate(format: "isFavorite == TRUE && groupType == %@", groupType.rawValue)
        }
        .navigationTitle("Favorites")
    }
}
