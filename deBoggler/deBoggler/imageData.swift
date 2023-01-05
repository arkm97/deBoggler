//
//  imageData.swift
//  deBoggler
//
//  Created by Andrew Madigan on 12/31/22.
//

import Foundation
import Vision

struct imageData {
    var textBoundingRectsRight = [ContentView.RectangleModel(rect: CGRect())]
    var textBoundingRectsLeft = [ContentView.RectangleModel(rect: CGRect())]
    var textBoundingRectsUp = [ContentView.RectangleModel(rect: CGRect())]
    var textBoundingRectsDown = [ContentView.RectangleModel(rect: CGRect())]
    var recognizedStringsRight = [String()]
    var recognizedStringsLeft = [String()]
    var recognizedStringsUp = [String()]
    var recognizedStringsDown = [String()]
    var recognizedStringsConfidenceUp = [VNConfidence()]
    var recognizedStringsConfidenceDown = [VNConfidence()]
    var recognizedStringsConfidenceLeft = [VNConfidence()]
    var recognizedStringsConfidenceRight = [VNConfidence()]
    var transformRight = CGAffineTransform()
    var transformLeft = CGAffineTransform()
    var transformUp = CGAffineTransform()
    var transformDown = CGAffineTransform()
}

