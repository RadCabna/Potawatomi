//
//  SizeExtention.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 05.03.2025.
//

import Foundation
import SwiftUI

extension View {
    
    var screenHeight : CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var deviceHasSafeArea: Bool {
        let window = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 50
        return window > 20
    }
}

