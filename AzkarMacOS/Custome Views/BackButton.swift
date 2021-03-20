//
//  BackButton.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Thu 31 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct BackButton : View
{
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View
    {
        Button(action: dismiss)
        {
            Image(systemName: "multiply.circle.fill")
                .flipsForRightToLeftLayoutDirection(true)
                .font(.largeTitle)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func dismiss()
    {
        presentationMode.wrappedValue.dismiss()
    }
}

struct BackButton_Previews : PreviewProvider
{
    static var previews: some View
    {
        BackButton()
    }
}
