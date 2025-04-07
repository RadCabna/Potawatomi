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
    var itemText: String
    var itemCost: Int
}

struct Rules {
    var rulesImage: String
    var rulesText: String
}

struct BonusChest {
    var hasBonus: Bool
    var chestImage = "closeChest"
    var shineScale: CGFloat = 0
    var shineOpacity: CGFloat = 0
    var shineAngle: CGFloat = 0
}

class Arrays {
    
    static var bonusChestArray: [BonusChest] = [BonusChest(hasBonus: true), BonusChest(hasBonus: false), BonusChest(hasBonus: false)]
    
    static var rulesArray = [
    Rules(rulesImage: "ruleImage1", rulesText: "1. Placement Phase Players take turns placing their 9 pieces on empty intersections of the board. Creating a ''mill'' (three pieces in a straight line) allows the player to remove an opponent’s piece. Pieces in a mill cannot be removed unless all remaining opponent pieces are part of mills. Once all pieces are placed, the game transitions to the movement phase."),
    Rules(rulesImage: "ruleImage2", rulesText: "2. Movement Phase Players take turns moving their pieces to an adjacent connected node. Forming a mill during this phase also grants the ability to remove an opponent’s piece. The game continues until one player is reduced to three pieces."),
    Rules(rulesImage: "ruleImage3", rulesText: "3. Jumping & Endgame When a player has only three pieces left, they can move freely to any empty node. A player loses if they have fewer than three pieces or are completely blocked from making a move. The key to victory is strategic positioning, forming mills, and blocking your opponent’s moves!")
    ]
    
    static var guidePlateArray = [
    "guideImage1",
    "guideImage2",
    "guideImage3",
    "guideImage4",
    "guideImage5",
    "guideImage6"
    ]
    
    static var shopItemsArray: [ShopItem] = [
   ShopItem(itemImage: "shopItem1", itemText: "NEON CIRCUIT BOARD", itemCost: 1),
   ShopItem(itemImage: "shopItem2", itemText: "MYSTIC FOREST", itemCost: 50),
   ShopItem(itemImage: "shopItem3", itemText: "VOLCANIC LAVA", itemCost: 100),
   ShopItem(itemImage: "shopItem4", itemText: "COSMIC GALAXY", itemCost: 200)
    ]
    
    static var loadingArray = [
        "loadingThunder1",
        "loadingThunder2",
        "loadingThunder3",
        "loadingThunder4",
        "loadingThunder5"
        ]
    
    static var rectanglesOnGameField: [[Thunder]] = [
        [Thunder(positionX: -106, positionY: -106), Thunder(positionX: 0, positionY: -151), Thunder(positionX: 106, positionY: -106)],
        [Thunder(positionX: -82, positionY: -82), Thunder(positionX: 0, positionY: -116), Thunder(positionX: 82, positionY: -82)],
        [Thunder(positionX: -58, positionY: -58), Thunder(positionX: 0, positionY: -82), Thunder(positionX: 58, positionY: -58)],
        
        [Thunder(positionX: -151, positionY: 0), Thunder(positionX: -116, positionY: -0), Thunder(positionX: -82, positionY: -0)],
        [Thunder(positionX: 82, positionY: -0), Thunder(positionX: 116, positionY: -0), Thunder(positionX: 151, positionY: -0)],
        
        [Thunder(positionX: -58, positionY: 58), Thunder(positionX: 0, positionY: 82), Thunder(positionX: 58, positionY: 58)],
        [Thunder(positionX: -82, positionY: 82), Thunder(positionX: 0, positionY: 116), Thunder(positionX: 82, positionY: 82)],
        [Thunder(positionX: -106, positionY: 106), Thunder(positionX: 0, positionY: 151), Thunder(positionX: 106, positionY: 106)]
    ]
    
    static var blueLinesOnGameField: [[Lines]] = [
    [Lines(itemName: "blueVertical1", positionX: -136, positionY: 0), Lines(itemName: "blueVertical2", positionX: -99, positionY: 0), Lines(itemName: "blueVertical3", positionX: -62, positionY: 0),],
    [Lines(itemName: "blueVertical1", positionX: 134, positionY: 0), Lines(itemName: "blueVertical2", positionX:97, positionY: 0), Lines(itemName: "blueVertical3", positionX: 60, positionY: 0)],
    [Lines(itemName: "blueVertical4", positionX: 0, positionY: -98), Lines(itemName: "blueVertical4", positionX: 0, positionY: 98)],
    [Lines(itemName: "blueHorizontal1", positionX: 0, positionY: -139), Lines(itemName: "blueHorizontal2", positionX: 0, positionY: -98), Lines(itemName: "blueHorizontal3", positionX: 0, positionY: -58)],
    [Lines(itemName: "blueHorizontal1", positionX: 0, positionY: 139), Lines(itemName: "blueHorizontal2", positionX: 0, positionY: 98), Lines(itemName: "blueHorizontal3", positionX: 0, positionY: 58)],
    [Lines(itemName: "blueHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "blueHorizontal4", positionX: 98, positionY: 0)],
    [Lines(itemName: "blueHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "blueHorizontal4", positionX: 98, positionY: 0)],
    [Lines(itemName: "blueHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "blueHorizontal4", positionX: 98, positionY: 0)]
    ]
    
    static var redLinesOnGameField: [[Lines]] = [
    [Lines(itemName: "redVertical1", positionX: -136, positionY: 0), Lines(itemName: "redVertical2", positionX: -99, positionY: 0), Lines(itemName: "redVertical3", positionX: -62, positionY: 0),],
    [Lines(itemName: "redVertical1", positionX: 134, positionY: 0), Lines(itemName: "redVertical2", positionX:97, positionY: 0), Lines(itemName: "redVertical3", positionX: 60, positionY: 0)],
    [Lines(itemName: "redVertical4", positionX: 0, positionY: -98), Lines(itemName: "redVertical4", positionX: 0, positionY: 98)],
    [Lines(itemName: "redHorizontal1", positionX: 0, positionY: -139), Lines(itemName: "redHorizontal2", positionX: 0, positionY: -98), Lines(itemName: "redHorizontal3", positionX: 0, positionY: -58)],
    [Lines(itemName: "redHorizontal1", positionX: 0, positionY: 139), Lines(itemName: "redHorizontal2", positionX: 0, positionY: 98), Lines(itemName: "redHorizontal3", positionX: 0, positionY: 58)],
    [Lines(itemName: "redHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "redHorizontal4", positionX: 98, positionY: 0)],
    [Lines(itemName: "blueHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "blueHorizontal4", positionX: 98, positionY: 0)],
    [Lines(itemName: "blueHorizontal4", positionX: -98, positionY: 0), Lines(itemName: "blueHorizontal4", positionX: 98, positionY: 0)]
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



