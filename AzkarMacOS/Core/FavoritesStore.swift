//
//  FavoritesStore.swift
//  AzkarStore
//
//  Created by Mohamed Shemy on Mon 1 Mar 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import CoreData
import Combine

final class FavoritesStore : ObservableObject
{
    typealias Favorites = [Favorite]
    
    // MARK: Properties
    
    @Published var favorites: Favorites = []
    let persistenceController = PersistenceController.favorites
    var context: NSManagedObjectContext { persistenceController.container.viewContext }
    
    // MARK: init
    
    init()
    {
        fetchData()
    }
    
    // MARK: Public Methods
    
    // MARK: Actions
    
    @discardableResult
    func add(_ subSection: SubSection) -> Bool
    {
        let fav = subSection.favorite(with: context)
        context.insert(fav)
        return saveAndFetch()
    }
    
    @discardableResult
    func delete(_ subSection: SubSection) -> Bool
    {
        if let fav = favorites.first(where: { $0 == subSection })
        {
            return delete(fav)
        }
        
        return false        
    }
    
    @discardableResult
    func delete(at index: Int) -> Bool
    {
        guard index.inRange(open: 0, favorites.count) else { return false }
        let fav = favorites[index]
        return delete(fav)
    }
    
    @discardableResult
    func delete(_ fav: Favorite) -> Bool
    {
        context.delete(fav)
        return saveAndFetch()
    }
    
    func delete(offsets: IndexSet)
    {
        offsets.map { favorites[$0] }.forEach(context.delete)
        saveAndFetch()
    }
    
    // MARK: Check
    
    func isFavorite(_ id: Int) -> Bool
    {
        favorites.first(where: { $0.id == id }) != nil
    }
    
    func isFavorite(_ subSection: SubSection) -> Bool
    {
        isFavorite(subSection.id)
    }
    
    // MARK: Private Methods
    
    private func fetchData()
    {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do
        {
            favorites = try context.fetch(fetchRequest)
        }
        catch
        {
            favorites = []
        }
    }
    
    @discardableResult
    private func saveAndFetch() -> Bool
    {
        let isSaved = persistenceController.save()
        fetchData()
        return isSaved
    }
    
    private func clearData()
    {
        for i in 0..<favorites.count
        {
            delete(at: i)
        }
    }
}
