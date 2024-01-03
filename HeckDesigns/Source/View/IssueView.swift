//
//  IssueView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct IssueView: View {
    @State private var showAddModal = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("준비중...")
            }
            .navigationTitle("Issue")
        }
    }
}

struct IssueView_Previews: PreviewProvider {
    static var previews: some View {
        IssueView()
    }
}
