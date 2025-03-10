//
//  Background.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 05.03.2025.
//

import SwiftUI

struct Background: View {
   @AppStorage("backgroundNumber") var backgroundNumber = 1
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            let isLandscape = width > height
            if isLandscape {
                Image(whatBG())
                    .resizable()
                    .ignoresSafeArea()
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            } else {
                Image(whatBG())
                    .resizable()
                    .frame(width: height*1.2, height: width)
                    .rotationEffect(Angle(degrees: -90))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
            }
        }
    }
    
    func whatBG() -> String{
        switch backgroundNumber {
        case 1:
            return "background"
        case 2:
            return "background2"
        case 3:
            return "background3"
        case 4:
            return "background4"
        default:
            return "background"
        }
    }
    
}

#Preview {
    Background()
}
