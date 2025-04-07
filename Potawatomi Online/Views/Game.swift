//
//  Game.swift
//  Potawatomi Online
//
//  Created by Алкександр Степанов on 05.03.2025.
//

import SwiftUI

struct Game: View {
    @AppStorage("gameSet") var gameSet = 1
    @AppStorage("sound") var sound = true
    @AppStorage("music") var music = true
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("vibration") var vibration = true
    @AppStorage("yourThunderSet") var yourThunderSet = 1
    @AppStorage("selectedThunder") var selectedThunder = 1
    @AppStorage("pvp") var pvp = true
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    @State private var shadowOpacity: CGFloat = 0
    @State private var translationX: CGFloat = 0
    @State private var translationY: CGFloat = 0
    @State private var rectanglesOnGameField = Arrays.rectanglesOnGameField
    @State private var linesOnGameField = Arrays.blueLinesOnGameField
    @State private var enemyLinesOnGameField = Arrays.redLinesOnGameField
    @State private var rectangleStroWidth: CGFloat = 0
    @State private var yourTurn = true
    @State private var selectedRectangleRow: Int = 0
    @State private var selectedRectangleCol: Int = 0
    @State private var yourStageNumber = 1
    @State private var enemyStageNumber = 1
    @State private var yourThunderCountOnGameField = 0
    @State private var enemyThunderCountOnGameField = 0
    @State private var yourThunder = "blueThunder"
    @State private var enemyThunder = "redThunder"
    @State private var youCollectNewLine = false
    @State private var yourLineCoordinatesArray: [(Int, Int)] = [] {
        didSet {
            if yourLineCoordinatesArray.count > oldValue.count {
                youCollectNewLine = true
            }
        }
    }
    @State private var randomeElement: (row: Int, col: Int) = (0,0)
    @State private var enemyCollectNewLine = false
    @State private var enemyLineCoordinatesArray: [(Int, Int)] = [] {
        didSet {
            if enemyLineCoordinatesArray.count > oldValue.count {
                enemyCollectNewLine = true
            }
        }
    }
    @State private var botStepsCoordinates: [(row: Int, col: Int)] = []
    @State private var yourThunderCount = 9
    @State private var enemyThunderCount = 9
    @State private var rectangleStrokeWidthTimer: Timer? = nil
    @State private var enemyWaitYourSteps: Timer? = nil
    @State private var enemyCanMakeStep = false
    @State private var youCreateLine = false
    @State private var enemyCreateLine = false
    @State private var playerOneWin = false
    @State private var playerTwoWin = false
    @State private var showWinView = false
    @State private var showLoseView = false
    @State private var showPause = false
    @State private var shadowRadiusArray: [CGFloat] = [0,0,0,0,0,0]
    var body: some View {
        ZStack {
        Background(backgroundNumber: gameSet)
            HStack {
                Image("pauseButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .shadow(color: .red, radius: shadowRadiusArray[0])
                    .shadow(color: .red, radius: shadowRadiusArray[0])
                    .onTapGesture {
                        showPause.toggle()
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
            ZStack {
                Image("gameField3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.38)
                    .scaleEffect(y: 1.0)
                Image("playingFieldNoRectangles")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.28)
//                ZStack {
//                    ForEach(0..<linesOnGameField.count, id: \.self) { row in
//                        ForEach(0..<linesOnGameField[row].count, id: \.self) { col in
//                            if linesOnGameField[row][col].lineActive {
//                                Image(linesOnGameField[row][col].itemName)
//                                    .frame(maxWidth: screenWidth*0.3, maxHeight: screenHeight*0.04)
//                                    .scaleEffect(x: screenWidth/932, y: screenWidth/932)
//                                    .scaleEffect(x: 0.45, y: 0.45)
//                                    .shadow(color: linesOnGameField[row][col].itemName.hasPrefix("red") ? .red : .blue, radius: 5)
//                                    .shadow(color: linesOnGameField[row][col].itemName.hasPrefix("red") ? .red : .blue, radius: 5)
//                                    .offset(
//                                        x: linesOnGameField[row][col].positionX * screenWidth/932,
//                                        y: linesOnGameField[row][col].positionY * screenWidth/932
//                                    )
//                            }
//                        }
//                    }
//                }
//                ZStack {
//                    ForEach(0..<enemyLinesOnGameField.count, id: \.self) { row in
//                        ForEach(0..<enemyLinesOnGameField[row].count, id: \.self) { col in
//                            if !enemyLinesOnGameField[row][col].lineActive {
//                                Image(enemyLinesOnGameField[row][col].itemName)
//                                    .frame(maxWidth: screenWidth*0.3, maxHeight: screenHeight*0.04)
//                                    .scaleEffect(x: screenWidth/932, y: screenWidth/932)
//                                    .scaleEffect(x: 0.45, y: 0.45)
//                                    .shadow(color: enemyLinesOnGameField[row][col].itemName.hasPrefix("red") ? .red : .blue, radius: 5)
//                                    .shadow(color: enemyLinesOnGameField[row][col].itemName.hasPrefix("red") ? .red : .blue, radius: 5)
//                                    .offset(
//                                        x: linesOnGameField[row][col].positionX * screenWidth/932,
//                                        y: linesOnGameField[row][col].positionY * screenWidth/932
//                                    )
//                            }
//                        }
//                    }
//                }
                
                ForEach(0..<rectanglesOnGameField.count, id: \.self) { row in
                    ForEach(0..<rectanglesOnGameField[row].count, id: \.self) { col in
                        ZStack {
//                            Image("dot")
                            Circle()
                                .frame(width: screenWidth*0.015, height: screenWidth*0.015)
                                .foregroundColor(.white)
                                .offset(x: rectanglesOnGameField[row][col].positionX * screenWidth/932, y: rectanglesOnGameField[row][col].positionY * screenWidth/932)
                            if rectanglesOnGameField[row][col].strokeActive {
                                Circle()
                                    .stroke(lineWidth: rectangleStroWidth)
                                    .frame(width: screenWidth*0.03, height: screenWidth*0.03)
                                    .foregroundColor(rectanglesOnGameField[row][col].strokeColor)
                                    .offset(x: rectanglesOnGameField[row][col].positionX * screenWidth/932, y: rectanglesOnGameField[row][col].positionY * screenWidth/932)
                            }
                            if rectanglesOnGameField[row][col].haveThunder {
                                Image(rectanglesOnGameField[row][col].yourThunder ? yourThunder : enemyThunder)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.03)
                                    .shadow(color: rectanglesOnGameField[row][col].yourThunder ? .red : .blue, radius: 3)
                                    .shadow(color: rectanglesOnGameField[row][col].yourThunder ? .red : .blue, radius: 3)
                                    .offset(x: rectanglesOnGameField[row][col].positionX * screenWidth/932, y: rectanglesOnGameField[row][col].positionY * screenWidth/932)
                            }
                        }
                        .onTapGesture {
                            if pvp {
                                makeStep(row: row, col: col)
                            } else {
                                makeStepWhenGameWithBot(row: row, col: col)
                            }
                        }
                    }
                }
            }
            .offset(y: screenWidth*0.03)
            HStack {
                Image("playerFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.21)
                    .shadow(color: .red, radius: shadowRadiusArray[2])
                    .shadow(color: .red, radius: shadowRadiusArray[2])
                    .overlay(
                        VStack {
                            Text(yourTurn ? "YOUR MOVE!" : "WAITING")
                                .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                                .foregroundColor(.white)
                            Text("PLAYER 1")
                                .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                                .foregroundColor(.white)
                            Spacer()
                            LazyVGrid(columns: Array(repeating: GridItem(.fixed(screenWidth*0.030)), count: 3), spacing: screenWidth*0.001) {
                                ForEach(0..<yourThunderCount, id: \.self) { id in
                                    Image(yourThunder)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.028)
                                        .padding(screenWidth*0.005)
                                }
                            }
                        }
                            .padding(.vertical, screenWidth*0.01)
                    )
                Spacer()
                    .frame(width: screenWidth*0.4)
                Image("playerFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.21)
                    .shadow(color: .red, radius: shadowRadiusArray[5])
                    .shadow(color: .red, radius: shadowRadiusArray[5])
                    .overlay(
                        VStack {
                            Text(!yourTurn ? "YOUR MOVE!" : "WAITING")
                                .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                                .foregroundColor(.white)
                            Text("PLAYER 2")
                                .font(Font.custom("PassionOne-Regular", size: screenWidth*0.03))
                                .foregroundColor(.white)
                            Spacer()
                            LazyVGrid(columns: Array(repeating: GridItem(.fixed(screenWidth*0.030)), count: 3), spacing: screenWidth*0.001) {
                                ForEach(0..<enemyThunderCount, id: \.self) { id in
                                    Image(enemyThunder)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.028)
                                        .padding(screenWidth*0.005)
                                }
                            }
                        }
                            .padding(.vertical, screenWidth*0.01)
                    )
            }
            .offset(y: screenWidth*0.03)
            Color.black.ignoresSafeArea().opacity(shadowOpacity)
            if showWinView {
                WinView(showWinView: $showWinView)
            }
            if showLoseView {
                LoseView(showLoseView: $showLoseView)
            }
            if showPause {
                PauseView(showPause: $showPause)
            }
        }
        
        .onChange(of: yourThunderCountOnGameField) { _ in
            if yourThunderCount + yourThunderCountOnGameField <= 2 {
                if pvp {
                    showLoseView = true
                } else {
                    showLoseView = true
                }
            }
        }
        
        .onChange(of: enemyThunderCountOnGameField) { _ in
            if enemyThunderCount + enemyThunderCountOnGameField <= 2 {
                if pvp {
                    showWinView = true
                } else {
                    showWinView = true
                }
            }
        }
        
        .onChange(of: yourThunderCount) { _ in
            if yourThunderCount <= 0 {
                yourStageNumber = 3
            }
        }
        
        .onChange(of: enemyThunderCount) { _ in
            if enemyThunderCount <= 0 {
                enemyStageNumber = 3
            }
        }
        
        .onChange(of: youCollectNewLine) { _ in
            if youCollectNewLine {
                yourStageNumber = 2
                if sound {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        SoundManager.instance.playSound(sound: "lineSound")
                        if vibration {
                            generateImpactFeedback(style: .heavy)
                        }
                    }
                }
                yourTurn = true
                print("onChange yourTurn = true")
                whenYouCollectLines()
                youCollectNewLine = false
            }
        }
        
        .onChange(of: enemyCollectNewLine) { _ in
            if enemyCollectNewLine {
                enemyStageNumber = 2
                if sound {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        SoundManager.instance.playSound(sound: "lineSound")
                        if vibration {
                            generateImpactFeedback(style: .heavy)
                        }
                    }
                }
                yourTurn = false
                print("onChange yourTurn = false")
                whenEnemyCollectLines()
                enemyCollectNewLine = false
            }
        }
        
        .onChange(of: yourStageNumber) { _ in
            print("yourStageNumber: \(yourStageNumber)")
            if yourStageNumber == 3 {
                clearPlate()
            }
        }
        
        .onChange(of: enemyStageNumber) { _ in
            print("enemyStageNumber: \(enemyStageNumber)")
            if !pvp && enemyStageNumber == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    updateBotStepsForStageTwo()
                    rectanglesOnGameField[randomeElement.row][randomeElement.col].haveThunder.toggle()
                    yourThunderCountOnGameField -= 1
                    checkLines()
                    yourTurn.toggle()
                    print("enemy step on Stage two")
                    if enemyThunderCount > 0 {
                        enemyStageNumber = 1
                        showPosibleMoves()
                    } else {
                        enemyStageNumber = 3
                        clearPlate()
                    }
                }
            }
            if enemyStageNumber == 3 {
                clearPlate()
            }
        }
        
        .onChange(of: playerOneWin) { _ in
            showShadow()
            if !playerOneWin {
                restartGame()
            }
        }
        
        .onChange(of: playerTwoWin) { _ in
            showShadow()
            if !playerTwoWin {
                restartGame()
            }
        }
        
        .onChange(of: showWinView) { _ in
            showShadow()
            if !showWinView {
                restartGame()
            }
        }
        
        .onChange(of: showLoseView) { _ in
            showShadow()
            if !showLoseView {
                restartGame()
            }
        }
        
        .onChange(of: showPause) { _ in
            showShadow()
        }
        
        .onChange(of: yourTurn) { _ in
//            cubeOnGameFieldAnimation()
//            calculateBallance()
        }
        
        .onAppear {
            SoundManager.instance.stopAllSounds()
            updateThunderSet()
        shadowAnimation()
            startTimerForRectangleStroke()
            showPosibleMoves()
            print("width: \(screenWidth)")
            print("height: \(screenHeight)")
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
    
    func updateThunderSet() {
        switch gameSet {
        case 2:
            yourThunder = "redCap2"
            enemyThunder = "blueCap2"
            linesOnGameField = Arrays.redLinesOnGameField
            enemyLinesOnGameField = Arrays.blueLinesOnGameField
        case 3:
            yourThunder = "redCap3"
            enemyThunder = "blueCap3"
            linesOnGameField = Arrays.redLinesOnGameField
            enemyLinesOnGameField = Arrays.blueLinesOnGameField
        case 4:
            yourThunder = "redCap4"
            enemyThunder = "blueCap4"
            linesOnGameField = Arrays.redLinesOnGameField
            enemyLinesOnGameField = Arrays.blueLinesOnGameField
        default:
            yourThunder = "redCap1"
            enemyThunder = "blueCap1"
            linesOnGameField = Arrays.redLinesOnGameField
            enemyLinesOnGameField = Arrays.blueLinesOnGameField
        }
    }
    
    func showShadow() {
        if playerOneWin || playerTwoWin || showWinView || showLoseView || showPause{
            withAnimation() {
                shadowOpacity = 0.7
            }
        } else {
            withAnimation() {
                shadowOpacity = 0
            }
        }
    }
    
    func updateBotStepsForStageOne() {
        botStepsCoordinates = rectanglesOnGameField
            .enumerated()
            .flatMap { rowIndex, row in
                row.enumerated().compactMap { colIndex, array in
                    (array.strokeActive) ? (rowIndex, colIndex) : nil
                }
            }
        randomeElement = botStepsCoordinates.randomElement() ?? (0,0)
    }
    
    func updateBotStepsForStageTwo() {
        botStepsCoordinates = rectanglesOnGameField
            .enumerated()
            .flatMap { rowIndex, row in
                row.enumerated().compactMap { colIndex, array in
                    (array.strokeActive && array.haveThunder) ? (rowIndex, colIndex) : nil
                }
            }
        randomeElement = botStepsCoordinates.randomElement() ?? (0,0)
    }
    
    func updateBotStepsForStageThree_1() {
        botStepsCoordinates = rectanglesOnGameField
            .enumerated()
            .flatMap { rowIndex, row in
                row.enumerated().compactMap { colIndex, array in
                    (!array.yourThunder && array.haveThunder) ? (rowIndex, colIndex) : nil
                }
            }
        repeat {
            clearPlate()
            randomeElement = botStepsCoordinates.randomElement() ?? (0,0)
            rectanglesOnGameField[randomeElement.row][randomeElement.col].isSelect = true
            findEnableStepsForSelectedRectangle()
        }
        while rectanglesOnGameField[randomeElement.row][randomeElement.col].strokeColor == Color.red
                if rectanglesOnGameField[randomeElement.row][randomeElement.col].strokeColor != Color.red {
            enemyCanMakeStep = true
        }
    }
    
    func updateBotStepsForStageThree_2() {
        botStepsCoordinates = rectanglesOnGameField
            .enumerated()
            .flatMap { rowIndex, row in
                row.enumerated().compactMap { colIndex, array in
                    (array.strokeActive && !array.haveThunder) ? (rowIndex, colIndex) : nil
                }
            }
        randomeElement = botStepsCoordinates.randomElement() ?? (0,0)
    }
    
    func makeStepWhenGameWithBot(row: Int, col: Int) {
        if yourStageNumber == 1 || enemyStageNumber == 1 {
            if yourTurn && !rectanglesOnGameField[row][col].haveThunder && yourStageNumber == 1{
                rectanglesOnGameField[row][col].haveThunder.toggle()
                rectanglesOnGameField[row][col].yourThunder = yourTurn
                if sound {
                    SoundManager.instance.playSound(sound: "tapSound1")
                }
                checkLines()
                yourTurn.toggle()
                print("step yourTurn.toggle()")
                showPosibleMoves()
                yourThunderCount -= 1
                yourThunderCountOnGameField += 1
                print("your step on Stage one")
            }
            if !yourTurn && enemyStageNumber == 1 && yourStageNumber != 2{
                updateBotStepsForStageOne()
                enemyWaitYourSteps = Timer.scheduledTimer(withTimeInterval: TimeInterval(2), repeats: true) { _ in
                    print("startStageTimer")
                    if !yourTurn && enemyStageNumber == 1 && yourStageNumber != 2{
                        rectanglesOnGameField[randomeElement.row][randomeElement.col].haveThunder.toggle()
                        rectanglesOnGameField[randomeElement.row][randomeElement.col].yourThunder = yourTurn
                        if sound {
                            SoundManager.instance.playSound(sound: "tapSound1")
                        }
                        checkLines()
                        yourTurn.toggle()
                        print("step yourTurn.toggle()")
                        showPosibleMoves()
                        enemyThunderCount -= 1
                        enemyThunderCountOnGameField += 1
                        print("enemy step on Stage one")
                        stopWaitingEnamyTimer()
                    }
                }
            }
        }
        if yourStageNumber == 2 || enemyStageNumber == 2 {
            if yourTurn && rectanglesOnGameField[row][col].strokeActive &&
                rectanglesOnGameField[row][col].haveThunder {
                rectanglesOnGameField[row][col].haveThunder.toggle()
                enemyThunderCountOnGameField -= 1
                checkLines()
                yourTurn.toggle()
                if sound {
                    SoundManager.instance.playSound(sound: "tapSound1")
                }
                print("your step on Stage two")
                if yourThunderCount > 0 {
                    yourStageNumber = 1
                    showPosibleMoves()
                } else {
                    yourStageNumber = 3
                    clearPlate()
                }
            }
            if !yourTurn && enemyStageNumber == 2{
                print("botSageTwo")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    updateBotStepsForStageTwo()
                    rectanglesOnGameField[randomeElement.row][randomeElement.col].haveThunder.toggle()
                    yourThunderCountOnGameField -= 1
                    checkLines()
                    if sound {
                        SoundManager.instance.playSound(sound: "tapSound1")
                    }
                    yourTurn.toggle()
                    print("enemy step on Stage two")
                    if enemyThunderCount > 0 {
                        enemyStageNumber = 1
                        showPosibleMoves()
                    } else {
                        enemyStageNumber = 3
                        clearPlate()
                    }
                }
            }
        }
        if yourStageNumber == 3 || enemyStageNumber == 3 {
            if yourTurn {
                if rectanglesOnGameField[row][col].yourThunder &&
                    rectanglesOnGameField[row][col].haveThunder {
                    clearPlate()
                    rectanglesOnGameField[row][col].isSelect = true
                    findEnableStepsForSelectedRectangle()
                    rectangleStroWidth = 7
                }
                if  !rectanglesOnGameField[row][col].haveThunder && rectanglesOnGameField[row][col].strokeActive {
                    rectanglesOnGameField[row][col].haveThunder.toggle()
                    rectanglesOnGameField[row][col].yourThunder = yourTurn
                    rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].haveThunder.toggle()
                    clearPlate()
                    checkLines()
                    if sound {
                        SoundManager.instance.playSound(sound: "tapSound1")
                    }
                    yourTurn.toggle()
                    stopWaitingEnamyTimer()
                }
            }
            if !yourTurn && enemyStageNumber == 3 && !showWinView{
                stopWaitingEnamyTimer()
                enemyWaitYourSteps = Timer.scheduledTimer(withTimeInterval: TimeInterval(2.5), repeats: true) { _ in
                    print("stage3TimerStart")
                    if !yourTurn {
                        stopWaitingEnamyTimer()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            updateBotStepsForStageThree_1()
                            rectangleStroWidth = 7
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            if enemyCanMakeStep {
                                updateBotStepsForStageThree_2()
                                rectanglesOnGameField[randomeElement.row][randomeElement.col].haveThunder.toggle()
                                rectanglesOnGameField[randomeElement.row][randomeElement.col].yourThunder = yourTurn
                                rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].haveThunder.toggle()
                                clearPlate()
                                checkLines()
                                if sound {
                                    SoundManager.instance.playSound(sound: "tapSound1")
                                }
                                yourTurn.toggle()
                                print("yourTurn Toggle by enemy")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeStep(row: Int, col: Int) {
        if yourStageNumber == 1 || enemyStageNumber == 1 {
            if yourTurn && !rectanglesOnGameField[row][col].haveThunder &&
                yourStageNumber == 1{
                if sound {
                    SoundManager.instance.playSound(sound: "tapSound1")
                }
                rectanglesOnGameField[row][col].haveThunder.toggle()
                rectanglesOnGameField[row][col].yourThunder = yourTurn
                checkLines()
                yourTurn.toggle()
                showPosibleMoves()
                yourThunderCount -= 1
                yourThunderCountOnGameField += 1
                print("your step on Stage one")
            }
            if !yourTurn && !rectanglesOnGameField[row][col].haveThunder && enemyStageNumber == 1{
                if sound {
                    SoundManager.instance.playSound(sound: "tapSound1")
                }
                rectanglesOnGameField[row][col].haveThunder.toggle()
                rectanglesOnGameField[row][col].yourThunder = yourTurn
                checkLines()
                yourTurn.toggle()
                showPosibleMoves()
                enemyThunderCount -= 1
                enemyThunderCountOnGameField += 1
                print("enemy step on Stage one")
            }
        }
        if yourStageNumber == 2 || enemyStageNumber == 2 {
            if yourTurn && rectanglesOnGameField[row][col].strokeActive &&
                rectanglesOnGameField[row][col].haveThunder {
                rectanglesOnGameField[row][col].haveThunder.toggle()
                enemyThunderCountOnGameField -= 1
                if sound {
                    SoundManager.instance.playSound(sound: "tapSound1")
                }
                checkLines()
                yourTurn.toggle()
                print("your step on Stage two")
                if yourThunderCount > 0 {
                    yourStageNumber = 1
                    showPosibleMoves()
                } else {
                    yourStageNumber = 3
                    clearPlate()
                }
            } else if !yourTurn && rectanglesOnGameField[row][col].strokeActive &&
                        rectanglesOnGameField[row][col].haveThunder {
                rectanglesOnGameField[row][col].haveThunder.toggle()
                yourThunderCountOnGameField -= 1
                if sound {
                    SoundManager.instance.playSound(sound: "tapSound1")
                }
                checkLines()
                yourTurn.toggle()
                print("enemy step on Stage two")
                if enemyThunderCount > 0 {
                    enemyStageNumber = 1
                    showPosibleMoves()
                } else {
                    enemyStageNumber = 3
                    clearPlate()
                }
            }
        }
        if yourStageNumber == 3 || enemyStageNumber == 3 {
            if yourTurn {
                if rectanglesOnGameField[row][col].yourThunder &&
                    rectanglesOnGameField[row][col].haveThunder {
                    clearPlate()
                    rectanglesOnGameField[row][col].isSelect = true
                    findEnableStepsForSelectedRectangle()
                    rectangleStroWidth = 7
                }
                if  !rectanglesOnGameField[row][col].haveThunder && rectanglesOnGameField[row][col].strokeActive {
                    rectanglesOnGameField[row][col].haveThunder.toggle()
                    rectanglesOnGameField[row][col].yourThunder = yourTurn
                    rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].haveThunder.toggle()
                    clearPlate()
                    checkLines()
                    if sound {
                        SoundManager.instance.playSound(sound: "tapSound1")
                    }
                    yourTurn.toggle()
                }
            }
            else if !yourTurn {
                if !rectanglesOnGameField[row][col].yourThunder &&
                    rectanglesOnGameField[row][col].haveThunder {
                    clearPlate()
                    rectanglesOnGameField[row][col].isSelect = true
                    findEnableStepsForSelectedRectangle()
                    rectangleStroWidth = 7
                }
                if  !rectanglesOnGameField[row][col].haveThunder && rectanglesOnGameField[row][col].strokeActive {
                    rectanglesOnGameField[row][col].haveThunder.toggle()
                    rectanglesOnGameField[row][col].yourThunder = yourTurn
                    rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].haveThunder.toggle()
                    clearPlate()
                    checkLines()
                    if sound {
                        SoundManager.instance.playSound(sound: "tapSound1")
                    }
                    yourTurn.toggle()
                }
            }
        }
    }
    
    func restartGame() {
        yourTurn = true
        yourStageNumber = 1
        enemyStageNumber = 1
        yourThunderCount = 9
        enemyThunderCount = 9
        yourThunderCountOnGameField = 0
        enemyThunderCountOnGameField = 0
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                rectanglesOnGameField[i][j].haveThunder = false
                rectanglesOnGameField[i][j].lineCollect = false
                rectanglesOnGameField[i][j].strokeActive = false
                rectanglesOnGameField[i][j].isSelect = false
            }
        }
        for i in 0..<linesOnGameField.count {
            for j in 0..<linesOnGameField[i].count {
                linesOnGameField[i][j].lineActive = false
            }
        }
        stopTimer()
        startTimerForRectangleStroke()
        showPosibleMoves()
    }
    
    func clearPlate() {
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                rectanglesOnGameField[i][j].strokeActive = false
                rectanglesOnGameField[i][j].isSelect = false
            }
        }
    }
    
    func findEnableStepsForSelectedRectangle() {
        var enableStpsCount = 0
        findSelectedRectangleCoordinates()
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                if ((
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) >= 22 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) <= 26 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) <= 26 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) >= 22
                    )
                    ||
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) >= 43 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) <= 47 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) <= 108 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) >= 104
                    )
                    ||
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) >= 104 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) <= 108 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) <= 47 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) >= 43
                    )
                    ||
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) >= 32 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) <= 36 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) <= 84 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) >= 80
                    )
                    ||
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) >= 80 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) <= 84 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) <= 36 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) >= 32
                    )
                    ||
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) >= 22 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) <= 26 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) <= 60 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) >= 56
                    )
                    ||
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) >= 56 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) <= 60 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) <= 26 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) >= 22
                    )
                    ||
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) >= 34 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) <= 38 &&
                     (rectanglesOnGameField[i][j].positionY == rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY))
                    ||
                    
                    (abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) >= 34 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) <= 38 &&
                     (rectanglesOnGameField[i][j].positionX == rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX))
                    ||
                    
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) > 58 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) < 64 &&
                     (rectanglesOnGameField[i][j].positionY == rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY))
                    ||
                    
                    (abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) > 58 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) < 64 &&
                     (rectanglesOnGameField[i][j].positionX == rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX))
                    ||
                    
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) > 95 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) < 101 &&
                     (rectanglesOnGameField[i][j].positionY == rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY))
                    ||
                    
                    (abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) > 95 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) < 101 &&
                     (rectanglesOnGameField[i][j].positionX == rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX))
                    ||
                    
                    (abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) > 131 &&
                     abs(rectanglesOnGameField[i][j].positionX - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX) < 138 &&
                     (rectanglesOnGameField[i][j].positionY == rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY))
                    ||
                    
                    (abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) > 131 &&
                     abs(rectanglesOnGameField[i][j].positionY - rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionY) < 138 &&
                     (rectanglesOnGameField[i][j].positionX == rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].positionX))
                ))
                    &&
                    !rectanglesOnGameField[i][j].haveThunder
                {
                    rectanglesOnGameField[i][j].strokeColor = Color.white
                    rectanglesOnGameField[i][j].strokeActive = true
                    enableStpsCount += 1
                }
            }
        }
        print(enableStpsCount)
        if enableStpsCount == 0 {
            rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].strokeActive = true
            rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].strokeColor = Color.red
            if !yourTurn {
                print("ALARM!!!!")
            }
        } else {
            rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].strokeActive = true
            rectanglesOnGameField[selectedRectangleRow][selectedRectangleCol].strokeColor = Color("canMoveColor")
        }
    }
    
    func findSelectedRectangleCoordinates() {
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                if rectanglesOnGameField[i][j].isSelect {
                    selectedRectangleRow = i
                    selectedRectangleCol = j
                }
            }
        }
    }
    
    func arrayContainsSelectedRectangleByYou() -> Bool {
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                if rectanglesOnGameField[i][j].isSelect {
                    return true
                }
            }
        }
        return false
    }
    
    func whenYouCollectLines() {
        var elementWithSrokeCount = 0
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                if rectanglesOnGameField[i][j].haveThunder && !rectanglesOnGameField[i][j].yourThunder && !rectanglesOnGameField[i][j].lineCollect{
                    rectanglesOnGameField[i][j].strokeActive = true
                    rectanglesOnGameField[i][j].strokeColor = Color.blue
                } else {
                    rectanglesOnGameField[i][j].strokeActive = false
                }
            }
        }
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                if rectanglesOnGameField[i][j].strokeActive {
                    elementWithSrokeCount += 1
                }
            }
        }
        if elementWithSrokeCount == 0 {
            for i in 0..<rectanglesOnGameField.count {
                for j in 0..<rectanglesOnGameField[i].count {
                    if rectanglesOnGameField[i][j].haveThunder && !rectanglesOnGameField[i][j].yourThunder {
                        rectanglesOnGameField[i][j].strokeActive = true
                        rectanglesOnGameField[i][j].strokeColor = Color.blue
                    }
                }
            }
        }
    }
    
    func whenEnemyCollectLines() {
        var elementWithSrokeCount = 0
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                if rectanglesOnGameField[i][j].haveThunder && rectanglesOnGameField[i][j].yourThunder && !rectanglesOnGameField[i][j].lineCollect{
                    rectanglesOnGameField[i][j].strokeActive = true
                    rectanglesOnGameField[i][j].strokeColor = Color.blue
                } else {
                    rectanglesOnGameField[i][j].strokeActive = false
                }
            }
        }
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                if rectanglesOnGameField[i][j].strokeActive {
                    elementWithSrokeCount += 1
                }
            }
        }
        if elementWithSrokeCount == 0 {
            for i in 0..<rectanglesOnGameField.count {
                for j in 0..<rectanglesOnGameField[i].count {
                    if rectanglesOnGameField[i][j].haveThunder && rectanglesOnGameField[i][j].yourThunder {
                        rectanglesOnGameField[i][j].strokeActive = true
                        rectanglesOnGameField[i][j].strokeColor = Color.blue
                    }
                }
            }
        }
    }
    
    func startTimerForRectangleStroke() {
        withAnimation(Animation.easeOut(duration: 0.5)) {
            rectangleStroWidth = 3
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeOut(duration: 0.7)) {
                rectangleStroWidth = 0
            }
        }
        rectangleStrokeWidthTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(2), repeats: true) { _ in
            withAnimation(Animation.easeOut(duration: 0.5)) {
                rectangleStroWidth = 3
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(Animation.easeOut(duration: 0.7)) {
                    rectangleStroWidth = 0
                }
            }
        }
    }
    
    func stopWaitingEnamyTimer() {
        enemyWaitYourSteps?.invalidate()
        enemyWaitYourSteps = nil
    }
    
    func stopTimer() {
        rectangleStrokeWidthTimer?.invalidate()
        rectangleStrokeWidthTimer = nil
    }
    
    func showPosibleMoves() {
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                if !rectanglesOnGameField[i][j].haveThunder {
                    rectanglesOnGameField[i][j].strokeActive = true
                    rectanglesOnGameField[i][j].strokeColor = .white
                } else {
                    rectanglesOnGameField[i][j].strokeActive = false
                }
            }
        }
    }
    
    func checkLines() {
        for i in 0..<rectanglesOnGameField.count {
            for j in 0..<rectanglesOnGameField[i].count {
                rectanglesOnGameField[i][j].lineCollect = false
            }
        }
        checkLineMethod(name: "checkLeftVerticalLine1", rx1: 0, ry1: 0, rx2: 3, ry2: 0, rx3: 7, ry3: 0, lx1: 0, ly1: 0)
        checkLineMethod(name: "checkLeftVerticalLine2", rx1: 1, ry1: 0, rx2: 3, ry2: 1, rx3: 6, ry3: 0, lx1: 0, ly1: 1)
        checkLineMethod(name: "checkLeftVerticalLine3", rx1: 2, ry1: 0, rx2: 3, ry2: 2, rx3: 5, ry3: 0, lx1: 0, ly1: 2)
        checkLineMethod(name: "checkRightVerticalLine1", rx1: 2, ry1: 2, rx2: 4, ry2: 0, rx3: 5, ry3: 2, lx1: 1, ly1: 2)
        checkLineMethod(name: "checkRightVerticalLine2", rx1: 1, ry1: 2, rx2: 4, ry2: 1, rx3: 6, ry3: 2, lx1: 1, ly1: 1)
        checkLineMethod(name: "checkRightVerticalLine3", rx1: 0, ry1: 2, rx2: 4, ry2: 2, rx3: 7, ry3: 2, lx1: 1, ly1: 0)
        checkLineMethod(name: "checkMiddleTopLine", rx1: 0, ry1: 1, rx2: 1, ry2: 1, rx3: 2, ry3: 1, lx1: 2, ly1: 0)
        checkLineMethod(name: "checkMiddleBottomLine", rx1: 5, ry1: 1, rx2: 6, ry2: 1, rx3: 7, ry3: 1, lx1: 2, ly1: 1)
        checkLineMethod(name: "checkTopHorizontalLine1", rx1: 0, ry1: 0, rx2: 0, ry2: 1, rx3: 0, ry3: 2, lx1: 3, ly1: 0)
        checkLineMethod(name: "checkTopHorizontalLine2", rx1: 1, ry1: 0, rx2: 1, ry2: 1, rx3: 1, ry3: 2, lx1: 3, ly1: 1)
        checkLineMethod(name: "checkTopHorizontalLine3", rx1: 2, ry1: 0, rx2: 2, ry2: 1, rx3: 2, ry3: 2, lx1: 3, ly1: 2)
        checkLineMethod(name: "checkBottomHorizontalLine1", rx1: 5, ry1: 0, rx2: 5, ry2: 1, rx3: 5, ry3: 2, lx1: 4, ly1: 2)
        checkLineMethod(name: "checkBottomHorizontalLine2", rx1: 6, ry1: 0, rx2: 6, ry2: 1, rx3: 6, ry3: 2, lx1: 4, ly1: 1)
        checkLineMethod(name: "checkBottomHorizontalLine3", rx1: 7, ry1: 0, rx2: 7, ry2: 1, rx3: 7, ry3: 2, lx1: 4, ly1: 0)
        checkLineMethod(name: "checkMiddleLeftLine", rx1: 3, ry1: 0, rx2: 3, ry2: 1, rx3: 3, ry3: 2, lx1: 5, ly1: 0)
        checkLineMethod(name: "checkMiddleRightLine", rx1: 4, ry1: 0, rx2: 4, ry2: 1, rx3: 4, ry3: 2, lx1: 5, ly1: 1)
        checkLineMethod(name: "checkDiagonal1", rx1: 0, ry1: 0, rx2: 1, ry2: 0, rx3: 2, ry3: 0, lx1: 7, ly1: 0)
        checkLineMethod(name: "checkDiagonal2", rx1: 0, ry1: 2, rx2: 1, ry2: 2, rx3: 2, ry3: 2, lx1: 7, ly1: 1)
        checkLineMethod(name: "checkDiagonal3", rx1: 7, ry1: 0, rx2: 6, ry2: 0, rx3: 5, ry3: 0, lx1: 6, ly1: 0)
        checkLineMethod(name: "checkDiagonal4", rx1: 5, ry1: 2, rx2: 6, ry2: 2, rx3: 7, ry3: 2, lx1: 6, ly1: 1)
    }
    
    func checkLineMethod(name: String, rx1: Int, ry1: Int, rx2: Int, ry2: Int, rx3: Int, ry3: Int, lx1: Int, ly1: Int) {
        if rectanglesOnGameField[rx1][ry1].haveThunder &&
            rectanglesOnGameField[rx2][ry2].haveThunder &&
            rectanglesOnGameField[rx3][ry3].haveThunder &&
            rectanglesOnGameField[rx1][ry1].yourThunder == rectanglesOnGameField[rx2][ry2].yourThunder &&
            rectanglesOnGameField[rx1][ry1].yourThunder == rectanglesOnGameField[rx3][ry3].yourThunder {
            if rectanglesOnGameField[rx1][ry1].yourThunder {
                linesOnGameField[lx1][ly1].lineActive = true
                rectanglesOnGameField[rx1][ry1].lineCollect = true
                rectanglesOnGameField[rx2][ry2].lineCollect = true
                rectanglesOnGameField[rx3][ry3].lineCollect = true
                if !yourLineCoordinatesArray.contains(where: {$0 == (lx1, ly1)}) {
                    yourLineCoordinatesArray.append((lx1, ly1))
                }
                
            } else {
                enemyLinesOnGameField[lx1][ly1].lineActive = true
                rectanglesOnGameField[rx1][ry1].lineCollect = true
                rectanglesOnGameField[rx2][ry2].lineCollect = true
                rectanglesOnGameField[rx3][ry3].lineCollect = true
                if !enemyLineCoordinatesArray.contains(where: {$0 == (lx1, ly1)}) {
                    enemyLineCoordinatesArray.append((lx1, ly1))
                }
                
            }
        } else {
            linesOnGameField[lx1][ly1].lineActive = false
            enemyLinesOnGameField[lx1][ly1].lineActive = false
            if yourLineCoordinatesArray.contains(where: {$0 == (lx1, ly1)}) {
                yourLineCoordinatesArray.removeAll(where: {$0 == (lx1, ly1)})
            }
            if enemyLineCoordinatesArray.contains(where: {$0 == (lx1, ly1)}) {
                enemyLineCoordinatesArray.removeAll(where: {$0 == (lx1, ly1)})
            }
        }
    }
    
    func generateImpactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        if vibration {
            generator.prepare()
            generator.impactOccurred()
        }
    }
    
}

#Preview {
    Game()
}
