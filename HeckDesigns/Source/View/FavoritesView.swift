//
//  FavoritesView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/16.
//

import SwiftUI

struct FavoritesView: View {
    var groupType: GroupType
    private let columns = [ GridItem(.adaptive(minimum: 170)) ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
//                ForEach($gridList, id: \.self) { $item in
//                    if item.isFavorite {
//                        NavigationLink {
//                            ListItemView(item: $item)
//                        } label: {
//                            VStack(alignment: .leading) {
//                                Image(uiImage: item.image ?? UIImage(named: "addItemDefault")!)
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: 170, height: 170)
//                                    .cornerRadius(10)
//                                Text(item.title)
//                                    .font(Font.system(size: 18, weight: .semibold))
//                                    .foregroundColor(Color.textBlack)
//                            }
//                        }
//                    }
//                }
            }
        }
        .onAppear {
//            switch groupType {
//            case .heck:
//                gridList = ListModel.shared.heckList
//            case .nice:
//                gridList = ListModel.shared.niceList
//            case .issue:
//                gridList = ListModel.shared.issueList
//            }
        }
        .navigationTitle("Favorites")
    }
}
