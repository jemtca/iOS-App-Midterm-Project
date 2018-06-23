//
//  ExpandableSections.swift
//  MidtermApp
//

import Foundation

struct ExpandableSections {
    var isExpanded: Bool
    var bussinessCards: [BussinessCard]
}

struct BussinessCard {
    let name: String
    var hasStart: Bool
}
