//
//  Settings.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 11.03.2025.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("sound") var sound = true
    @AppStorage("vibration") var vibration = true
    @AppStorage("music") var music = true
    @AppStorage("coinCount") var coinCount = 0
    @State private var shadowRadiusArray: [CGFloat] = [0,0,0,0,0,0]
    @Binding var showSettings: Bool
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
                        showSettings.toggle()
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
            Image("settingsFrame")
                .resizable()
                .scaledToFit()
                .frame(height: screenWidth*0.4)
                .overlay (
                    VStack(spacing: screenWidth*0.014) {
                Text("SOUND")
                    .font(Font.custom("PassionOne-Regular", size: screenWidth*0.042))
                    .foregroundColor(.white)
                        HStack {
                            Text("OFF")
                                .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                                .foregroundColor(.white)
                            Toggle("", isOn: $sound)
                                .toggleStyle(CustomToggle())
                            Text("ON")
                                .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                                .foregroundColor(.white)
                        }
                Text("VIBRATION")
                    .font(Font.custom("PassionOne-Regular", size: screenWidth*0.042))
                    .foregroundColor(.white)
                HStack {
                    Text("OFF")
                        .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                        .foregroundColor(.white)
                    Toggle("", isOn: $vibration)
                        .toggleStyle(CustomToggle())
                    Text("ON")
                        .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                        .foregroundColor(.white)
                }
                HStack {
                    Image("blackButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.05)
                        .overlay(
                            Text("RATE US")
                                .font(Font.custom("PassionOne-Regular", size: screenWidth*0.025))
                                .foregroundColor(.white)
                        )
                        .shadow(color: .red, radius: shadowRadiusArray[3])
                        .shadow(color: .red, radius: shadowRadiusArray[3])
                        .onTapGesture {
                            openAppStoreForRating()
                        }
                    Image("blackButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.05)
                        .overlay(
                            Text("SHARE")
                                .font(Font.custom("PassionOne-Regular", size: screenWidth*0.025))
                                .foregroundColor(.white)
                        )
                        .shadow(color: .red, radius: shadowRadiusArray[4])
                        .shadow(color: .red, radius: shadowRadiusArray[4])
                        .onTapGesture {
                            shareApp()
                        }
                }
                .padding(.top)
            }
                        .offset(y: screenWidth*0.04)
                )
                .offset(y: screenWidth*0.02)
        }
        
        .onAppear {
            shadowAnimation()
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
    
    func shareApp() {
            guard let url = URL(string: "https://apps.apple.com/app/id6743117540") else {
                return
            }

            let activityViewController = UIActivityViewController(
                activityItems: [url],
                applicationActivities: nil
            )

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(activityViewController, animated: true, completion: nil)
            }
        }
    
    func openAppStoreForRating() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id6743117540?action=write-review") else {
            return
        }
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL)
        }
    }
    
}

#Preview {
    Settings(showSettings: .constant(true))
}


struct CustomToggle: ToggleStyle {
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            ZStack {
               Image("toggleBack")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth * 0.033)
                    .shadow(color: configuration.isOn ? .blue : .red, radius: 5)
                    .shadow(color: configuration.isOn ? .blue : .red, radius: 5)
                Image(configuration.isOn ? "toggleOn" : "toggleOff")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.028)
                    .offset(x: configuration.isOn ? screenWidth * 0.038 : -screenWidth * 0.038)
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
            }
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
