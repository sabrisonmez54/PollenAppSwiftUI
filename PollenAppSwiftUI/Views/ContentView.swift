//
//  ContentView.swift
//  PollenAppSwiftUI
//
//  Created by Sabri Sönmez on 2/14/21.
//

import SwiftUI
import SwiftUICharts
import CoreData

struct ContentView: View {
    @State var didAppear = false
    @State var appearCount = 0
    @State var chartData: [Double] = [0, 5, 6, 2, 13, 4, 3, 6]
    @ObservedObject var networkManager = NetworkManager()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var pollenLincoln: FetchedResults<PollenLincoln>
    
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
                    ForEach((0 ..< 3)) { index in
                        if pollenLincoln[index].name != nil && pollenLincoln[index].date != nil && pollenLincoln[index].count != nil  {
                            ExcelDataRow(date: pollenLincoln[index].date!, pollenName: pollenLincoln[index].name!, pollenCount: pollenLincoln[index].count!)
                        }
                       }
//                    ForEach((pollenLincoln)) { pollen in
//                        if pollen.name != nil && pollen.date != nil && pollen.count != nil  {
//                            ExcelDataRow(date: pollen.date!, pollenName: pollen.name!, pollenCount: pollen.count!)
//                        }
//                    }
                    
                    //                    if(networkManager.sheetsData.pollenDatesLincoln[$0] != "-"){
                    //                        ExcelDataRow(date: networkManager.sheetsData.pollenDatesLincoln[$0], pollenName: networkManager.sheetsData.pollenNamesLincoln[$0], pollenCount: networkManager.sheetsData.pollenCountLincoln[$0])
                    //                       }
                }
            }
            
            //        ScrollView {
            //            Image(location.heroPicture)
            //                .resizable()
            //                .scaledToFit()
            //            PollenCardView(image: "Product_1", title: "Armonk, NY", type: "Predominant Pollen:", pollen: "Oak 50% Fern Spores:50%")
            //            VStack {
            //                HStack {
            //                    BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Title", style: Styles.barChartStyleOrangeLight)
            //                    MultiLineChartView(data: [([8,32,11,23,40,28], GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Title")
            //
            //                }
            //            }
            
            //        }
            
            
        }.navigationTitle("Home")
        .onAppear(perform: onLoad)
        
    }
    
    func onLoad() {
        if didAppear == false {
            appearCount += 1
            //This is where I loaded my coreData information into normal arrays
            networkManager.loadData(onCompletion: { (successful) in
                print(successful)
                for index in 0...350 {
                                   if(networkManager.sheetsData.pollenDatesLincoln[index] != "-"){
                                       addData(date: networkManager.sheetsData.pollenDatesLincoln[index], name: networkManager.sheetsData.pollenNamesLincoln[index], count: networkManager.sheetsData.pollenCountLincoln[index])
               
                                   }
                               }
            }) { (error) in
                print(error.domain)
            }
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
//                for index in 0...350 {
//                    if(networkManager.sheetsData.pollenDatesLincoln[index] != "-"){
//                        addData(date: networkManager.sheetsData.pollenDatesLincoln[index], name: networkManager.sheetsData.pollenNamesLincoln[index], count: networkManager.sheetsData.pollenCountLincoln[index])
//
//                    }
//                }
//            }
            //                for index in 0...networkManager.sheetsData.pollenDatesLincoln.count - 1 {
            //                    if(networkManager.sheetsData.pollenDatesLincoln[index] != "-"){
            //                        addData(date: networkManager.sheetsData.pollenDatesLincoln[index], name: networkManager.sheetsData.pollenNamesLincoln[index], count: networkManager.sheetsData.pollenCountLincoln[index])
            ////                        print("adding")
            //                    }
            //                }
         
            
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
    
    private func addData(date:String, name: String, count:String) {
        
            let newData = PollenLincoln(context: viewContext)
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
