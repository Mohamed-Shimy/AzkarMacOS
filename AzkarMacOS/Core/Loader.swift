//
//  Loader.swift
//  AzkarStore
//
//  Created by Mohamed Shemy on Mon 4 Jan 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

protocol FileNameable
{
    var name: String { get }
}

enum AzkarFile : FileNameable
{
    case sections
    case subSections
    case content(_ sectionID: Int)
    
    var name: String
    {
        switch self
        {
            case .sections: return "Sections"
            case .subSections: return "SubSections"
            case .content(let sectionID): return "\(sectionID)"
        }
    }
}

func loadJSON<T: Decodable>(file: AzkarFile) -> T
{
    return load(name: file.name, withExtension: "json")
}

func loadJSON<T: Decodable>(file: FileNameable) -> T
{
    return load(name: file.name, withExtension: "json")
}

func load<T: Decodable>(name: String, withExtension: String? = nil) -> T
{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: name, withExtension: withExtension) else {
        fatalError("Couldn't find \(name) in main bundle.")
    }
    
    do
    {
        data = try Data(contentsOf: file)
    }
    catch
    {
        fatalError("Couldn't load \(name) from main bundle:\n\(error)")
    }
    
    do
    {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    catch
    {
        fatalError("Couldn't parse \(name) as \(T.self):\n\(error)")
    }
}
