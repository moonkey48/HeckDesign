//
//  FavoriteSampleView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/16.
//

import SwiftUI

struct FavoriteSampleView: View {
    @FetchRequest(entity: CoreListItem.entity(), sortDescriptors: [], predicate: NSPredicate(format: "isFavorite == TRUE")) var itemList: FetchedResults<CoreListItem>
    
    var groupType: GroupType
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Favorite")
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
                    ForEach(itemList, id: \.self) { item in
                        NavigationLink {
                            ListItemView(item: item)
                        } label: {
                            VStack(alignment: .leading) {
                                Image(uiImage: UIImage(named: item.imageName ?? "addItemDefault") ?? UIImage(named: "addItemDefault")!)
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
