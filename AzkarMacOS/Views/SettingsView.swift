//
//  SettingsView.swift
//  AzkarStore
//
//  Created by Mohamed Shemy on Thu 11 Mar 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct SettingsView : View
{
    @AppStorage("morningAzkar") var morningAzkar: Bool = false
    @AppStorage("eveningAzkar") var eveningAzkar: Bool = false
    
    var body: some View
    {
        VStack
        {
            NavigationTitle(title: "الإعدادات").padding(.horizontal)
            
            Form
            {
                SwiftUI.Section(header: sectionHeader("التنبيهات"))
                {
                    Toggle("أذكار الصباح", isOn: $morningAzkar)
                    Toggle("أذكار المساء", isOn: $eveningAzkar)
                }
                
                settingsItem("عن التطبيق", image: Image(systemName: "info.circle.fill"), destination: Text("About"))
            }
            .font(.headline)
        }
        .navigationTitle("")
        .islamicBackground()
    }
    
    private func sectionHeader(_ title: String) -> some View
    {
        Text(title)
            .foregroundColor(.primary)
            .font(.title)
    }
    
    private func settingsItem<Destination: View>(_ title: LocalizedStringKey, image: Image,
                                                 destination: Destination) -> some View
    {
        NavigationLink(destination: destination)
        { let size: CGFloat = 64
            HStack
            {
                image.renderingMode(.template)
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                
                Text(title)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 2)
        }
    }
}

struct SettingsView_Previews: PreviewProvider
{
    static var previews: some View
    {
        SettingsView()
    }
}
