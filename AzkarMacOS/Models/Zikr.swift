//
//  Zikr.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Thu 17 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

struct Zikr : Codable, Identifiable
{
    let id: Int
    let sectionId: Int
    let subSectionId: Int
    let count: Int
    let data: String
}

extension Zikr : Equatable
{
    static func == (lhs: Self, rhs: Self) -> Bool
    {
        lhs.id == rhs.id &&
            lhs.subSectionId == rhs.subSectionId &&
            lhs.sectionId == rhs.sectionId
    }
}
