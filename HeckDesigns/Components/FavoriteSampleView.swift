//
//  FavoriteSampleView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/16.
//

import SwiftUI

struct FavoriteSampleView: View {
    var groupType: GroupType = .heck
    @State var scrollList = ListModel.shared.heckList
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
                    ForEach($scrollList, id: \.self) { $item in
                        if item.isFavorite {
                            NavigationLink {
                                ListItemView(item: $item)
                            } label: {
                                VStack(alignment: .leading) {
                                    Image(uiImage: item.image ?? UIImage(named: "addItemDefault")!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .cornerRadius(10)
                                    Text(item.title)
                                        .font(Font.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color.textBlack)
                                }
                            }
                        }
                    }
                    
                }
                
                
            }
            
        }
        .onAppear {
            switch groupType {
            case .heck:
                scrollList = ListModel.shared.heckList
            case .nice:
                scrollList = ListModel.shared.niceList
            case .issue:
                scrollList = ListModel.shared.issueList
            }
        }
        .padding()
    }
}

struct FavoriteSampleView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteSampleView()
    }
}

