//
//  HowToPlay.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 11.03.2025.
//

import SwiftUI

struct HowToPlay: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("sound") var sound = true
    @AppStorage("music") var music = true
    @AppStorage("coinCount") var coinCount = 0
    @State private var shadowRadiusArray: [CGFloat] = [0,0,0,0,0,0]
    @State private var rulesArray = Arrays.rulesArray
    @State private var rulesNumber = 0
    var body: some View {
        ZStack {
            Background()
            HStack {
                Image("arrowBack")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .shadow(color: .red, radius: shadowRadiusArray[0])
                    .shadow(color: .red, radius: shadowRadiusArray[0])
                    .onTapGesture {
                        coordinator.navigateBack()
                    }
                Image(sound ? "soundOn" : "soundOff")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .shadow(color: .red, radius: shadowRadiusArray[1])
                    .shadow(color: .red, radius: shadowRadiusArray[1])
                    .onTapGesture {
                        sound.toggle()
                    }
                Image(music ? "musicOn" : "musicOff")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .shadow(color: .red, radius: shadowRadiusArray[2])
                    .shadow(color: .red, radius: shadowRadiusArray[2])
                    .onTapGesture {
                        music.toggle()
                    }
                Spacer()
                Image("coinImageFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .shadow(color: .red, radius: shadowRadiusArray[3])
                    .shadow(color: .red, radius: shadowRadiusArray[3])
                    .onTapGesture {
                        coinCount += 50
                    }
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
                    .onTapGesture {
                        UserDefaults.standard.removeObject(forKey: "shopItemsData")
                        UserDefaults.standard.removeObject(forKey: "gameSet")
                    }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            Image("rulesFrame")
                .resizable()
                .scaledToFit()
                .frame(height: screenWidth*0.36)
                .overlay(
                    VStack {
                        Text(rulesArray[rulesNumber].rulesText)
                            .font(Font.custom("PassionOne-Regular", size: screenWidth*0.015))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Image(rulesArray[rulesNumber].rulesImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.08)
                        Spacer()
                        HStack {
                            if rulesNumber > 0 {
                                Image("blackButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenWidth*0.05)
                                    .overlay(
                                        Text("BACK")
                                            .font(Font.custom("PassionOne-Regular", size: screenWidth*0.025))
                                            .foregroundColor(.white)
                                    )
                                    .onTapGesture {
                                        changeRuleNumber(direction: -1)
                                    }
                            }
                            if rulesNumber < 2 {
                                Image("blackButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenWidth*0.05)
                                    .overlay(
                                        Text("NEXT")
                                            .font(Font.custom("PassionOne-Regular", size: screenWidth*0.025))
                                            .foregroundColor(.white)
                                    )
                                    .onTapGesture {
                                        changeRuleNumber(direction: 1)
                                    }
                            }
                        }
                    }
                        .padding(.vertical, screenWidth*0.06)
                        .offset(y: screenWidth*0.04)
                )
                .offset(y: screenWidth*0.03)
        }
        
        .onAppear {
            shadowAnimation()
        }
        
    }
    
    func changeRuleNumber(direction: Int) {
        withAnimation() {
            rulesNumber += direction
            if rulesNumber > 2 {
                rulesNumber = 0
            }
            if rulesNumber < 0 {
                rulesNumber = 2
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
    HowToPlay()
}
