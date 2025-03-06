//
//  Model.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 05.03.2025.
//



import Foundation
import SwiftUI

struct Thunder: Equatable {
    var itemName: String = ""
    var positionX: CGFloat
    var positionY: CGFloat
    var lineCollect = false
    var haveThunder = false
    var yourThunder = true
    var strokeActive = false
    var strokeColor = Color.white
    var isSelect = false
}

struct Lines: Equatable {
    var itemName: String
    var positionX: CGFloat
    var positionY: CGFloat
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var opacity: CGFloat = 1
    var lineActive = false
}

struct ShopItem {
    var itemImage: String
    var itemName: String
}

class Arrays {
    
    static var guidePlateArray = [
    "guideImage1",
    "guideImage2",
    "guideImage3",
    "guideImage4",
    "guideImage5",
    "guideImage6"
    ]
    
    static var shopItemsArray: [ShopItem] = [
    ShopItem(itemImage: "blueThunder", itemName: "BLUE THUNDER"),
    ShopItem(itemImage: "yellowThunder", itemName: "YELLOW THUNDER"),
    ShopItem(itemImage: "redThunder", itemName: "RED \nTHUNDER"),
    ShopItem(itemImage: "violetThunder", itemName: "VIOLET THUNDER"),
    ShopItem(itemImage: "lightBlueThunder", itemName: "LIGHT BLUE \nTHUNDER")
    ]
    
    static var loadingArray = [
        "loadingThunder1",
        "loadingThunder2",
        "loadingThunder3",
        "loadingThunder4",
        "loadingThunder5"
        ]
    
    static var rectanglesOnGameField: [[Thunder]] = [
        [Thunder(positionX: -135, positionY: -137), Thunder(positionX: 0, positionY: -135), Thunder(positionX: 135, positionY: -135)],
        [Thunder(positionX: -98, positionY: -98), Thunder(positionX: 0, positionY: -98), Thunder(positionX: 98, positionY: -98)],
        [Thunder(positionX: -61, positionY: -61), Thunder(positionX: 0, positionY: -61), Thunder(positionX: 61, positionY: -61)],
        
        [Thunder(positionX: -135, positionY: -2), Thunder(positionX: -98, positionY: -2), Thunder(positionX: -61, positionY: -2)],
        [Thunder(positionX: 61, positionY: -2), Thunder(positionX: 98, positionY: -2), Thunder(positionX: 135, positionY: -2)],
        
        [Thunder(positionX: -61, positionY: 61), Thunder(positionX: 0, positionY: 61), Thunder(positionX: 61, positionY: 61)],
        [Thunder(positionX: -98, positionY: 98), Thunder(positionX: 0, positionY: 98), Thunder(positionX: 98, positionY: 98)],
        [Thunder(positionX: -135, positionY: 135), Thunder(positionX: 0, positionY: 135), Thunder(positionX: 135, positionY: 135)]
    ]
    
    static var blueLinesOnGameField: [[Lines]] = [
    [Lines(itemName: "blueVertical1", positionX: -136, positionY: 0), Lines(itemName: "blueVertical2", positionX: -99, positionY: 0), Lines(itemName: "blueVertical3", positionX: -62, positionY: 0),],
    [Lines(itemName: "blueVertical1", positionX: 134, positionY: 0), Lines(itemName: "blueVertical2", positionX:97, positionY: 0), Lines(itemName: "blueVertical3", positionX: 60, positionY: 0)],
    [Lines(itemName: "blueVertical4", positionX: 0, positionY: -98), Lines(itemName: "blueVertical4", positionX: 0, positionY: 98)],
    [Lines(itemName: "blueHorizontal1", positionX: 0, positionY: -139), Lines(itemName: "blueHorizontal2", positionX: 0, positionY: -98), Lines(itemName: "blueHorizontal3", positionX: 0, positionY: -58)],
    [Lines(itemName: "blueHorizontal1", positionX: 0, positionY: 139), Lines(itemName: "blueHorizontal2", positionX: 0, positionY: 98), Lines(itemName: "blueHorizontal3", positionX: 0, positionY: 58)],
    [Lines(itemName: "blueHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "blueHorizontal4", positionX: 98, positionY: 0)]
    ]
    
    static var redLinesOnGameField: [[Lines]] = [
    [Lines(itemName: "redVertical1", positionX: -136, positionY: 0), Lines(itemName: "redVertical2", positionX: -99, positionY: 0), Lines(itemName: "redVertical3", positionX: -62, positionY: 0),],
    [Lines(itemName: "redVertical1", positionX: 134, positionY: 0), Lines(itemName: "redVertical2", positionX:97, positionY: 0), Lines(itemName: "redVertical3", positionX: 60, positionY: 0)],
    [Lines(itemName: "redVertical4", positionX: 0, positionY: -98), Lines(itemName: "redVertical4", positionX: 0, positionY: 98)],
    [Lines(itemName: "redHorizontal1", positionX: 0, positionY: -139), Lines(itemName: "redHorizontal2", positionX: 0, positionY: -98), Lines(itemName: "redHorizontal3", positionX: 0, positionY: -58)],
    [Lines(itemName: "redHorizontal1", positionX: 0, positionY: 139), Lines(itemName: "redHorizontal2", positionX: 0, positionY: 98), Lines(itemName: "redHorizontal3", positionX: 0, positionY: 58)],
    [Lines(itemName: "redHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "redHorizontal4", positionX: 98, positionY: 0)]
    ]
    
    static var yellowLinesOnGameField: [[Lines]] = [
    [Lines(itemName: "yellowVertical1", positionX: -135, positionY: 0), Lines(itemName: "yellowVertical2", positionX: -98, positionY: 0), Lines(itemName: "yellowVertical3", positionX: -61, positionY: 0),],
    [Lines(itemName: "yellowVertical1", positionX: 135, positionY: 0), Lines(itemName: "yellowVertical2", positionX:98, positionY: 0), Lines(itemName: "yellowVertical3", positionX: 61, positionY: 0)],
    [Lines(itemName: "yellowVertical4", positionX: 0, positionY: -98), Lines(itemName: "yellowVertical4", positionX: 0, positionY: 98)],
    [Lines(itemName: "yellowHorizontal1", positionX: 0, positionY: -135), Lines(itemName: "yellowHorizontal2", positionX: 0, positionY: -98), Lines(itemName: "yellowHorizontal3", positionX: 0, positionY: -61)],
    [Lines(itemName: "yellowHorizontal1", positionX: 0, positionY: 135), Lines(itemName: "yellowHorizontal2", positionX: 0, positionY: 98), Lines(itemName: "yellowHorizontal3", positionX: 0, positionY: 61)],
    [Lines(itemName: "yellowHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "yellowHorizontal4", positionX: 98, positionY: 0)]
    ]
    
    static var violetLinesOnGameField: [[Lines]] = [
    [Lines(itemName: "violetVertical1", positionX: -135, positionY: 0), Lines(itemName: "violetVertical2", positionX: -98, positionY: 0), Lines(itemName: "violetVertical3", positionX: -61, positionY: 0),],
    [Lines(itemName: "violetVertical1", positionX: 135, positionY: 0), Lines(itemName: "violetVertical2", positionX:98, positionY: 0), Lines(itemName: "violetVertical3", positionX: 61, positionY: 0)],
    [Lines(itemName: "violetVertical4", positionX: 0, positionY: -98), Lines(itemName: "violetVertical4", positionX: 0, positionY: 98)],
    [Lines(itemName: "violetHorizontal1", positionX: 0, positionY: -135), Lines(itemName: "violetHorizontal2", positionX: 0, positionY: -98), Lines(itemName: "violetHorizontal3", positionX: 0, positionY: -61)],
    [Lines(itemName: "violetHorizontal1", positionX: 0, positionY: 135), Lines(itemName: "violetHorizontal2", positionX: 0, positionY: 98), Lines(itemName: "violetHorizontal3", positionX: 0, positionY: 61)],
    [Lines(itemName: "violetHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "violetHorizontal4", positionX: 98, positionY: 0)]
    ]
    
    static var lightBlueLinesOnGameField: [[Lines]] = [
    [Lines(itemName: "lightBlueVertical1", positionX: -135, positionY: 0), Lines(itemName: "lightBlueVertical2", positionX: -98, positionY: 0), Lines(itemName: "lightBlueVertical3", positionX: -61, positionY: 0),],
    [Lines(itemName: "lightBlueVertical1", positionX: 135, positionY: 0), Lines(itemName: "lightBlueVertical2", positionX:98, positionY: 0), Lines(itemName: "lightBlueVertical3", positionX: 61, positionY: 0)],
    [Lines(itemName: "lightBlueVertical4", positionX: 0, positionY: -98), Lines(itemName: "lightBlueVertical4", positionX: 0, positionY: 98)],
    [Lines(itemName: "lightBlueHorizontal1", positionX: 0, positionY: -135), Lines(itemName: "lightBlueHorizontal2", positionX: 0, positionY: -98), Lines(itemName: "lightBlueHorizontal3", positionX: 0, positionY: -61)],
    [Lines(itemName: "lightBlueHorizontal1", positionX: 0, positionY: 135), Lines(itemName: "lightBlueHorizontal2", positionX: 0, positionY: 98), Lines(itemName: "lightBlueHorizontal3", positionX: 0, positionY: 61)],
    [Lines(itemName: "lightBlueHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "lightBlueHorizontal4", positionX: 98, positionY: 0)]
    ]
}



