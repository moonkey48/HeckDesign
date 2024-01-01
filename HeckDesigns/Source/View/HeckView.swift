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
    @FetchRequest(entity: CoreListItem.entity(), sortDescriptors: []) var itemList: FetchedResults<CoreListItem>
    
    private let columns = [GridItem(.adaptive(minimum: 170))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
//                FavoriteSampleView(groupType: .heck)
                
                Button {
                    let heckModel = HeckDesignModel()
                    heckModel.createItem(title: "hello", desciption: "world", groupType: .heck, imageName: "heck0") { res in
                        switch res {
                        case .success(let isSuccess):
                            print("success \(isSuccess)")
                        case .failure(let fail):
                            print(fail)
                        }
                    }
                } label: {
                    Text("create item")
                }
                
                Button {
                    readList()
                } label: {
                    Text("read data")
                }
                
                ForEach(itemList, id: \.uid) { item in
                    Text(item.title ?? "")
                }

                LazyVGrid(columns: columns) {
//                    ForEach(coreListItem, id: \.self) { item in
//                        NavigationLink {
//                            ListItemView(item: item)
//                        } label: {
//                            VStack(alignment: .leading) {
//                                ZStack {
//                                    Image(uiImage: item.image ?? UIImage(named: "addItemDefault")!)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 170, height: 170)
//                                        .cornerRadius(10)
//                                    if item.isFavorite == true {
//                                        VStack {
//                                            Spacer()
//                                                .frame(height: 140)
//                                            HStack {
//                                                Spacer()
//                                                    .frame(width: 140)
//                                                Image(systemName: "star.fill")
//                                                    .foregroundColor(Color.white)
//                                                    .opacity(0.9)
//                                            }
//                                        }
//                                    }
//                                }
//                                Text(item.title)
//                                    .font(Font.system(size: 18, weight: .semibold))
//                                    .foregroundColor(Color.textBlack)
//                            }
//                        }
//                    }
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
    
    private func readList() {
        let request = CoreListItem.fetchRequest()
        do {
            let heckList = try PersistenceController.shared.container.viewContext.fetch(request)
            print(heckList)
        } catch {
            print("fail to read heck data")
        }
    }
}


struct HeckView_Previews: PreviewProvider {
    static var previews: some View {
        HeckView()
    }
}
