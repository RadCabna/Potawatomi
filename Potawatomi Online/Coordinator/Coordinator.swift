//
//  Coordinator.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 05.03.2025.
//

import Foundation
import SwiftUI

enum CoordinatorView: Equatable {
    case loading
    case mainMenu
    case game
    case gameMode
    case settings
    case rules
    case shop
}

final class Coordinator: ObservableObject {
    @Published var path: [CoordinatorView] = []

    func resolve(pathItem: CoordinatorView) -> AnyView {
        var view = AnyView(Loading())
        switch pathItem {
        case .loading:
            view = AnyView(Loading())
        case .mainMenu:
            view = AnyView(Menu())
        case .game:
            view = AnyView(Game())
        case .settings:
            view = AnyView(Settings())
        case .rules:
            view = AnyView(HowToPlay())
        case .shop:
            view = AnyView(Shop())
        case .gameMode:
            view = AnyView(ChoseGameMode())
        }
        return view
    }
    
    func navigate(to pathItem: CoordinatorView) {
        path.append(pathItem)
    }
    
    func navigateBack() {
        _ = path.popLast()
    }
}

struct ContentView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        ZStack {
            coordinator.resolve(pathItem: coordinator.path.last ?? .loading)
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}


