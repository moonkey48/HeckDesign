//
//  AddItemView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/12.
//

import SwiftUI

struct AddItemView: View {
    private let fileManager = ImageFileManager.shared
    private let dbHelper = DBHelper.shared
    private var groupTypes: [GroupType] = [.heck, .nice, .issue]
    private let listModel = ListModel.shared
    
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""
    @State var selectedType: GroupType = .heck
    @State private var selectedImage = UIImage(named: "addItemDefault")!
    @State private var isSelecting = false
    @State private var isLoading = false
    @State private var newId = 0
    
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .onTapGesture {
                        isSelecting = true
                    }
                
                HStack {
                    Text("분류")
                        .font(.custom("Apple SD Gothic Neo", size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color.textBlack)
                        .lineSpacing(6)
                    Spacer()
                        .frame(width: 10)
                    Picker("category", selection: $selectedType) {
                        ForEach(groupTypes, id: \.self) { type in
                            Text("\(type.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
                
                
                Divider()
                HStack {
                    Text("제목")
                        .font(.custom("Apple SD Gothic Neo", size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color.textBlack)
                        .lineSpacing(6)
                    Spacer()
                        .frame(width: 20)
                    TextField("제목", text: $title)
                        .padding(10)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(5)
                }
                Divider()
                HStack {
                    Text("설명")
                        .font(.custom("Apple SD Gothic Neo", size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color.textBlack)
                        .lineSpacing(6)
                    Spacer()
                        .frame(width: 20)
                    TextField("설명", text: $description)
                        .padding(10)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(5)
                }
                Divider()
            }
            .padding()
            .navigationBarItems(leading:
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("취소")
                        .foregroundColor(.red)
                }
            )
            .navigationBarItems(trailing: Button("추가", action: {
                addNewItemToModel(
                    title: title,
                    image: selectedImage,
                    description: description,
                    group: selectedType,
                    id: newId)
                
                addNewItemToDB(
                    title: title,
                    image: selectedImage,
                    description: description,
                    group: selectedType,
                    id: newId)
                
                presentationMode.wrappedValue.dismiss()
            }))
            .navigationBarTitle("새로운 아이템", displayMode: .inline)
            .sheet(isPresented: $isSelecting) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .onAppear {
                newId = listModel.heckList.count + listModel.niceList.count + listModel.issueList.count + 1
            }
        }
    }
}

extension AddItemView {
    
    func addNewItemToModel(title: String,
                           image: UIImage,
                           description: String,
                           group: GroupType,
                           id: Int) {
        switch selectedType {
        case .heck:
            listModel.heckList.append(
                ListItem(
                    title: title,
                    image: selectedImage,
                    description: description,
                    group: .heck,
                    id: newId,
                    uid: String(newId)
                )
            )
        case .nice:
            listModel.issueList.append(
                ListItem(
                    title: title,
                    image: selectedImage,
                    description: description,
                    group: .heck,
                    id: newId,
                    uid: String(newId)
                )
            )
        case .issue:
            listModel.niceList.append(
                ListItem(
                    title: title,
                    image: selectedImage,
                    description: description,
                    group: .heck,
                    id: newId,
                    uid: String(newId)
                )
            )
        }
    }
    func addNewItemToDB(title: String,
                        image: UIImage,
                        description: String,
                        group: GroupType,
                        id: Int){
        fileManager.saveImage(image: self.selectedImage, name: "item\(newId)", onSuccess: { _ in
            isLoading = false
        })
        
        dbHelper.insertData(
            title: title,
            description: description,
            group: selectedType,
            imageName: "item\(newId)",
            uid: String(newId)
        )
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
