//
//  AzkarMacOSApp.swift
//  AzkarMacOS
//
//  Created by Mohamed Shemy on Tue 16 Mar 2021.
//

import SwiftUI
import CoreData

@main
struct AzkarApp : App
{
    @ObservedObject private var azkarStore = AzkarStore()
    @ObservedObject private var favoritesStore = FavoritesStore()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene
    {
        WindowGroup
        {
            AzkarSectionView()
                .environment(\.layoutDirection, .rightToLeft)
                .environment(\.locale, Locale(identifier: "ar"))
                .environment(\.managedObjectContext, favoritesStore.context)
                .environmentObject(azkarStore)
                .environmentObject(favoritesStore)
        }
        .onChange(of: scenePhase, perform: handelScenePhase)
    }
    
    private func handelScenePhase(_ phase:  ScenePhase)
    {
        switch phase
        {
            case .background: PersistenceController.favorites.save()
            default: break
        }
    }
}
