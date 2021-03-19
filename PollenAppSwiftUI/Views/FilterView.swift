//
//  filterView.swift
//  PollenAppSwiftUI
//
//  Created by Sabri Sönmez on 3/19/21.
//

import SwiftUI
import CoreData

struct FilterView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(sortDescriptors: [])
//    private var pollenLincoln: FetchedResults<PollenLincoln>
    @FetchRequest(
        entity: PollenLincoln.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "name CONTAINS[c] 'Honey Locust'")

    ) var pollenLincoln: FetchedResults<PollenLincoln>
   
    var body: some View {
       
        VStack {
                List {
                    if pollenLincoln.count > 0 {
                      
                        ForEach((0 ..< pollenLincoln.count - 1)) { index in
                            if pollenLincoln[index].name != nil && pollenLincoln[index].date != nil && pollenLincoln[index].count != nil  {
                                ExcelDataRow(date: pollenLincoln[index].date!, pollenName: pollenLincoln[index].name!, pollenCount: pollenLincoln[index].count!)
                            }
                           }
                    }
                   

                }
            
        }
        .navigationTitle("Filter and Search")
     
    
    }
 
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
