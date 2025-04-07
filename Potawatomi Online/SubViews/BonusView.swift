//
//  BonusView.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 07.04.2025.
//

import SwiftUI

struct BonusView: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("sound") var sound = true
    @AppStorage("music") var music = true
    @AppStorage("coinCount") var coinCount = 0
    @State private var shadowRadiusArray: [CGFloat] = [0,0,0,0,0,0]
    @State private var bonusChestArray = Arrays.bonusChestArray
    @State private var chestChosen = false
    @State private var youWin = false
    @State private var youLose = false
    @Binding var showBonus: Bool
    var body: some View {
        ZStack {
            Background()
            HStack {
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
            Image("choseChestFrame")
                .resizable()
                .scaledToFit()
                .frame(height: screenWidth*0.38)
                .offset(y: screenWidth*0.02)
                .overlay(
                    HStack {
                        ForEach(0..<bonusChestArray.count, id: \.self) { item in
                            ZStack {
                                Image(bonusChestArray[item].chestImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.2)
                                    .shadow(color: .purple, radius: shadowRadiusArray[item+1]+5)
                                    .shadow(color: .purple, radius: shadowRadiusArray[item+1]+5)
                                Image("shine")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenWidth*0.05)
                                    .scaleEffect(x: bonusChestArray[item].shineScale*0.5, y: bonusChestArray[item].shineScale)
                                    .opacity(bonusChestArray[item].shineOpacity)
                                    .rotationEffect(Angle(degrees: bonusChestArray[item].shineAngle))
                            }
                            .onTapGesture {
                                choseChest(item: item)
                            }
                            .disabled(chestChosen)
                        }
                    }
                        .offset(y: screenWidth*0.07)
                )
            if youWin {
                Color.black.opacity(0.5).ignoresSafeArea()
                Image("youWinBonus")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.35)
                    .overlay(
                        VStack {
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
                                        Text("+50")
                                            .font(Font.custom("PassionOne-Regular", size: screenWidth*0.04))
                                            .foregroundColor(.white)
                                    )
                            }
                            Image("menuButton")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenWidth*0.08)
                                .shadow(color: .red, radius: 3)
                                .shadow(color: .red, radius: 3)
                                .onTapGesture {
                                    coinCount += 50
                                    showBonus.toggle()
                                }
                        }
                            .offset(y: screenWidth*0.035)
                    )
                
            }
            if youLose {
                Color.black.opacity(0.5).ignoresSafeArea()
                Image("bonusFail")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.35)
                    .overlay(
                        Image("menuButton")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenWidth*0.08)
                            .shadow(color: .red, radius: 3)
                            .shadow(color: .red, radius: 3)
                            .onTapGesture {
                                coordinator.navigate(to: .mainMenu)
                            }
                            .offset(y: screenWidth*0.035)
                    )
            }
        }
        
        .onAppear {
            shadowAnimation()
            bonusChestArray = bonusChestArray.shuffled()
        }
        
    }
    
    func choseChest(item: Int) {
        if bonusChestArray[item].hasBonus && sound {
            SoundManager.instance.playSound(sound: "bonusWinSound")
        }
        if !bonusChestArray[item].hasBonus && sound {
            SoundManager.instance.playSound(sound: "chestOpenSound")
        }
        withAnimation(Animation.easeInOut(duration: 2)) {
            bonusChestArray[item].shineAngle = 360
            bonusChestArray[item].shineOpacity = 1
            bonusChestArray[item].shineScale = 15
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.easeInOut(duration: 1)) {
                if  bonusChestArray[item].hasBonus {
                    bonusChestArray[item].chestImage = "openChestFull"
                } else {
                    bonusChestArray[item].chestImage = "openChestEmpty"
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(Animation.easeInOut(duration: 2)) {
                bonusChestArray[item].shineOpacity = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if bonusChestArray[item].hasBonus {
                youWin = true
            } else {
                youLose = true
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
    BonusView(showBonus: .constant(true))
}
