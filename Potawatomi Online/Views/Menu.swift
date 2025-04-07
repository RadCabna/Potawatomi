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
    @State private var showBonuses = false
    @State private var remainingTime: TimeInterval = 24 * 60 * 60
    @State private var isButtonActive = false
    @State private var timer: Timer?
    private let savedRemainingTimeKey = "savedRemainingTime"
    private let lastSaveTimestampKey = "lastSaveTimestamp"
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
                    Image("bonusButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.125)
                        .shadow(color: .red, radius: shadowRadiusArray[4])
                        .shadow(color: .red, radius: shadowRadiusArray[4])
                        .overlay(
                            ZStack {
                                if isButtonActive {
                                    Text("OPEN")
                                        .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                                        .foregroundColor(.white)
                                } else {
                                    Text(buttonText)
                                        .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                                        .foregroundColor(.white)
                                }
                            }
                                .offset(y: screenWidth*0.02)
                        )
                        .onTapGesture {
                            showBonuses.toggle()
                            resetTimer()
                        }
                        .disabled(!isButtonActive)
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
            if showBonuses {
                BonusView(showBonus: $showBonuses)
            }
        }
        
        .onAppear {
            loadTimerState()
            shadowAnimation()
            if music {
                SoundManager.instance.playSound(sound: "musicMain")
            }
        }
        .onDisappear {
                    saveTimerState()
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
    
    private func loadTimerState() {
        let savedRemainingTime = UserDefaults.standard.double(forKey: savedRemainingTimeKey)
        let lastSaveTimestamp = UserDefaults.standard.double(forKey: lastSaveTimestampKey)
        
        if savedRemainingTime > 0 {
            let currentTime = Date().timeIntervalSince1970
            let timePassed = currentTime - lastSaveTimestamp
            
            remainingTime = max(savedRemainingTime - timePassed, 0)
            
            if remainingTime <= 0 {
                isButtonActive = true
                return
            }
        }
        
        startTimer()
    }
    
    private var buttonText: String {
            if isButtonActive {
                return "MENU"
            } else {
                let hours = Int(remainingTime) / 3600
                let minutes = (Int(remainingTime) % 3600) / 60
                let seconds = Int(remainingTime) % 60
                return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        }
    
    private func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer?.invalidate()
                isButtonActive = true
            }
        }
    }
    
    private func resetTimer() {
        isButtonActive = false
        remainingTime = 24 * 60 * 60
        startTimer()
    }
    
    private func saveTimerState() {
        UserDefaults.standard.set(remainingTime, forKey: savedRemainingTimeKey)
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: lastSaveTimestampKey)
        
        timer?.invalidate()
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
