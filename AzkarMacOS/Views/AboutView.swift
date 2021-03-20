//
//  AboutView.swift
//  AzkarIOS
//
//  Created by Mohamed Shemy on Mon 15 Mar 2021.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct AboutView : View
{
    var body: some View
    {
        VStack
        {
            HStack
            {
                BackButton()
                Spacer()
            }
            
            VStack
            {
                Image("Logo").resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text("About")
                    
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
        .islamicBackground()
    }
}

struct AboutView_Previews : PreviewProvider
{
    static var previews: some View
    {
        AboutView()
    }
}
