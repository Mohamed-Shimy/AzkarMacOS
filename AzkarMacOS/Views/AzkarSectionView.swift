//
//  AzkarSectionView.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Thu 17 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct AzkarSectionView : View
{
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                SectionsToolsBar().padding(.top)
                SectionsGrid()
            }
            .frame(minWidth: 220)
            .padding([.horizontal])
            .islamicBackground()
            
            DefaultView()
        }
    }
}

struct AzkarSectionView_Previews : PreviewProvider
{
    @ObservedObject private static var store = AzkarStore()
    
    static var previews: some View
    {
        NavigationView
        {
            AzkarSectionView()
        }
        .colorScheme(.dark)
        .environment(\.layoutDirection, .rightToLeft)
        .environment(\.locale, Locale(identifier: "ar"))
        .environmentObject(store)
    }
}

struct AzkarSectionCell : View
{
    let section: Section
    
    var body: some View
    {
        let size: CGFloat = 128
        NavigationLink(destination: AzkarSubSectionsView(section: section))
        {
            Text(section.title)
                .padding(10)
                .font(.title)
                .foregroundColor(.background)
                .shadow(radius: 5)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.7)
                .frame(width: size, height: size)
        }
        .linearGradientBackground()
        .cornerRadius(15)
        .cellBackgroundStyle(RoundedRectangle(cornerRadius: 15))
        .padding([.leading, .trailing], 20)
        .buttonStyle(PlainButtonStyle())
    }
}

struct SectionsGrid: View
{
    @EnvironmentObject var store: AzkarStore
    
    var body: some View
    {
        ScrollView(.vertical, showsIndicators: false)
        {
            let size: CGFloat = 200
            LazyVGrid(columns: [GridItem(.adaptive(minimum: size))], spacing: 20)
            {
                ForEach(store.getSections(), content: AzkarSectionCell.init)
            }
            .padding(10)
        }
    }
}

struct SectionsToolsBar : View
{
    @State private var isAboutSheetPresented: Bool = false
    
    var body: some View
    {
        HStack
        {
            NavigationLink(destination: FavoriteView())
            {
                Image(systemName: "suit.heart.fill")
                    .shadow(color: .background, radius: 2, x: 0, y: 0)
            }
            
            Spacer()
            
            Button(action: presentAboutView)
            {
                Image(systemName: "info.circle.fill")
                    .shadow(color: .background, radius: 2, x: 0, y: 0)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .font(.title)
        .foregroundColor(.green)
        .sheet(isPresented: $isAboutSheetPresented, content: { AboutView() })
    }
    
    private func presentAboutView()
    {
        withAnimation
        {
            isAboutSheetPresented.toggle()
        }
    }
}

extension View
{
    func islamicBackground() -> some View
    {
        self.background(Image("Backrgound").resizable()
                            .aspectRatio(contentMode: .fill).opacity(0.3)
                            .ignoresSafeArea())
    }
    
    func linearGradientBackground(_ colors: [Color] = [Color(#colorLiteral(red: 0.8784313725, green: 0.8, blue: 0.4862745098, alpha: 1)), .green],
                                  startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottom,
                                  opacity: Double = 0.6) -> some View
    {
        self.background(LinearGradient(gradient: Gradient(colors: colors),
                                       startPoint: .top, endPoint: .bottom)
                            .opacity(opacity))
    }
    
    func cellBackgroundStyle<S: Shape>(_ shape: S) -> some View
    {
        self
            .overlay(shape.stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8784313725, green: 0.8, blue: 0.4862745098, alpha: 1)), .green]), startPoint: .top, endPoint: .bottom), lineWidth: 0.5))
            .shadow(color: Color.black.opacity(0.7), radius: 5, x: 0, y: 5)
    }
}
