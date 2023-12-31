//
//  ListModelType.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 12/31/23.
//

import SwiftUI

enum GroupType: String, CaseIterable {
    case heck
    case nice
    case issue
    
    var groupName: String {
        self.rawValue.capitalized
    }
    func changeStringToGroupType(beChanged: String) -> GroupType {
        if beChanged == "heck" {
            return .heck
        } else if beChanged == "nice" {
            return .nice
        } else {
            return .issue
        }
    }
}

struct ListItem: Hashable {
    var title: String
    var image: UIImage? = UIImage(named: "addItemDefault")
    var description: String = ""
    var group: GroupType
    var isFavorite = false
    var id: Int
    var uid: String
}

enum Gender {
    case male
    case female
}

struct Person {
    var name: String
    var age: Int
    var gender: Gender
    init(name: String, age: Int, gender: Gender) {
        self.name = name
        self.age = age
        self.gender = gender
    }
}
