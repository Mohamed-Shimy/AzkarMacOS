//
//  AzkarStore.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Thu 17 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

final class AzkarStore : ObservableObject
{
    typealias Sections = [Section]
    typealias SubSections = [SubSection]
    typealias Azkar = [Zikr]
    typealias SubSectionContent = [Int: Azkar]
    
    private var sections: Sections!
    private var subSections: [Int: SubSections]!   // [sectionID: [SubSection]]
    private var content: [Int: SubSectionContent]! // [sectionID: [subSectionID: [Zikr]]]
    
    init()
    {
        loadSections()
    }
    
    func getSections() -> Sections
    {
        loadSections()
        return sections
    }
    
    func getSubSections(in section: Section) -> SubSections
    {
        getSubSections(by: section.id)
    }
    
    func getSubSections(by sectionID: Int) -> SubSections
    {
        loadSubSections()
        return subSections[sectionID] ?? []
    }
    
    func getContent(in subSection: SubSection) -> Azkar
    {
        loadContent(subSection.sectionId)
        let section = content[subSection.sectionId] ?? [:]
        return section[subSection.id]?.filter { $0.subSectionId == subSection.id } ?? []
    }
    
    func getSubSection(for fav: Favorite) -> SubSection
    {
        loadSubSections()
        let subSection = subSections[Int(fav.sectionID)]?.first(where: { $0.id == fav.id })
        return subSection!
    }
    
    
    // MARK: -
    
    private func loadSections()
    {
        if sections == nil
        {
            sections = loadJSON(file: .sections)
            content = sections.reduce(into: [:]) { (dic, section) in dic[section.id] = [:] }
        }
    }
    
    private func loadSubSections()
    {
        loadSections()
        if subSections == nil
        {
            subSections = loadJSON(file: .subSections)
        }
    }
    
    private func loadContent(_ sectionId: Int)
    {
        loadSubSections()
        if content[sectionId]?.isEmpty ?? true
        {
            let subSections: [Int: [Zikr]] = loadJSON(file: .content(sectionId))
            content[sectionId] = subSections
        }
    }
}

extension AzkarStore
{
    subscript(index: Int) -> Section
    {
        assert(index.inRange(of: sections), "Index out of range.")
        return sections[index]
    }
    
    subscript(section: Section) -> SubSections
    {
        getSubSections(in: section)
    }
    
    subscript(subSection: SubSection) -> Azkar
    {
        getContent(in: subSection)
    }
}
