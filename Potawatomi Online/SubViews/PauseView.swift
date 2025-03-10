//
//  PauseView.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 10.03.2025.
//

import SwiftUI

struct PauseView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Binding var showPause: Bool
    var body: some View {
        Image("pauseFrame")
            .resizable()
            .scaledToFit()
            .frame(height: screenWidth*0.35)
            .overlay(
                VStack(spacing: screenWidth*0.015) {
                    Image("resumeButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.08)
                        .shadow(color: .red, radius: 3)
                        .shadow(color: .red, radius: 3)
                        .onTapGesture {
                            showPause.toggle()
                        }
                    Image("menuButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.08)
                        .shadow(color: .red, radius: 3)
                        .shadow(color: .red, radius: 3)
                        .onTapGesture {
                            coordinator.navigate(to: .mainMenu)
                        }
                }
                    .offset(y: screenWidth*0.055)
            )
    }
}

#Preview {
    PauseView(showPause: .constant(true))
}
