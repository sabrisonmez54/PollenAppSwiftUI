//
//  PollenAppSwiftUIApp.swift
//  PollenAppSwiftUI
//
//  Created by Sabri Sönmez on 2/14/21.
//

import SwiftUI

@main
struct PollenAppSwiftUIApp: App {
    let persistanceContainer = PersistenceController.shared
  
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    ContentView()
                        .environment(\.managedObjectContext, persistanceContainer.container.viewContext)
                }
                .tabItem {
                    Image(systemName: "homekit")
                    Text("Home")
                }

                NavigationView {
                    FilterView()
                        .environment(\.managedObjectContext, persistanceContainer.container.viewContext)
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }

                NavigationView {
                    PollenInfoView()
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Pollen Types")
                }
            }
        }
    }
  
}
