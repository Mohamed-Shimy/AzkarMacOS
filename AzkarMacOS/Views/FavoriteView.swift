//
//  FavoriteView.swift
//  AzkarStore
//
//  Created by Mohamed Shemy on Thu 4 Mar 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct FavoriteView : View
{
    @EnvironmentObject var store: FavoritesStore
    
    var body: some View
    {
        NavigationView
        {
            VStack(spacing: 10)
            {
                Text("المفضله").padding(.top, 10)
                    .font(.largeTitle)
                
                ScrollView(.vertical)
                {
                    LazyVStack(spacing: 15)
                    {
                        ForEach(store.favorites)
                        { fav in
                            
                            FavoriteCell(favorite: fav)
                                .contextMenu
                                {
                                    Button("حذف", action: { delete(fav) })
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .frame(minWidth: 300)
            .islamicBackground()
            
            DefaultView()
        }
    }
    
    private func delete(_ fav: Favorite)
    {
        withAnimation
        {
            store.delete(fav)
        }
    }
}

struct FavoriteView_Previews : PreviewProvider
{
    static var previews: some View
    {
        FavoriteView()
            .environmentObject(FavoritesStore())
            .environmentObject(AzkarStore())
    }
}

struct FavoriteCell : View
{
    let favorite: Favorite
    @EnvironmentObject var azkarStore: AzkarStore
    
    var body: some View
    {
        NavigationLink(destination: AzkarContentView(subSection: azkarStore.getSubSection(for: favorite)))
        {
            Text(favorite.title ?? "")
                .padding(10)
                .font(.title)
                .minimumScaleFactor(0.5)
                .foregroundColor(.background)
                .lineLimit(1)
        }
        .buttonStyle(AzkarSubButtonStyle())
    }
}
