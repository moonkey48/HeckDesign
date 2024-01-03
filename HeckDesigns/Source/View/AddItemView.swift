//
//  AddItemView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/12.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addItemViewModel = AddItemViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: addItemViewModel.selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .onTapGesture {
                        addItemViewModel.isSelecting = true
                    }
                
                HStack {
                    Text("분류")
                        .font(.custom("Apple SD Gothic Neo", size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color.textBlack)
                        .lineSpacing(6)
                    Spacer()
                        .frame(width: 10)
                    Picker("category", selection: $addItemViewModel.selectedType) {
                        ForEach(GroupType.allCases, id: \.self) { type in
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
                    TextField("제목", text: $addItemViewModel.title)
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
                    TextField("설명", text: $addItemViewModel.description)
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
                addItemViewModel.addNewItem()
                presentationMode.wrappedValue.dismiss()
            }))
            .navigationBarTitle("새로운 아이템", displayMode: .inline)
            .sheet(isPresented: $addItemViewModel.isSelecting) {
                ImagePicker(selectedImage: $addItemViewModel.selectedImage)
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
