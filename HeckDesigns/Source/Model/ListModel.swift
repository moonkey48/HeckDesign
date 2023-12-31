//
//  Model.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/08.
//

import SwiftUI

class ListModel: ObservableObject {
    static let shared = ListModel()
    private init(){}
    
    @Published var heckList = dummyHeckList
    @Published var niceList = dummyHeckList
    @Published var issueList = dummyIssueList
}

