//
//  NavigationTitle.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Wed 20 Jan 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct NavigationTitle : View
{
    var title: String
    var trailingImage: Image? = nil
    var acrion: () -> () = {}
    
    var body: some View
    {
        HStack
        {            
            Spacer()
            Text(title)
                .font(.largeTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Spacer()
            
            if let image = trailingImage
            {
                Button(action: acrion)
                {
                    image
                }
            }
        }
        .frame(height: 64)
        .font(.title)
        .foregroundColor(.background)
        .buttonStyle(PlainButtonStyle())
    }
}

struct NavigationTitle_Previews : PreviewProvider
{
    static var previews: some View
    {
        NavigationTitle(title: "Azkar", trailingImage: Image(systemName: "suit.heart.fill"))
            .previewLayout(.sizeThatFits)
            .environment(\.locale, Locale(identifier: "ar"))
    }
}
