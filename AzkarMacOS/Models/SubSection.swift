//
//  SubSection.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Thu 17 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import CoreData

struct SubSection : Codable, Identifiable
{
    let id: Int
    let sectionId: Int
    let title: String
}

extension SubSection : Equatable
{
    static func == (lhs: Self, rhs: Self) -> Bool
    {
        lhs.id == rhs.id && lhs.sectionId == rhs.sectionId
    }
}

extension SubSection
{
    static func == (lhs: Self, rhs: Favorite) -> Bool
    {
        lhs.id == rhs.id && lhs.sectionId == rhs.sectionID
    }
    
    static func == (lhs: Favorite, rhs: Self) -> Bool
    {
        lhs.id == rhs.id && lhs.sectionID == rhs.sectionId
    }
}

extension SubSection
{
    @discardableResult
    func favorite(with context: NSManagedObjectContext) -> Favorite
    {
        let fav = Favorite(context: context)
        fav.id = Int32(id)
        fav.title = title
        fav.sectionID = Int32(sectionId)
        return fav
    }
}
