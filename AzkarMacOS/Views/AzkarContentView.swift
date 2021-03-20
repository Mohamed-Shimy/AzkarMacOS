//
//  AzkarContentView.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Fri 18 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct AzkarContentView : View
{
    @EnvironmentObject var favoritesStore: FavoritesStore
    @EnvironmentObject var store: AzkarStore
    let subSection: SubSection
    
    @State private var favImage: String = "heart"
    private var isFavorite: Bool { favoritesStore.isFavorite(subSection.id)  }
    
    var body: some View
    {
        VStack(spacing: 5)
        {
            NavigationTitle(title: subSection.title,
                            trailingImage: Image(systemName: favImage),
                            acrion: toggleFavorites)
                .padding(.horizontal)
            
            ScrollView(.vertical)
            {
                LazyVStack(spacing: 25)
                {
                    ForEach(store[subSection], content: AzkarContentCell.init)
                }
                .padding(.horizontal)
            }
        }
        .islamicBackground()
        .onAppear() { favImage = isFavorite ? "heart.fill" : "heart"}
    }
    
    private func toggleFavorites()
    {
        withAnimation
        {
            if isFavorite
            {
                deleteFromFavorites()
            }
            else
            {
                addToFavorites()
            }
        }
    }
    
    private func deleteFromFavorites()
    {
        if favoritesStore.delete(subSection)
        {
            favImage = "heart"
        }
    }
    
    private func addToFavorites()
    {
        if favoritesStore.add(subSection)
        {
            favImage = "heart.fill"
        }
    }
}

struct AzkarContentView_Previews : PreviewProvider
{
    @ObservedObject private static var store = AzkarStore()
    @ObservedObject private static var favoritesStore = FavoritesStore()
    
    static var previews: some View
    {
        let section = store[0]
        AzkarContentView(subSection: store[section][4])
            .environment(\.layoutDirection, .rightToLeft)
            .environment(\.locale, Locale(identifier: "ar"))
            .environmentObject(store)
            .environmentObject(favoritesStore)
    }
}

struct AzkarContentCell : View
{
    let content: Zikr
    @State private var count: Int = 0
    
    var body: some View
    {
        HStack(alignment: .top, spacing: 5)
        {
            let isFinish = count == content.count && content.count > 0
            if content.count > 0
            {
                Controlls(totalCount: content.count, count: $count)
                    .padding(.leading, 5)
            }
            
            Text(content.data)
                .frame(maxHeight: .infinity)
                .padding(15)
                .font(.title)
                .foregroundColor(.background)
                .multilineTextAlignment(.leading)
                .lineSpacing(10)
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient:
                                            Gradient(colors: [isFinish ? .red : .green, Color(#colorLiteral(red: 0.8784313725, green: 0.8, blue: 0.4862745098, alpha: 1))]),
                                           startPoint: .topTrailing,
                                           endPoint: .bottomLeading).opacity(0.7))
                .cornerRadius(10)
                .padding([.leading, .trailing], 10)
                .onTapGesture { increaseCount() }
        }
    }
    
    private func increaseCount()
    {
        if count == content.count { return }
        
        withAnimation
        {
            count += 1
        }
    }
}

extension AzkarContentCell
{
    struct Controlls : View
    {
        let totalCount: Int
        @Binding var count: Int
        
        private let size: CGFloat = 32
        private var isFinish: Bool { count == totalCount }
        
        var body: some View
        {
            VStack(spacing: 10)
            {
                Button(action: increaseCount)
                {
                    Text("\(count)")
                        .azkarContentControlsStyle(size: size,
                                                   backgroundColor: isFinish ? Color.red : Color.background)
                }
                
                Text("\(totalCount)")
                    .azkarContentControlsStyle(size: size, backgroundColor: .green)
                
                Button(action: resetCount)
                {
                    Image(systemName: "repeat")
                        .azkarContentControlsStyle(size: size)
                }
            }
            .padding(.vertical, 10)
            .font(.title2)
            .frame(width: size)
            .shadow(color: .background, radius: 2, x: 0, y: 0)
            .buttonStyle(PlainButtonStyle())
        }
        
        private func increaseCount()
        {
            if count == totalCount { return }
            
            withAnimation
            {
                count += 1
            }
        }
        
        private func resetCount()
        {
            if count == 0 { return }
            
            withAnimation
            {
                count = 0
            }
        }
    }
}

extension View
{
    func azkarContentControlsStyle(size: CGFloat,
                                   backgroundColor: Color = .background,
                                   forgroundColor: Color = .foreground) -> some View
    {
        self
            .frame(width: size, height: size)
            .foregroundColor(forgroundColor)
            .background(backgroundColor)
            .clipShape(Circle())
    }
}
