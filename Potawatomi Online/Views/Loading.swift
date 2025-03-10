//
//  Loading.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 05.03.2025.
//

import SwiftUI

struct Loading: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var loadingShadowRadius: CGFloat = 0
    @State private var loadingOpacity: CGFloat = 0
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            let isLandscape = width > height
            if isLandscape {
                ZStack {
                    Background()
                    VStack {
                      Image("loadingIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: width*0.25)
                            .shadow(color: .red, radius: loadingShadowRadius)
                            .shadow(color: .red, radius: loadingShadowRadius)
                        Text("LOADING...")
                            .font(Font.custom("PassionOne-Regular", size: width*0.05))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                    }
                    .offset(y: width*0.05)
                    .opacity(loadingOpacity)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            } else {
                ZStack {
                    Background()
                    VStack {
                        Image("loadingIcon")
                              .resizable()
                              .scaledToFit()
                              .frame(height: height*0.25)
                              .shadow(color: .red, radius: loadingShadowRadius)
                              .shadow(color: .red, radius: loadingShadowRadius)
                          Text("LOADING...")
                              .font(Font.custom("PassionOne-Regular", size: height*0.05))
                              .foregroundColor(.white)
                              .shadow(color: .black, radius: 2)
                              .shadow(color: .black, radius: 2)
                    }
                    .opacity(loadingOpacity)
                    .rotationEffect(Angle(degrees: -90))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
        }
        
        .onAppear {
            changeLogoShadowRadiusAnimation()
        }
        
    }
    
    func changeLogoShadowRadiusAnimation() {
        loadingShadowRadius = 0
        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
            loadingShadowRadius = 10
        }
        withAnimation(Animation.easeInOut(duration: 1.5)) {
            loadingOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            coordinator.navigate(to: .mainMenu)
        }
    }
    
}

#Preview {
    Loading()
}
