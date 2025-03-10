//
//  LoseView.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 10.03.2025.
//

import SwiftUI

struct LoseView: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("wCount") var wCount = 0
    @AppStorage("lCount") var lCount = 0
    @Binding var showLoseView: Bool
    var body: some View {
        Image("loseFrame")
            .resizable()
            .scaledToFit()
            .frame(height: screenWidth*0.35)
            .overlay(
                VStack(spacing: screenWidth*0.015) {
                    Image("retryButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.08)
                        .shadow(color: .red, radius: 3)
                        .shadow(color: .red, radius: 3)
                        .onTapGesture {
                            lCount += 1
                            showLoseView.toggle()
                        }
                    Image("menuButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.08)
                        .shadow(color: .red, radius: 3)
                        .shadow(color: .red, radius: 3)
                        .onTapGesture {
                            lCount += 1
                            coordinator.navigate(to: .mainMenu)
                        }
                }
                    .offset(y: screenWidth*0.055)
            )
    }
}

#Preview {
    LoseView(showLoseView: .constant(true))
}
