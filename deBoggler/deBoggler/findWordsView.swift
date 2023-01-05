//
//  findWordsView.swift
//  deBoggler
//
//  Created by Andrew Madigan on 12/31/22.
//

import SwiftUI

struct findWordsView: View {
    var filledBoard: [String:String]
    var nRows: Int
    @State var foundWords = [String:String]()
    
    var body: some View {
        VStack {
            Text("Found \(foundWords.count - 1) words...")
                .padding()
                .background(Color(.blue))
                .foregroundColor(Color(.white))
                .clipShape(Capsule())
                List {
                    let keys = self.foundWords.map{$0.key}
                    ForEach(1...keys.count, id: \.self) { idx in
                        VStack{
                            if keys[idx - 1] != "" {
                                Text(keys[idx - 1])
                                    .font(Font.headline.weight(.bold))
                                    .foregroundColor(Color(.white))
                                Text(self.foundWords[keys[idx - 1]] ?? "")
                                    .font(Font.headline.weight(.ultraLight))
                                    .foregroundColor(Color(.white))
                            }
                        }
                        
                    }
                }
            Spacer()
            
        }
        .onAppear { findWords()}
//        let _ = print("(0, 0) != (nil, nil) -->\((0, 0) != (Int(), Int()))\n(nil, nil) != (nil, nil) -->\((Int(), Int()) != (nil, nil))")


    }
    
    
    // initiates search originating from each cell
    func findWords() {
        
        for _row in 1...self.nRows {
            for _col in 1...self.nRows {
//                print("reached '\(filledBoard["\(_row), \(_col)"] ?? "")', row: \(_row), column: \(_col)")
                // starting at each space, update foundWords with all hits
                let result = recursiveSearch(startingPoint: (_row, _col),
                                word: "",
                alreadyVisited: [],
                letterDictionary: allWords[(filledBoard["\(_row), \(_col)"] ?? "").uppercased()] ?? "")
                
                for (key, val) in result {
                    self.foundWords[key] = val
                    print("found '\(key)': '\(val)'")
                }
            }
        }
//        print("found words: \(foundWords)")
    }
    
    // main heavy lifting
    func recursiveSearch(startingPoint: (Int, Int), word: String, alreadyVisited: [(Int, Int)], letterDictionary: String) -> [String:String]   {
        
        var letter = self.filledBoard["\(startingPoint.0), \(startingPoint.1)"]
        var found = [String:String]()
        var word = word
        var alreadyVisited = alreadyVisited
            
        alreadyVisited.append(startingPoint)
        
        
        word = word + (letter ?? "")
//        print("word: \(word), starting point: \(startingPoint)")
        
        var letterDictionary = letterDictionary// allWords[word.prefix(1).uppercased()] ?? ""
        
        
        // if word doesn't exist, return (pass for first letters)
        if (word.count > 1) && !regexWordExists(word: word, text: letterDictionary) {
            
//            print("searched: \(word)")
//            print("letterdictionary: \(letterDictionary)")
            return found
            
        }
        
        letterDictionary = regexShrinkDict(word: word, text: letterDictionary)
        
        // if word is a whole word, add it and its definition to return dict
        if regexIsWholeWord(word: word, text: letterDictionary) {
            let definitions = regexGetDefinition(word: word, text: letterDictionary)
            found[word] = definitions.first
        }
        
        // then, check: up, up+right, up+left, down, down+right, down+left, left, right
        
        // up
        var proposedSpace = up(coords: startingPoint)
        if (proposedSpace.0 <= nRows) && (proposedSpace.1 <= nRows) && !alreadyVisited.contains(where: {$0==proposedSpace})  {
//            print("searching up")
            let _found = recursiveSearch(startingPoint: proposedSpace,
                                         word: word,
                                         alreadyVisited: alreadyVisited,
                                         letterDictionary: letterDictionary)
            for (_word, _definition) in _found {
                found[_word] = _definition
            }
        }
        // up+left
        proposedSpace = left(coords: up(coords: startingPoint))
        if (proposedSpace.0 <= nRows) && (proposedSpace.1 <= nRows) && !alreadyVisited.contains(where: {$0==proposedSpace})  {
//            print("searching up+left")
            let _found = recursiveSearch(startingPoint: proposedSpace,
                                         word: word,
                                         alreadyVisited: alreadyVisited,
                                         letterDictionary: letterDictionary)
            for (_word, _definition) in _found {
                found[_word] = _definition
            }
        }
        // up+right
        proposedSpace = right(coords: up(coords: startingPoint))
        if (proposedSpace.0 <= nRows) && (proposedSpace.1 <= nRows) && !alreadyVisited.contains(where: {$0==proposedSpace})  {
//            print("searching up+right")
            let _found = recursiveSearch(startingPoint: proposedSpace,
                                         word: word,
                                         alreadyVisited: alreadyVisited,
                                         letterDictionary: letterDictionary)
            for (_word, _definition) in _found {
                found[_word] = _definition
            }
        }
        // down
        proposedSpace = down(coords: startingPoint)
        if (proposedSpace.0 <= nRows) && (proposedSpace.1 <= nRows) && !alreadyVisited.contains(where: {$0==proposedSpace})  {
//            print("searching down")
            let _found = recursiveSearch(startingPoint: proposedSpace,
                                         word: word,
                                         alreadyVisited: alreadyVisited,
                                         letterDictionary: letterDictionary)
            for (_word, _definition) in _found {
                found[_word] = _definition
            }
        }
        // down+left
        proposedSpace = left(coords: down(coords: startingPoint))
        if (proposedSpace.0 <= nRows) && (proposedSpace.1 <= nRows) && !alreadyVisited.contains(where: {$0==proposedSpace})  {
//            print("searching down+left")
            let _found = recursiveSearch(startingPoint: proposedSpace,
                                         word: word,
                                         alreadyVisited: alreadyVisited,
                                         letterDictionary: letterDictionary)
            for (_word, _definition) in _found {
                found[_word] = _definition
            }
        }
        // down+right
        proposedSpace = right(coords: down(coords: startingPoint))
        if (proposedSpace.0 <= nRows) && (proposedSpace.1 <= nRows) && !alreadyVisited.contains(where: {$0==proposedSpace})  {
//            print("searching down+right")
            let _found = recursiveSearch(startingPoint: proposedSpace,
                                         word: word,
                                         alreadyVisited: alreadyVisited,
                                         letterDictionary: letterDictionary)
            for (_word, _definition) in _found {
                found[_word] = _definition
            }
        }
        // left
        proposedSpace = left(coords: startingPoint)
        if (proposedSpace.0 <= nRows) && (proposedSpace.1 <= nRows) && !alreadyVisited.contains(where: {$0==proposedSpace})  {
//            print("searching left")
            let _found = recursiveSearch(startingPoint: proposedSpace,
                                         word: word,
                                         alreadyVisited: alreadyVisited,
                                         letterDictionary: letterDictionary)
            for (_word, _definition) in _found {
                found[_word] = _definition
            }
        }
        // right
        proposedSpace = right(coords: startingPoint)
//        print("proposedSpace.0: \(proposedSpace.0), proposedSpace.1: \(proposedSpace.1), nRows: \(nRows), not yet visited: \(!alreadyVisited.contains(where: {$0==proposedSpace})) ")
        if (proposedSpace.0 <= nRows) && (proposedSpace.1 <= nRows) && !alreadyVisited.contains(where: {$0==proposedSpace})  {
//            print("searching right")
            let _found = recursiveSearch(startingPoint: proposedSpace,
                                         word: word,
                                         alreadyVisited: alreadyVisited,
                                         letterDictionary: letterDictionary)
            for (_word, _definition) in _found {
                found[_word] = _definition
            }
        }
        
        // finally, return
        return found
        
    }
    
    func regexWordExists(word: String, text: String) -> Bool {
        
        let firstChar = word.prefix(1)
        let rest = word.count > 1 ? word.suffix(from: word.index(word.startIndex, offsetBy: 1)).lowercased(): ""
        
        let wordExistsRegex = try! Regex("(?m)^[\"]{0,1}[\(firstChar.uppercased())\(firstChar.lowercased())]\(rest)")
        
        return text.contains(wordExistsRegex)
    }
    func regexIsWholeWord(word: String, text: String) -> Bool {
        
        if word.count < 4 {return false}
        
        let firstChar = word.prefix(1)
        let rest = word.count > 1 ? word.suffix(from: word.index(word.startIndex, offsetBy: 1)).lowercased(): ""
        
        
        let regexIsWholeWord = try! Regex("(?m)^[\"]{0,1}[\(firstChar.uppercased())\(firstChar.lowercased())]\(rest)\\s")
        
        return text.contains(regexIsWholeWord)

    }
    func regexGetDefinition(word: String, text: String) -> [String] {
        
        let firstChar = word.prefix(1)
        let rest = word.count > 1 ? word.suffix(from: word.index(word.startIndex, offsetBy: 1)).lowercased(): ""
        
        let wordExistsRegex = try! Regex("(?m)^[\"]{0,1}[\(firstChar.uppercased())\(firstChar.lowercased())]\(rest)\\s.*$")
        
        let matches = text.ranges(of: wordExistsRegex)
        return matches.map {String(text[$0])}
    }
    
    func regexShrinkDict(word: String, text: String) -> String {
        
        let firstChar = word.prefix(1)
        let rest = word.count > 1 ? word.suffix(from: word.index(word.startIndex, offsetBy: 1)).lowercased(): ""
        
        let wordExistsRegex = try! Regex("(?m)^[\"]{0,1}[\(firstChar.uppercased())\(firstChar.lowercased())]\(rest).*$")
        
        let matches = text.ranges(of: wordExistsRegex)
        let matchStrings = matches.map {String(text[$0])}
//        print("called shrinker: \(matchStrings)")
        return matchStrings.joined(separator: "\n\n")
        
    }
    
    func down(coords: (Int, Int)) -> (Int, Int) {
        let x = coords.0
        let y = coords.1
        
        if x + 1 > nRows {
            return (nRows + 99, nRows + 99)
        }
        return (x + 1, y)
    }
    func up(coords: (Int, Int)) -> (Int, Int) {
        let x = coords.0
        let y = coords.1
        
        if x - 1 <= 0 {
            return (nRows + 99, nRows + 99)
        }
        return (x - 1, y)
    }
    func right(coords: (Int, Int)) -> (Int, Int) {
        let x = coords.0
        let y = coords.1
        
        if y + 1 > nRows {
            return (nRows + 99, nRows + 99)
        }
        return (x, y + 1)
    }
    func left(coords: (Int, Int)) -> (Int, Int) {
        let x = coords.0
        let y = coords.1
        
        if y - 1 <= 0 {
            return (nRows + 99, nRows + 99)
        }
        return (x, y - 1)
    }
    

}


