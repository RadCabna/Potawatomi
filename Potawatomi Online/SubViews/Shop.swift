//
//  Shop.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 10.03.2025.
//

import SwiftUI

struct Shop: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("sound") var sound = true
    @AppStorage("music") var music = true
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("gameSet") var gameSet = 1
    @State private var shopItemsData = UserDefaults.standard.array(forKey: "shopItemsData") as? [Int] ?? [2,0,0,0]
    @State private var shopItemsArray = Arrays.shopItemsArray
    @State private var shadowRadiusArray: [CGFloat] = [0,0,0,0,0,0]
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
            Image("shopFrame")
                .resizable()
                .scaledToFit()
                .frame(height: screenWidth*0.36)
                .overlay(
                    HStack {
                        ForEach(0..<shopItemsArray.count, id: \.self) { item in
                            VStack {
                                Image(shopItemsArray[item].itemImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenWidth*0.13)
                                Text(shopItemsArray[item].itemText)
                                    .font(Font.custom("PassionOne-Regular", size: screenWidth*0.022))
                                    .foregroundColor(.white)
                                if shopItemsData[item] == 0 && coinCount >= shopItemsArray[item].itemCost{
                                   Image("greenShopButton")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenWidth*0.045)
                                        .overlay(
                                            Text("\(shopItemsArray[item].itemCost)")
                                                .font(Font.custom("PassionOne-Regular", size: screenWidth*0.022))
                                                .foregroundColor(.white)
                                        )
                                        .onTapGesture {
                                            buyItem(item: item)
                                        }
                                }
                                if shopItemsData[item] == 0 && coinCount < shopItemsArray[item].itemCost{
                                    Image("redShopButton")
                                         .resizable()
                                         .scaledToFit()
                                         .frame(height: screenWidth*0.045)
                                         .overlay(
                                            HStack {
                                                Image("coin")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: screenWidth*0.025)
                                                Text("\(shopItemsArray[item].itemCost)")
                                                    .font(Font.custom("PassionOne-Regular", size: screenWidth*0.022))
                                                    .foregroundColor(.white)
                                            }
                                         )
                                }
                                if shopItemsData[item] == 1 {
                                    Image("greenShopButton")
                                         .resizable()
                                         .scaledToFit()
                                         .frame(height: screenWidth*0.045)
                                         .overlay(
                                             Text("SELECT")
                                                 .font(Font.custom("PassionOne-Regular", size: screenWidth*0.022))
                                                 .foregroundColor(.white)
                                         )
                                         .onTapGesture {
                                             selectItem(item: item)
                                         }
                                }
                                if shopItemsData[item] == 2 {
                                    Image("selectedButton")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenWidth*0.045)
                                }
                            }
                            .frame(minWidth: screenWidth*0.16)
                            .offset(y: screenWidth*0.035)
                        }
                    }
                )
                .offset(y: screenWidth*0.02)
        }
        
        .onAppear {
            shadowAnimation()
        }
        
    }
    
    func buyItem(item: Int) {
        if coinCount >= shopItemsArray[item].itemCost {
            coinCount -= shopItemsArray[item].itemCost
            shopItemsData[item] = 1
            UserDefaults.standard.setValue(shopItemsData, forKey: "shopItemsData")
        }
    }
    
    func selectItem(item: Int) {
        if shopItemsData[item] == 1 {
            for i in 0..<shopItemsData.count {
                if shopItemsData[i] == 2 {
                    shopItemsData[i] = 1
                }
            }
            shopItemsData[item] = 2
            UserDefaults.standard.setValue(shopItemsData, forKey: "shopItemsData")
            gameSet = item+1
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
    Shop()
}
