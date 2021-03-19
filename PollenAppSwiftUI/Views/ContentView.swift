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
    @State var chartData: [Double] = [0, 5, 6, 2, 13, 4, 3, 6]
    @ObservedObject var networkManager = NetworkManager()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: PollenLincoln.entity(),sortDescriptors: [])
    private var pollenLincoln: FetchedResults<PollenLincoln>
    @FetchRequest(entity: PollenCalder.entity(), sortDescriptors: [])
    private var pollenCalder: FetchedResults<PollenCalder>

    
    
    var body: some View {
        //        ForEach((0...networkManager.sheetsData.pollenDatesLincoln.count - 1 ), id: \.self) {
        //            if(networkManager.sheetsData.pollenDatesLincoln[$0] != "-"){
        //                addData(date: networkManager.sheetsData.pollenDatesLincoln[$0], name: networkManager.sheetsData.pollenNamesLincoln[$0], count: networkManager.sheetsData.pollenCountLincoln[$0])
        //               }
        //            }
        VStack {
            if networkManager.loading {
                Text("Loading ...")
            } else {
                List {
                    Text(networkManager.sheetsData.titleLincoln)
                    ForEach((0 ..< 3)) { index in
                        if pollenLincoln[index].name != nil && pollenLincoln[index].date != nil && pollenLincoln[index].count != nil  {
                            ExcelDataRow(date: pollenLincoln[index].date!, pollenName: pollenLincoln[index].name!, pollenCount: pollenLincoln[index].count!)
                        }
                    }
                    Text(networkManager.sheetsData.titleCalder)
                    ForEach((0 ..< 3)) { index in
                        if pollenCalder[index].name != nil && pollenCalder[index].date != nil && pollenCalder[index].count != nil  {
                            ExcelDataRow(date: pollenCalder[index].date!, pollenName: pollenCalder[index].name!, pollenCount: pollenCalder[index].count!)
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
                        addDataLincoln(date: dated!  , name: networkManager.sheetsData.pollenNamesLincoln[index], count: networkManager.sheetsData.pollenCountLincoln[index])
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
                        addDataCalder(date: dated!  , name: networkManager.sheetsData.pollenNamesCalder[index], count: networkManager.sheetsData.pollenCountCalder[index])
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
    
    private func addDataLincoln(date:Date, name: String, count:String) {
        let newData = PollenLincoln(context: viewContext)
        newData.date = date
        newData.name = name
        newData.count = count
        saveContext()
    }
    private func addDataCalder(date:Date, name: String, count:String) {
        let newData = PollenCalder(context: viewContext)
        newData.date = date
        newData.name = name
        newData.count = count
        saveContext()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
