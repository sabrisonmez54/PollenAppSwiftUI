////
////  ExcelDataRow.swift
////  PollenAppSwiftUI
////
////  Created by Sabri Sönmez on 3/11/21.
////
//
import SwiftUI

struct ExcelDataRow: View {
    
    var date = Date()
    var pollenName : String = ""
    var pollenCount : String = ""

    var body: some View {
            VStack {
                Spacer()
                HStack {
                    Text(date, style: .date)
                        .foregroundColor(.blue)
                        .lineLimit(nil)
                    Spacer()
                }
             
                HStack {
                    Text("Pollen Count: \(pollenCount)")
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                    Spacer()
                }
                   HStack {
                    Text("Predominant Pollen: \(pollenName)")
                           .foregroundColor(.gray)
                           .lineLimit(nil)
                       Spacer()
                   }
                                Spacer()
            }.frame(height: 130)
        }
    }

extension Float {
    func format() -> String {
        return String(format: "%.2f",self)
    }
}
