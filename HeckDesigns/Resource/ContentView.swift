//
//  ContentView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct ContentView: View {
    private let fileManager = ImageFileManager.shared
    private let dbHelper = DBHelper.shared
    private let listModel = ListModel.shared
    @State var selectedTab = 0
    
    
    var body: some View {
        TabView {
            HeckView()
                .tabItem {
                    Image(systemName: "exclamationmark.bubble.fill")
                    Text("Heck")
                }
            NiceView()
                .tabItem {
                    Image(systemName: "checkmark.bubble.fill")
                    Text("Nice")
                }
            IssueView()
                .tabItem {
                    Image(systemName: "questionmark.bubble.fill")
                    Text("Issue")
                }
        }
        .onAppear {
            dbHelper.createTable()
            let dbData = dbHelper.readData()
            dbData.forEach { data in
                switch data.groupType {
                case "heck":
                    listModel.heckList.append(
                        ListItem(
                            title: data.title,
                            image: fileManager.getSavedImage(named: "\(data.imageName)"),
                            description: data.description,
                            group: .heck,
                            isFavorite: data.isFavorite,
                            id: Int(data.id),
                            uid: data.uid
                        )
                    )
                case "nice":
                    listModel.niceList.append(
                        ListItem(
                            title: data.title,
                            image: fileManager.getSavedImage(named: "\(data.imageName)"),
                            description: data.description,
                            group: .nice,
                            isFavorite: data.isFavorite,
                            id: Int(data.id),
                            uid: data.uid
                        )
                    )
                case "issue":
                    listModel.issueList.append(
                        ListItem(
                            title: data.title,
                            image: fileManager.getSavedImage(named: "\(data.imageName)"),
                            description: data.description,
                            group: .issue,
                            isFavorite: data.isFavorite,
                            id: Int(data.id),
                            uid: data.uid
                        )
                    )
                default:
                    print("")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
