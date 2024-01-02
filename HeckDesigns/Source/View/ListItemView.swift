//
//  HeckDetailView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/08.
//

import CoreData
import SwiftUI

struct ListItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var listItemViewModel = ListItemViewModel()
    @FocusState private var focusField: Field?
    
    var item: CoreListItem
    private let imageFileManager = ImageFileManager.shared
    
    private enum Field: Hashable {
        case title, description
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                if listItemViewModel.isEdit {
                    Image(uiImage: imageFileManager.getSavedImage(named: item.imageName ?? "")
                             ?? UIImage(named:"heck0")!)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .detailViewImage()
                        .onTapGesture {
                            listItemViewModel.isSelectingImage = true
                        }
                } else {
                    Image(uiImage: imageFileManager.getSavedImage(named: item.imageName ?? "addItemDefault")
                            ?? UIImage(named: "addItemDefault")!)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .detailViewImage()
                }
            }
            
            VStack(alignment: .leading) {
                if listItemViewModel.isEdit {
                    TextField("제목", text: $listItemViewModel.title, axis: .vertical)
                        .title()
                        .padding(.bottom, 9)
                        .focused($focusField, equals: .title)
                        .submitLabel(.next)
                        
                } else {
                    Text(item.title ?? "")
                        .title()
                }
                
                Divider()
                HStack {
                    Button {
                        listItemViewModel.toggleIsFavorite(item: item)
                    } label: {
                        if item.isFavorite == true {
                            Image(systemName: "star.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star")
                                .font(.system(size: 20))
                                .foregroundColor(Color.textBlack)
                        }
                    }

                    Spacer()
                }
                .frame(height: 25)
                Spacer()
                    .frame(height: 20)
                ScrollView {
                    VStack {
                        if listItemViewModel.isEdit == true {
                            TextField("설명", text: $listItemViewModel.description, axis: .vertical)
                                .description()
                                .focused($focusField, equals: .description)
                        } else {
                            Text(item.designDescription ?? "")
                                .description()
                        }
                    }
                }
                if listItemViewModel.isEdit {
                    Button {
                        listItemViewModel.isDelete = true
                    } label: {
                        Text("delete")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.bgGrayLight)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(item.groupType ?? "")
        .navigationBarBackButtonHidden(listItemViewModel.isEdit ? true : false)
        .alert("정말로 삭제하시겠어요?", isPresented: $listItemViewModel.isDelete) {
            Button("취소", role: .cancel) {
                listItemViewModel.isDelete = false
            }
            Button("삭제", role: .destructive) {
                listItemViewModel.deleteItem(item: item, imageName: item.imageName ?? "")
                presentationMode.wrappedValue.dismiss()
            }
        }
        .toolbar {
            if listItemViewModel.isEdit {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        listItemViewModel.isEdit = false
                    } label: {
                        Text("Cancel")
                            .navButton()
                            .foregroundColor(Color.red)
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if listItemViewModel.isEdit {
                        listItemViewModel.isEdit = false
                    } else {
                        listItemViewModel.isEdit = true
                        listItemViewModel.title = item.title ?? ""
                        listItemViewModel.description = item.designDescription ?? ""
                        listItemViewModel.image = UIImage(named: item.imageName ?? "heck1") ?? UIImage(named: "addItemDefault")!
                    }
                } label: {
                    Text(listItemViewModel.isEdit ? "Done" : "Edit")
                        .navButton()
                        .fontWeight(.semibold)
                }
            }
        }
    }
}
