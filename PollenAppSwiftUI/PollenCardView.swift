//
//  CardView.swift
//  PollenAppSwiftUI
//
//  Created by Sabri Sönmez on 2/14/21.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}

struct PollenCardView: View {
    
    var image: String
    var title: String
    var type: String
    var pollen:String
    
    var body: some View {
    VStack(alignment: .leading) {
        
        Spacer()
        Text("Today")
            .font(.system(size: 26, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding(.leading, 10)
            
        Text("4 pcm") .font(.system(size: 48, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding(.leading, 10)
        
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                    .padding(.top, 5)
                Text(type)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                    .padding(.top, 5)
                HStack {
                    Text(pollen)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                        .padding(.top, 5)
                }
            }
        Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
        .shadow(radius: 5)
        .padding(.all, 10)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        PollenCardView(image: "Product_1", title: "Armonk, NY", type: "Predominant Pollen:", pollen: "Oak 50%")
    }
}
