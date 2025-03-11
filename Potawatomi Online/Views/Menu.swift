//
//  Menu.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 05.03.2025.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("sound") var sound = true
    @AppStorage("music") var music = true
    @AppStorage("wCount") var wCount = 0
    @AppStorage("lCount") var lCount = 0
    @AppStorage("coinCount") var coinCount = 0
    @State private var shadowRadiusArray: [CGFloat] = [0,0,0,0,0,0]
    @State private var showChoseGame = false
    @State private var showHowTo = false
    @State private var showShop = false
    @State private var showSettings = false
    var body: some View {
        ZStack {
            Background()
            HStack {
                Image(sound ? "soundOn" : "soundOff")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .shadow(color: .red, radius: shadowRadiusArray[0])
                    .shadow(color: .red, radius: shadowRadiusArray[0])
                    .onTapGesture {
                        sound.toggle()
                    }
                Image(music ? "musicOn" : "musicOff")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .shadow(color: .red, radius: shadowRadiusArray[1])
                    .shadow(color: .red, radius: shadowRadiusArray[1])
                    .onTapGesture {
                        music.toggle()
                    }
                Spacer()
                Image("countFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .shadow(color: .red, radius: shadowRadiusArray[2])
                    .shadow(color: .red, radius: shadowRadiusArray[2])
                    .overlay(
                    Text("W&L \(wCount) - \(lCount)")
                        .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                        .foregroundColor(.white)
                    )
                    .padding(.leading, screenWidth*0.1)
                Spacer()
                Image("coinImageFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .shadow(color: .red, radius: shadowRadiusArray[3])
                    .shadow(color: .red, radius: shadowRadiusArray[3])
                Image("countFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .shadow(color: .red, radius: shadowRadiusArray[4])
                    .shadow(color: .red, radius: shadowRadiusArray[4])
                    .overlay(
                    Text("\(coinCount)")
                        .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                        .foregroundColor(.white)
                    )
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            VStack {
                Image("playButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.173)
                    .shadow(color: .red, radius: shadowRadiusArray[2])
                    .shadow(color: .red, radius: shadowRadiusArray[2])
                    .onTapGesture {
                        showChoseGame.toggle()
                    }
                HStack {
                    Image("rulesButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.125)
                        .shadow(color: .red, radius: shadowRadiusArray[3])
                        .shadow(color: .red, radius: shadowRadiusArray[3])
                        .onTapGesture {
                            showHowTo.toggle()
                        }
                    Image("shopButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.125)
                        .shadow(color: .red, radius: shadowRadiusArray[4])
                        .shadow(color: .red, radius: shadowRadiusArray[4])
                        .onTapGesture {
                            showShop.toggle()
                        }
                    Image("settingsButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.125)
                        .shadow(color: .red, radius: shadowRadiusArray[5])
                        .shadow(color: .red, radius: shadowRadiusArray[5])
                        .onTapGesture {
                            showSettings.toggle()
                        }
                }
            }
            .offset(y: screenWidth*0.04)
            if showChoseGame {
                ChoseGameMode(showChoseGame: $showChoseGame)
            }
            if showHowTo {
                HowToPlay(showHowTo: $showHowTo)
            }
            if showShop {
                Shop(showShop: $showShop)
            }
            if showSettings {
                Settings(showSettings: $showSettings)
            }
        }
        
        .onAppear {
            shadowAnimation()
            if music {
                SoundManager.instance.playSound(sound: "musicMain")
            }
        }
        
        .onChange(of: music) { _ in
            if !music {
                SoundManager.instance.stopAllSounds()
            } else {
                SoundManager.instance.stopAllSounds()
                SoundManager.instance.playSound(sound: "musicMain")
            }
        }
        
    }
    
    func shadowAnimation() {
        for i in 0..<shadowRadiusArray.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(CGFloat(i)*0.5)) {
                withAnimation(Animation.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                    shadowRadiusArray[i] = 7
                }
            }
        }
    }
    
}

#Preview {
    Menu()
}
