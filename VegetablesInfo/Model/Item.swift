//
//  Item.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/11.
//

import SwiftUI

struct Item: Identifiable {
    var id : Int
    var image : String
    var description: String
    var nutrition: [String]
    var gradientColors: [Color]
}
