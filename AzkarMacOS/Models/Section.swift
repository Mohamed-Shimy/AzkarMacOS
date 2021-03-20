//
//  SectionModel.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Thu 17 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

struct Section : Codable, Identifiable
{
    let id: Int
    let title: String
}

extension Section : Equatable
{
    static func == (lhs: Self, rhs: Self) -> Bool
    {
        lhs.id == rhs.id
    }
}
