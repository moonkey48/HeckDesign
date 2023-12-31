//
//  HeckDetailView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/08.
//

import SwiftUI

struct ListItemView: View {
    private let fileManager = ImageFileManager.shared
    private let listModel = ListModel.shared
    private let dbHelper = DBHelper.shared
    @Environment(\.presentationMode) var presentationMode
    
    private enum Field: Hashable {
        case title, description
    }
    @Binding var item: ListItem
    @State var isEdit = false
    @State var isDelete = false
    @State var isSelectingImage = false
    @State var image = UIImage(named: "addItemDefault")!
    @State var title = ""
    @State var description = ""
    @State var isFavorite = false
    
    @FocusState private var focusField: Field?
    
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                if isEdit {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .detailViewImage()
                        .onTapGesture {
                            isSelectingImage = true
                        }
                    
                } else {
                
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .detailViewImage()
                }
            }
            
            
            VStack(alignment: .leading) {
                if isEdit {
                    TextField("제목", text: $title, axis: .vertical)
                        .title()
                        .padding(.bottom, 9)
                        .focused($focusField, equals: .title)
                        .submitLabel(.next)
                        
                } else {
                    Text(title)
                        .title()
                }
                
                Divider()
                HStack {
                    Button {
                        toggleIsFavorite()
                    } label: {
                        if isFavorite == true {
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
                        if isEdit == true {
                            TextField("설명", text: $description, axis: .vertical)
                                .description()
                                .focused($focusField, equals: .description)
                        } else {
                            Text(description)
                                .description()
                        }
                    }
                }
                if isEdit {
                    Button {
                        self.isDelete = true
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
        .navigationTitle(item.group.rawValue)
        .navigationBarBackButtonHidden(isEdit ? true : false)
        .alert("정말로 삭제하시겠어요?", isPresented: $isDelete) {
            Button("취소", role: .cancel) {
                self.isDelete = false
            }
            Button("삭제", role: .destructive) {
                deleteItem()
            }
        
        }
        .toolbar {
            if isEdit {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.title = item.title
                        self.description = item.description
                        self.image = item.image ?? UIImage(named: "addItemDefault")!
                        isEdit = false
                    } label: {
                        Text("Cancel")
                            .navButton()
                            .foregroundColor(Color.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        updateItem()
                    } label: {
                        Text("Done")
                            .navButton()
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.title = item.title
                        self.description = item.description
                        self.image = item.image ?? UIImage(named: "addItemDefault")!
                        self.isEdit = true
                    } label: {
                        Text("Edit")
                            .navButton()
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .onAppear {
        
            self.title = item.title
            self.description = item.description
            self.image = item.image ?? UIImage(named: "addItemDefault")!
            self.isFavorite = item.isFavorite
            focusField = .title
        }
        .sheet(isPresented: $isSelectingImage) {
            ImagePicker(selectedImage: $image)
        }
        
    }
}

private extension ListItemView {
    
    func toggleIsFavorite(){
        dbHelper.updateData(id: item.id, title: self.title, description: self.description, groupType: item.group, isFavorite: item.isFavorite == true ? false : true, imageName: "item\(item.uid)")
        item.isFavorite.toggle()
        isFavorite.toggle()
    }
    func deleteItem(){
        listModel.heckList = listModel.heckList.filter {
            $0.id != item.id
        }
        isEdit = false
        dbHelper.deleteData(id: item.id)
        fileManager.deleteImage(named: "item\(item.uid)") { _ in
        }
        
        presentationMode.wrappedValue.dismiss()

    }
    
    func updateItem(){
        item.title = self.title
        item.description = self.description
        item.image = self.image
        isEdit = false
        fileManager.deleteImage(named: "item\(item.uid)") { _ in
        }
        fileManager.saveImage(image: self.image, name: "item\(item.uid)", onSuccess: { _ in
        })
        dbHelper.updateData(id: item.id, title: self.title, description: self.description, groupType: item.group, isFavorite: item.isFavorite, imageName: "item\(item.uid)")
    }
}





struct ListItemView_Previews: PreviewProvider {
    private struct ListItemViewForPrev: View {
        @State var item = ListItem(
            title: "감성과 안전사이",
            image: UIImage(named: "heck0")!,
            description: "안전은 어디에 있는가, 감성적인 분위기를 위해 너무 눈에 띄지 않는 문구는 열받게 한다 정말",
            group: .heck,
            id: 0,
            uid: "14"
        )
        
        var body: some View {
                ListItemView(item: $item, image: UIImage(named: "addItemDefault")!)
        }
    }


    static var previews: some View {
        ListItemViewForPrev()
    }
}
