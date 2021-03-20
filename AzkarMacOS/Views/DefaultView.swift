//
//  DefaultView.swift
//  AzkarStore
//
//  Created by Mohamed Shemy on Thu 11 Mar 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct DefaultView : View
{
    var body: some View
    {
        VStack
        {
            Image("Logo").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 128, height: 128)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .islamicBackground()
    }
}

struct DefaultView_Previews : PreviewProvider
{
    static var previews: some View
    {
        DefaultView()
    }
}
