//
//  CardModifier.swift
//  PollenAppSwiftUI
//
//  Created by Sabri Sönmez on 2/14/21.
//

import Foundation
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}
