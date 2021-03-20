//
//  Color.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Thu 10 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

extension Color
{
    init(red: Int, green: Int, blue: Int, opacity: Double = 1)
    {
        assert(0...255 ~= red, "Invalid red component")
        assert(0...255 ~= green, "Invalid green component")
        assert(0...255 ~= blue, "Invalid blue component")
        
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0, opacity: opacity)
    }
    
    init(hexa: Int)
    {
        self.init(
            red: (hexa >> 16) & 0xFF,
            green: (hexa >> 8) & 0xFF,
            blue: hexa & 0xFF
        )
    }
}

extension Color
{
    static var background: Self
    {
        Color("Background")
    }
    
    static var foreground: Self
    {
        Color("Foreground")
    }
    
    static var random: Self
    {
        .init(red: .random(in: 0.0...1.0),
              green: .random(in: 0.0...1.0),
              blue: .random(in: 0.0...1.0))
    }
}
