//
//  ContentView.swift
//  PollenAppSwiftUI
//
//  Created by Sabri Sönmez on 2/14/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var didAppear = false
    @State var appearCount = 0
    @ObservedObject var networkManager = NetworkManager()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: PollenLincoln.entity(),sortDescriptors: [])
    private var pollenLincoln: FetchedResults<PollenLincoln>
    @FetchRequest(entity: PollenCalder.entity(), sortDescriptors: [])
    private var pollenCalder: FetchedResults<PollenCalder>

    
    
    var body: some View {
        VStack {
            if networkManager.loading {
                ProgressView("Loading Data…")
                    .progressViewStyle(CircularProgressViewStyle())
                    
            } else {
                ScrollView {
                    Text(networkManager.sheetsData.titleLincoln).font(.headline)
                    ForEach((0 ..< 1)) { index in
                        if pollenLincoln[index].name != nil && pollenLincoln[index].date != nil {
                            PollenCardView(date: pollenLincoln[index].date!, pollenName: pollenLincoln[index].name!, pollenCount: pollenLincoln[index].count, image: "pollen-unsplash")
                        }
                    }
                    Text(networkManager.sheetsData.titleCalder).font(.headline)
                    ForEach((0 ..< 1)) { index in
                        if pollenCalder[index].name != nil && pollenCalder[index].date != nil {
                            PollenCardView(date: pollenCalder[index].date!, pollenName: pollenCalder[index].name!, pollenCount: pollenCalder[index].count, image: "oak-pollen")
                        }
                    }
                }
                
                    
                
            }
        }.navigationTitle("Home")
        .onAppear(perform: onLoad)
    }
    
    func onLoad() {
        if didAppear == false {
            appearCount += 1
            //This is where I loaded my coreData information into normal arrays
            networkManager.loadData(onCompletion: { (successful) in
                print(successful)
                for index in 0...networkManager.sheetsData.pollenDatesLincoln.count - 1{
                    if(networkManager.sheetsData.pollenDatesLincoln[index] != "-") {
                        let dateString = networkManager.sheetsData.pollenDatesLincoln[index]
                        // Create Date Formatter
                        let dateFormatter = DateFormatter()
                        // Set Date Format
                        dateFormatter.dateFormat = "MM/dd/yy"
                        // Convert String to Date
                        let dated = dateFormatter.date(from: dateString)
                        
                        let pollenCountString = networkManager.sheetsData.pollenCountLincoln[index]
                        var pollenCountDouble = 0.0
                        if pollenCountString.contains("pcm") {
                            let replaced = pollenCountString.replacingOccurrences(of: "pcm", with: "")
                            var trimmed = replaced
                            if !replaced.contains("."){
                                trimmed = replaced.trimmingCharacters(in: .whitespacesAndNewlines)
                                trimmed.append(".0")
                            }
                            pollenCountDouble += Double(trimmed) ?? 0.0
                            
                        }
                        
                        
                        addDataLincoln(date: dated!  , name: networkManager.sheetsData.pollenNamesLincoln[index], count: pollenCountDouble)
                    }
                }
                for index in 0...networkManager.sheetsData.pollenDatesCalder.count - 1{
                    if(networkManager.sheetsData.pollenDatesCalder[index] != "-") {
                        let dateString = networkManager.sheetsData.pollenDatesCalder[index]
                        // Create Date Formatter
                        let dateFormatter = DateFormatter()
                        // Set Date Format
                        dateFormatter.dateFormat = "MM/dd/yy"
                        // Convert String to Date
                        let dated = dateFormatter.date(from: dateString)
                        
                        let pollenCountString = networkManager.sheetsData.pollenCountCalder[index]
                        var pollenCountDouble = 0.0
                        if pollenCountString.contains("pcm") {
                            let replaced = pollenCountString.replacingOccurrences(of: "pcm", with: "")
                            var trimmed = replaced
                            if !replaced.contains("."){
                                trimmed = replaced.trimmingCharacters(in: .whitespacesAndNewlines)
                                trimmed.append(".0")
                            }
                            pollenCountDouble += Double(trimmed) ?? 0.0
                        }
                        
                        addDataCalder(date: dated!  , name: networkManager.sheetsData.pollenNamesCalder[index], count: pollenCountDouble)
                    }
                }
            }) { (error) in
                print(error.domain)
            }
        }
        didAppear = true
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    private func addDataLincoln(date:Date, name: String, count:Double) {
        withAnimation {
            let newData = PollenLincoln(context: viewContext)
            newData.date = date
            newData.name = name
            newData.count = count
            saveContext()
        }
       
    }
    private func addDataCalder(date:Date, name: String, count:Double) {
        withAnimation() {
            let newData = PollenCalder(context: viewContext)
            newData.date = date
            newData.name = name
            newData.count = count
            saveContext()
        }
       
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
