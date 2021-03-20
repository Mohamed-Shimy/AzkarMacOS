//
//  Int.swift
//  AzkarStore
//
//  Created by Mohamed Shemy on Thu 4 Mar 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import Foundation

extension Int
{
    func inRange<T>(of arr: Array<T>) -> Bool
    {
        inRange(open: 0, arr.count)
    }
    
    func inRange(close s: Int, _ e: Int) -> Bool
    {
        s...e ~= self
    }
    
    func inRange(open s: Int, _ e: Int) -> Bool
    {
        s..<e ~= self
    }
}
