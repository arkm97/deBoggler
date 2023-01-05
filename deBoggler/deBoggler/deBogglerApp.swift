//
//  deBogglerApp.swift
//  deBoggler
//
//  Created by Andrew Madigan on 12/28/22.
//

import SwiftUI

    @main
struct deBogglerApp: App {
        
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

let APath = Bundle.main.url(forResource: "A", withExtension: "txt", subdirectory: "Dictionary in csv")!
let BPath = Bundle.main.url(forResource: "B", withExtension: "txt", subdirectory: "Dictionary in csv")!
let CPath = Bundle.main.url(forResource: "C", withExtension: "txt", subdirectory: "Dictionary in csv")!
let DPath = Bundle.main.url(forResource: "D", withExtension: "txt", subdirectory: "Dictionary in csv")!
let EPath = Bundle.main.url(forResource: "E", withExtension: "txt", subdirectory: "Dictionary in csv")!
let FPath = Bundle.main.url(forResource: "F", withExtension: "txt", subdirectory: "Dictionary in csv")!
let GPath = Bundle.main.url(forResource: "G", withExtension: "txt", subdirectory: "Dictionary in csv")!
let HPath = Bundle.main.url(forResource: "H", withExtension: "txt", subdirectory: "Dictionary in csv")!
let IPath = Bundle.main.url(forResource: "I", withExtension: "txt", subdirectory: "Dictionary in csv")!
let JPath = Bundle.main.url(forResource: "J", withExtension: "txt", subdirectory: "Dictionary in csv")!
let KPath = Bundle.main.url(forResource: "K", withExtension: "txt", subdirectory: "Dictionary in csv")!
let LPath = Bundle.main.url(forResource: "L", withExtension: "txt", subdirectory: "Dictionary in csv")!
let MPath = Bundle.main.url(forResource: "M", withExtension: "txt", subdirectory: "Dictionary in csv")!
let NPath = Bundle.main.url(forResource: "N", withExtension: "txt", subdirectory: "Dictionary in csv")!
let OPath = Bundle.main.url(forResource: "O", withExtension: "txt", subdirectory: "Dictionary in csv")!
let PPath = Bundle.main.url(forResource: "P", withExtension: "txt", subdirectory: "Dictionary in csv")!
let QPath = Bundle.main.url(forResource: "Q", withExtension: "txt", subdirectory: "Dictionary in csv")!
let RPath = Bundle.main.url(forResource: "R", withExtension: "txt", subdirectory: "Dictionary in csv")!
let SPath = Bundle.main.url(forResource: "S", withExtension: "txt", subdirectory: "Dictionary in csv")!
let TPath = Bundle.main.url(forResource: "T", withExtension: "txt", subdirectory: "Dictionary in csv")!
let UPath = Bundle.main.url(forResource: "U", withExtension: "txt", subdirectory: "Dictionary in csv")!
let VPath = Bundle.main.url(forResource: "V", withExtension: "txt", subdirectory: "Dictionary in csv")!
let WPath = Bundle.main.url(forResource: "W", withExtension: "txt", subdirectory: "Dictionary in csv")!
let XPath = Bundle.main.url(forResource: "X", withExtension: "txt", subdirectory: "Dictionary in csv")!
let YPath = Bundle.main.url(forResource: "Y", withExtension: "txt", subdirectory: "Dictionary in csv")!
let ZPath = Bundle.main.url(forResource: "Z", withExtension: "txt", subdirectory: "Dictionary in csv")!

let AWords = try! String(contentsOf: APath, encoding: String.Encoding.ascii)
let BWords = try! String(contentsOf: BPath, encoding: String.Encoding.ascii)
let CWords = try! String(contentsOf: CPath, encoding: String.Encoding.ascii)
let DWords = try! String(contentsOf: DPath, encoding: String.Encoding.ascii)
let EWords = try! String(contentsOf: EPath, encoding: String.Encoding.ascii)
let FWords = try! String(contentsOf: FPath, encoding: String.Encoding.ascii)
let GWords = try! String(contentsOf: GPath, encoding: String.Encoding.ascii)
let HWords = try! String(contentsOf: HPath, encoding: String.Encoding.ascii)
let IWords = try! String(contentsOf: IPath, encoding: String.Encoding.ascii)
let JWords = try! String(contentsOf: JPath, encoding: String.Encoding.ascii)
let KWords = try! String(contentsOf: KPath, encoding: String.Encoding.ascii)
let LWords = try! String(contentsOf: LPath, encoding: String.Encoding.ascii)
let MWords = try! String(contentsOf: MPath, encoding: String.Encoding.ascii)
let NWords = try! String(contentsOf: NPath, encoding: String.Encoding.ascii)
let OWords = try! String(contentsOf: OPath, encoding: String.Encoding.ascii)
let PWords = try! String(contentsOf: PPath, encoding: String.Encoding.ascii)
let QWords = try! String(contentsOf: QPath, encoding: String.Encoding.ascii)
let RWords = try! String(contentsOf: RPath, encoding: String.Encoding.ascii)
let SWords = try! String(contentsOf: SPath, encoding: String.Encoding.ascii)
let TWords = try! String(contentsOf: TPath, encoding: String.Encoding.ascii)
let UWords = try! String(contentsOf: UPath, encoding: String.Encoding.ascii)
let VWords = try! String(contentsOf: VPath, encoding: String.Encoding.ascii)
let WWords = try! String(contentsOf: WPath, encoding: String.Encoding.ascii)
let XWords = try! String(contentsOf: XPath, encoding: String.Encoding.ascii)
let YWords = try! String(contentsOf: YPath, encoding: String.Encoding.ascii)
let ZWords = try! String(contentsOf: ZPath, encoding: String.Encoding.ascii)

let allWords: [String:String] = [
    "A": AWords,
    "B": BWords,
    "C": CWords,
    "D": DWords,
    "E": EWords,
    "F": FWords,
    "G": GWords,
    "H": HWords,
    "I": IWords,
    "J": JWords,
    "K": KWords,
    "L": LWords,
    "M": MWords,
    "N": NWords,
    "O": OWords,
    "P": PWords,
    "Q": QWords,
    "R": RWords,
    "S": SWords,
    "T": TWords,
    "U": UWords,
    "V": VWords,
    "W": WWords,
    "X": XWords,
    "Y": YWords,
    "Z": ZWords]
