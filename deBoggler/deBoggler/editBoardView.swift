//
//  editBoardView.swift
//  deBoggler
//
//  Created by Andrew Madigan on 12/29/22.
//

import SwiftUI
import Vision
import TabularData

struct editBoardView: View {
    
    var imageData: imageData
    
    @State private var nRows = 5
    @State var board = [String():String()]
    
    var body: some View {
//        NavigationView {
        
            VStack {
                HStack {
                    Button("3x3", action: {
                        self.nRows = 3
                    }).padding()
                        .background(Color(.blue))
                        .foregroundColor(Color(.white))
                        .clipShape(Capsule())
                    Button("4x4", action: {
                        self.nRows = 4
                    }).padding()
                        .background(Color(.blue))
                        .foregroundColor(Color(.white))
                        .clipShape(Capsule())
                    Button("5x5", action: {
                        self.nRows = 5
                    }).padding()
                        .background(Color(.blue))
                        .foregroundColor(Color(.white))
                        .clipShape(Capsule())
                    Button("6x6", action: {
                        self.nRows = 6
                    }).padding()
                        .background(Color(.blue))
                        .foregroundColor(Color(.white))
                        .clipShape(Capsule())
                }
                Spacer()
                VStack {
                    ForEach(1...nRows, id: \.self) {row in
                        HStack {
                            Spacer()
                            ForEach(1...nRows, id: \.self) {column in
                                let inputText = Binding(
                                    get: { return self.board["\(row), \(column)"] ?? ""},
                                    set: { (newValue) in return self.board["\(row), \(column)"] = newValue}
                                  )
                                TextField("", text: inputText)
                                    .onChange(of: inputText.wrappedValue) {inputText in
                                    self.board["\(row), \(column)"] = inputText
                                    }
                                    .font(Font.system(size:48, weight: .bold).monospaced())
                                    .multilineTextAlignment(.center)
                                    .textFieldStyle(.roundedBorder)
                                    .fixedSize(horizontal: true, vertical: true)
                                    .aspectRatio(1, contentMode: .fill)
                                    .border(Color(.white))
                            }
                            Spacer()
                        }
                    }
                }
                Spacer()
                let _ = print(fillBoardWithRecognizedText(imageData: imageData))
                NavigationLink(destination: findWordsView(filledBoard: self.board, nRows: self.nRows, foundWords: [String(): String()])) {
                    Text("deBoggle!")
                        .padding()
                        .background(Color(.blue))
                        .foregroundColor(Color(.white))
                        .clipShape(Capsule())
                }
            }.onAppear {
                self.board = fillBoardWithRecognizedText(imageData: imageData)
            }
        
        
    }

    func fillBoardWithRecognizedText(imageData: imageData) -> [String:String] {
        
        var _board: [String:String] = [:]
        
    // identify the max/min points of the board
        let rightMinX = imageData.textBoundingRectsRight.map {$0.rect.minX}.min() ?? 9999
        let leftMinX = 1 - (imageData.textBoundingRectsLeft.map {$0.rect.maxX}.max() ?? 9999)
        let upMinX = imageData.textBoundingRectsUp.map {$0.rect.minY}.min() ?? 9999
        let downMinX = 1 - (imageData.textBoundingRectsDown.map {$0.rect.maxY}.max() ?? 9999)
        let minX = [rightMinX, leftMinX, upMinX, downMinX].min() ?? 9999
        let rightMaxX = imageData.textBoundingRectsRight.map {$0.rect.maxX}.max() ?? 9999
        let leftMaxX = 1 - (imageData.textBoundingRectsLeft.map {$0.rect.minX}.min() ?? 9999)
        let upMaxX = imageData.textBoundingRectsUp.map {$0.rect.maxY}.max() ?? 9999
        let downMaxX = 1 - (imageData.textBoundingRectsDown.map {$0.rect.minY}.min() ?? 9999)
        let maxX = [rightMaxX, leftMaxX, upMaxX, downMaxX].max() ?? 9999
        let rightMinY = imageData.textBoundingRectsRight.map {$0.rect.minY}.min() ?? 9999
        let leftMinY = 1 - (imageData.textBoundingRectsLeft.map {$0.rect.maxY}.max() ?? 9999)
        let upMinY = 1 - (imageData.textBoundingRectsUp.map {$0.rect.maxX}.max() ?? 9999)
        let downMinY = imageData.textBoundingRectsDown.map {$0.rect.minX}.min() ?? 9999
        let minY = [rightMinY, leftMinY, upMinY, downMinY].min() ?? 9999
        let rightMaxY = imageData.textBoundingRectsRight.map {$0.rect.maxY}.max() ?? 9999
        let leftMaxY = 1 - (imageData.textBoundingRectsLeft.map {$0.rect.minY}.min() ?? 9999)
        let upMaxY = 1 - (imageData.textBoundingRectsUp.map {$0.rect.minX}.min() ?? 9999)
        let downMaxY = imageData.textBoundingRectsDown.map {$0.rect.maxX}.max() ?? 9999
        let maxY = [rightMaxY, leftMaxY, upMaxY, downMaxY].max() ?? 9999
        
        let spaceWidth = (maxX - minX) / CGFloat(self.nRows)
        let spaceHeight = (maxY - minY) / CGFloat(self.nRows)
    
    // take observation coordinates and map to row/column number: floor ((obs - minX) / spaceWidth * nRows)
        let _ = print("space width: \(spaceWidth)\nspace height: \(spaceHeight)")
        
        //right
        var rightBoardCoords: [(Int, Int)] = []
        for obs in imageData.textBoundingRectsRight {
            let _col = floor((obs.rect.midX - minX) / spaceWidth)
            let _row = floor((obs.rect.midY - minY) / spaceHeight)
            rightBoardCoords.append((Int(_row) + 1, Int(_col) + 1))
        }
        
        //left
        var leftBoardCoords: [(Int, Int)] = []
        for obs in imageData.textBoundingRectsLeft {
            let _col = floor((1 - obs.rect.midX - minX) / spaceWidth)
            let _row = floor((1 - obs.rect.midY - minY) / spaceHeight)
            leftBoardCoords.append((Int(_row) + 1, Int(_col) + 1))
        }
        
        //up
        var upBoardCoords: [(Int, Int)] = []
        for obs in imageData.textBoundingRectsUp {
            let _col = floor((obs.rect.midY - minX) / spaceWidth)
            let _row = floor((1 - obs.rect.midX - minY) / spaceHeight)
            upBoardCoords.append((Int(_row) + 1, Int(_col) + 1))
        }
        
        //down
        var downBoardCoords: [(Int, Int)] = []
        for obs in imageData.textBoundingRectsDown {
            let _col = floor((1 - obs.rect.midY - minX) / spaceWidth)
            let _row = floor((obs.rect.midX - minY) / spaceHeight)
            downBoardCoords.append((Int(_row) + 1, Int(_col) + 1))
        }
    // assign one letter per identified space
        for row in 1...nRows {
            for col in 1...nRows {
                // find indices of matching instances in each direction's array
                let rightMatchingIdx = rightBoardCoords.indices.filter {rightBoardCoords[$0] == (row, col)}
                let leftMatchingIdx = leftBoardCoords.indices.filter {leftBoardCoords[$0] == (row, col)}
                let upMatchingIdx = upBoardCoords.indices.filter {upBoardCoords[$0] == (row, col)}
                let downMatchingIdx = downBoardCoords.indices.filter {downBoardCoords[$0] == (row, col)}
                
                // find text and corresponding scores
                var rightMatchingTxt = "•"
                var rightMatchingScore = Float(0.0)
                for idx in rightMatchingIdx {
                    
                    let score = Float(imageData.recognizedStringsConfidenceRight[idx])
                    if score > rightMatchingScore {
                        rightMatchingTxt = imageData.recognizedStringsRight[idx]
                        rightMatchingScore = score
                    }
                }
                var leftMatchingTxt = "•"
                var leftMatchingScore = Float(0.0)
                for idx in leftMatchingIdx {
                    
                    let score = Float(imageData.recognizedStringsConfidenceLeft[idx])
                    if score > leftMatchingScore {
                        leftMatchingTxt = imageData.recognizedStringsLeft[idx]
                        leftMatchingScore = score
                    }
                }
                var upMatchingTxt = "•"
                var upMatchingScore = Float(0.0)
                for idx in upMatchingIdx {
                    
                    let score = Float(imageData.recognizedStringsConfidenceUp[idx])
                    if score > upMatchingScore {
                        upMatchingTxt = imageData.recognizedStringsUp[idx]
                        upMatchingScore = score
                    }
                }
                var downMatchingTxt = "•"
                var downMatchingScore = Float(0.0)
                for idx in downMatchingIdx {
                    
                    let score = Float(imageData.recognizedStringsConfidenceDown[idx])
                    if score > downMatchingScore {
                        downMatchingTxt = imageData.recognizedStringsDown[idx]
                        downMatchingScore = score
                    }
                }
                
                // select the text with the greatest score
                var maxScore = Float(0.0)
                var bestGuess = "•"
                var matchingIdx = 99
                for (idx, score) in [rightMatchingScore, leftMatchingScore, upMatchingScore, downMatchingScore].enumerated() {
                    if score > maxScore {
                        maxScore = score
                        matchingIdx = idx
                    }
                if matchingIdx != 99 {
                    bestGuess = [rightMatchingTxt, leftMatchingTxt, upMatchingTxt, downMatchingTxt][matchingIdx]
                    }
                }
                
                bestGuess = correctCharacter(char: bestGuess)
                _board["\(nRows - row + 1), \(col)"] = bestGuess
                
            }
        
        }
        
            // eliminate any observations with gibberish letters
        
            // for each space
        
                // (if there are any observations) choose the observation with the highest score
        
                // update _board
            
        return _board
        
    }
    
    func correctCharacter(char: String) -> String {
        
        if char == "3" {return "E"}
        else if char == "4" {return "A"}
        else if char == "Ш" {return "E"}
        else if char == "Q." {return "Qu"}
        else if char == "5" {return "S"}
        else if char == "<" {return "Y"}
        else if char == "z" {return "N"}
        else if char == "э" {return "C"}
        else if char == "-" {return "I"}
        else if char == "1" {return "T"}
        else if char == "8" {return "B"}
        else if char == "a" {return "B"}
        else if char == "I" {return "H"}
        else if char == "7" {return "L"}
        else if char == "d" {return "P"}
        else if char == "r" {return "L"}
        else {return char}
    }
    
    
}

