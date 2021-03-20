//
//  SubSectionsView.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Fri 18 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct AzkarSubSectionsView : View
{
    @EnvironmentObject var store: AzkarStore
    let section: Section
    
    var body: some View
    {
        NavigationView
        {
            VStack(spacing: 0)
            {
                Text(section.title).padding(.top)
                    .font(.largeTitle)
                
                ScrollView(.vertical)
                {
                    LazyVStack(spacing: 10)
                    {
                        ForEach(store[section], content: AzkarSubSectionCell.init)
                    }
                    .padding()
                }
            }
            .frame(minWidth: 300)
            .islamicBackground()
            
            DefaultView()
        }
    }
}

struct AzkarSubSectionsView_Previews : PreviewProvider
{
    @ObservedObject private static var store = AzkarStore()
    
    static var previews: some View
    {
        AzkarSubSectionsView(section: store[6])
            .environment(\.layoutDirection, .rightToLeft)
            .environment(\.locale, Locale(identifier: "ar"))
            .environmentObject(store)
    }
}

struct AzkarSubSectionCell : View
{
    let subSection: SubSection
    @State private var isPresented = false
    
    var body: some View
    {
        NavigationLink(destination: AzkarContentView(subSection: subSection))
        {
            Text(subSection.title)
                .padding(10)
                .font(.title)
                .minimumScaleFactor(0.5)
                .foregroundColor(.background)
                .lineLimit(1)
        }
        .buttonStyle(AzkarSubButtonStyle())
    }
}

struct AzkarSubButtonStyle : ButtonStyle
{
    func makeBody(configuration: Configuration) -> some View
    {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 48)
            .linearGradientBackground()
            .clipShape(Capsule())
            .cellBackgroundStyle(Capsule())
            .padding([.leading, .trailing], 10)
    }
}
