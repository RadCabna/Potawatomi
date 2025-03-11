//
//  WinView.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 10.03.2025.
//

import SwiftUI

struct WinView: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("wCount") var wCount = 0
    @AppStorage("lCount") var lCount = 0
    @AppStorage("sound") var sound = true
    @Binding var showWinView: Bool
    var body: some View {
        Image("winFrame")
            .resizable()
            .scaledToFit()
            .frame(height: screenWidth*0.4)
            .overlay(
                VStack(spacing: screenWidth*0.015) {
                    HStack {
                        Image("coinImageFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.07)
                            .shadow(color: .red, radius: 3)
                            .shadow(color: .red, radius: 3)
                        Image("countFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.07)
                            .shadow(color: .red, radius: 3)
                            .shadow(color: .red, radius: 3)
                            .overlay(
                                Text("+10")
                                    .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                                    .foregroundColor(.white)
                            )
                    }
                    Image("retryButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.08)
                        .shadow(color: .red, radius: 3)
                        .shadow(color: .red, radius: 3)
                        .onTapGesture {
                            coinCount += 10
                            wCount += 1
                            showWinView.toggle()
                        }
                    Image("menuButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.08)
                        .shadow(color: .red, radius: 3)
                        .shadow(color: .red, radius: 3)
                        .onTapGesture {
                            coinCount += 10
                            wCount += 1
                            coordinator.navigate(to: .mainMenu)
                        }
                }
                    .offset(y: screenWidth*0.05)
            )
            .onAppear {
                if sound {
                    SoundManager.instance.playSound(sound: "winSound")
                }
            }
    }
}

#Preview {
    WinView(showWinView: .constant(true))
}
