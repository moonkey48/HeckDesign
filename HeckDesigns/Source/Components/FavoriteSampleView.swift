//
//  FavoriteSampleView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/16.
//

import SwiftUI

struct FavoriteSampleView: View {
    var itemList: FetchedResults<CoreListItem>
    var groupType: GroupType
    
    private let imageFileManager = ImageFileManager.shared
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Favorites")
                    .subTitle()
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
                Spacer()
                NavigationLink {
                    FavoritesView(groupType: groupType)
                } label: {
                    Text("전체보기")
                        .navButton()
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(itemList.filter { $0.isFavorite == true }, id: \.self) { item in
                        NavigationLink {
                            ListItemView(item: item)
                        } label: {
                            VStack(alignment: .leading) {
                                Image(
                                    uiImage: imageFileManager.getSavedImage(named: item.imageName ?? "addItemDefault")
                                        ?? UIImage(named: "addItemDefault")!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 140)
                                    .cornerRadius(10)
                                Text(item.title ?? "")
                                    .font(Font.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color.textBlack)
                            }
                        }
                        
                    }
                }
            }
        }
        .padding()
    }
}
