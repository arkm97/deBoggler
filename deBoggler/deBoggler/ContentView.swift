//
//  ContentView.swift
//  deBoggler
//
//  Created by Andrew Madigan on 12/28/22.
//

import SwiftUI
import Vision

struct ContentView: View {
    
    @State private var isShowPicker = false
    @State private var sourceType = UIImagePickerController.SourceType.camera
    @State private var image = UIImage()
    @State private var textBoundingRectsRight = [RectangleModel(rect: CGRect())]
    @State private var textBoundingRectsLeft = [RectangleModel(rect: CGRect())]
    @State private var textBoundingRectsUp = [RectangleModel(rect: CGRect())]
    @State private var textBoundingRectsDown = [RectangleModel(rect: CGRect())]
    @State private var recognizedStringsRight = [String()]
    @State private var recognizedStringsLeft = [String()]
    @State private var recognizedStringsUp = [String()]
    @State private var recognizedStringsDown = [String()]
    @State private var recognizedStringsConfidenceUp = [VNConfidence()]
    @State private var recognizedStringsConfidenceDown = [VNConfidence()]
    @State private var recognizedStringsConfidenceLeft = [VNConfidence()]
    @State private var recognizedStringsConfidenceRight = [VNConfidence()]
    @State private var imageOrientation = CGImagePropertyOrientation.right

    
    var customWords = ["| A |", "| B |", "| C |", "| D |", "| E |", "| F |", "| G |", "| H |", "| I |", "| J |", "| K |", "| L |", "| M |", "| N |", "| O |", "| P |", "| Qu |", "| R |", "| S |", "| T |", "| U |", "| V |", "| W |", "| X |", "| Y |", "| Z |"]
    
    @AppStorage("upScaledByX") var upScaledByX = 1.33
    @AppStorage("upScaledByY") var upScaledByY = 0.76
    @AppStorage("downScaledByX") var downScaledByX = 1.33
    @AppStorage("downScaledByY") var downScaledByY = 0.76
    @AppStorage("upTransByX") var upTransByX = -375.0
    @AppStorage("upTransByY") var upTransByY =  660.0
    @AppStorage("downTransByX") var downTransByX = -375.0
    @AppStorage("downTransByY") var downTransByY =  660.0

    var body: some View {
        
        NavigationView {
            ZStack {
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        ZStack {
                            // .up orientation
                            GeometryReader { (geometry: GeometryProxy) in
                                ForEach(Array(zip(self.textBoundingRectsUp, self.recognizedStringsUp)), id: \.0) {rect, str in
                                    Rectangle()
                                        .path(in: CGRect(x: rect.rect.minX * self.image.size.width ,
                                                         y: (1 - rect.rect.maxY) * self.image.size.height,
                                                         width: rect.rect.width * self.image.size.width,
                                                         height: rect.rect.height * self.image.size.height))
                                        .applying(transformMatrix(geometry: geometry,
                                                                  image: self.image)
                                            .translatedBy(x: self.image.size.width / 2.0,
                                                                y: self.image.size.height / 2.0)
                                                      .rotated(by: .pi / 2)
                                                      .translatedBy(x: -1 * self.image.size.width / 2.0,
                                                                    y: -1 * self.image.size.height / 2.0)
                                                          .scaledBy(x: upScaledByX, y: upScaledByY)
                                                          .translatedBy(x: upTransByX, y: upTransByY)
                                        )
                                        .stroke(Color.purple, lineWidth: 2.0)
                                    //                                    .overlay(Text(str))
                                }
                            }
                            // .down orientation
                            GeometryReader { (geometry: GeometryProxy) in
                                ForEach(Array(zip(self.textBoundingRectsDown, self.recognizedStringsDown)), id: \.0) {rect, str in
                                    Rectangle()
                                        .path(in: CGRect(x: rect.rect.minX * self.image.size.width ,
                                                         y: (1 - rect.rect.maxY) * self.image.size.height,
                                                         width: rect.rect.width * self.image.size.width,
                                                         height: rect.rect.height * self.image.size.height))
                                        .applying(transformMatrix(geometry: geometry,
                                                                  image: self.image)
                                            .translatedBy(x: self.image.size.width / 2.0,
                                                          y: self.image.size.height / 2.0)
                                                .rotated(by: -1 * .pi / 2)
                                                .translatedBy(x: -1 * self.image.size.width / 2.0,
                                                              y: -1 * self.image.size.height / 2.0)
                                                    .scaledBy(x: downScaledByX, y: downScaledByY)
                                                    .translatedBy(x: downTransByX, y: downTransByY)
                                        )
                                        .stroke(Color.blue, lineWidth: 2.0)
                                    //                                    .overlay(Text(str))
                                }
                            }
                            // .left orientation
                            GeometryReader { (geometry: GeometryProxy) in
                                ForEach(Array(zip(self.textBoundingRectsLeft, self.recognizedStringsLeft)), id: \.0) {rect, str in
                                    Rectangle()
                                        .path(in: CGRect(x: rect.rect.minX * self.image.size.width ,
                                                         y: (1 - rect.rect.maxY) * self.image.size.height,
                                                         width: rect.rect.width * self.image.size.width,
                                                         height: rect.rect.height * self.image.size.height))
                                        .applying(transformMatrix(geometry: geometry, image: self.image)
                                            .translatedBy(x: self.image.size.width / 2.0,
                                                          y: self.image.size.height / 2.0)
                                                .rotated(by: .pi)
                                                .translatedBy(x: -1 * self.image.size.width / 2.0,
                                                              y: -1 * self.image.size.height / 2.0)
                                        )
                                        .stroke(Color.orange, lineWidth: 2.0)
                                    //                                    .overlay(Text(str))
                                }
                            }
                            // .right orientation
                            GeometryReader { (geometry: GeometryProxy) in
                                ForEach(Array(zip(self.textBoundingRectsRight, self.recognizedStringsRight)), id: \.0) {rect, str in
                                    Rectangle()
                                        .path(in: CGRect(x: rect.rect.minX * self.image.size.width ,
                                                         y: (1 - rect.rect.maxY) * self.image.size.height,
                                                         width: rect.rect.width * self.image.size.width,
                                                         height: rect.rect.height * self.image.size.height))
                                        .applying(transformMatrix(geometry: geometry, image: self.image))
                                        .stroke(Color.red, lineWidth: 2.0)
                                    //                                    .overlay(Text(str))
                                }
                            }
                        }
                    )
                VStack {
                    Spacer()
                    HStack {
                        Button("take photo", action: {
                            self.isShowPicker = true
                            self.sourceType = .camera
                            
                        })
                        .padding()
                        .background(Color(.blue))
                        .foregroundColor(Color(.white))
                        .clipShape(Capsule())
                        Button("library", action: {
                            self.isShowPicker = true
                            self.sourceType = .photoLibrary
                            
                        })
                        .padding()
                        .background(Color(.blue))
                        .foregroundColor(Color(.white))
                        .clipShape(Capsule())
                        NavigationLink(destination: editBoardView(imageData: imageData(
                            textBoundingRectsRight: self.textBoundingRectsRight,
                            textBoundingRectsLeft: self.textBoundingRectsLeft,
                            textBoundingRectsUp: self.textBoundingRectsUp,
                            textBoundingRectsDown: self.textBoundingRectsDown,
                            recognizedStringsRight: self.recognizedStringsRight,
                            recognizedStringsLeft: self.recognizedStringsLeft,
                            recognizedStringsUp: self.recognizedStringsUp,
                            recognizedStringsDown: self.recognizedStringsDown,
                            recognizedStringsConfidenceUp: self.recognizedStringsConfidenceUp,
                            recognizedStringsConfidenceDown: self.recognizedStringsConfidenceDown,
                            recognizedStringsConfidenceLeft: self.recognizedStringsConfidenceLeft,
                            recognizedStringsConfidenceRight: self.recognizedStringsConfidenceRight,
                            transformRight: CGAffineTransform.identity,
                            transformLeft: CGAffineTransform.identity.translatedBy(x: self.image.size.width / 2.0,
                                                                                     y: self.image.size.height / 2.0)
                                                                           .rotated(by: .pi)
                                                                           .translatedBy(x: -1 * self.image.size.width / 2.0,
                                                                                         y: -1 * self.image.size.height / 2.0),
                            transformUp: CGAffineTransform.identity.translatedBy(x: self.image.size.width / 2.0,
                                                                                   y: self.image.size.height / 2.0)
                                                                         .rotated(by: .pi / 2)
                                                                         .translatedBy(x: -1 * self.image.size.width / 2.0,
                                                                                       y: -1 * self.image.size.height / 2.0)
                                                                             .scaledBy(x: upScaledByX, y: upScaledByY)
                                                                             .translatedBy(x: upTransByX, y: upTransByY),
                            transformDown: CGAffineTransform.identity.translatedBy(x: self.image.size.width / 2.0,
                                                                                     y: self.image.size.height / 2.0)
                                                                           .rotated(by: -1 * .pi / 2)
                                                                           .translatedBy(x: -1 * self.image.size.width / 2.0,
                                                                                         y: -1 * self.image.size.height / 2.0)
                                                                               .scaledBy(x: downScaledByX, y: downScaledByY)
                                                                               .translatedBy(x: downTransByX, y: downTransByY)
                                
                        ))) {
//                        NavigationLink(destination: editBoardView()) {
                                Text("continue...")
                                    .padding()
                                    .background(Color(.blue))
                                    .foregroundColor(Color(.white))
                                    .clipShape(Capsule())
                            }
                    }
                    // sliders to set up and down scale/translation
                    //                VStack {
                    //
                    //                    HStack {
                    //                        Slider(value: $upScaledByX, in: 1.0...2.0, step: 0.01)
                    //                        Text("up scaled by, X: \(upScaledByX, specifier: "%.3f")")
                    //                    }
                    //                    HStack {
                    //                        Slider(value: $upScaledByY, in: 0...1, step: 0.01)
                    //                        Text("up scaled by, Y: \(upScaledByY, specifier: "%.3f")")
                    //                    }
                    //                    HStack {
                    //                        Slider(value: $upTransByX, in: -500...0, step: 5)
                    //                        Text("up trans by, X: \(upTransByX, specifier: "%.3f")")
                    //                    }
                    //                    HStack {
                    //                        Slider(value: $upTransByY, in: 300...1000, step: 5)
                    //                        Text("up trans by, Y: \(upTransByY, specifier: "%.3f")")
                    //                    }
                    //                    HStack {
                    //                        Slider(value: $downScaledByX, in: 1.0...2.0, step: 0.01)
                    //                        Text("down scaled by, X: \(downScaledByX, specifier: "%.3f")")
                    //                    }
                    //                    HStack {
                    //                        Slider(value: $downScaledByY, in: 0...1.0, step: 0.01)
                    //                        Text("down scaled by, Y: \(downScaledByY, specifier: "%.3f")")
                    //                    }
                    //                    HStack {
                    //                        Slider(value: $downTransByX, in: -500...0, step: 5)
                    //                        Text("down trans by, X: \(downTransByX, specifier: "%.3f")")
                    //                    }
                    //                    HStack {
                    //                        Slider(value: $downTransByY, in: 300...1000, step: 5)
                    //                        Text("down trans by, Y: \(downTransByY, specifier: "%.3f")")
                    //                    }
                    //
                    //                }
                }
            }.sheet(isPresented: $isShowPicker, onDismiss: didDismissImagePicker) {
                ImagePicker(sourceType: sourceType, selectedImage: self.$image)
            }
            .padding()
        }
    }
    
    func recognizeText(image: UIImage, orientation: CGImagePropertyOrientation) {
        guard let cgImage = self.image.cgImage else {return}
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: orientation)
        
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        request.recognitionLevel = VNRequestTextRecognitionLevel.accurate
        request.usesLanguageCorrection = true
        request.customWords = customWords
        self.imageOrientation = orientation
        
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("text recognition failed: \(error)")
        }
    }
    
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
            return
        }
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        
        let recognizedStringsConfidence = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.confidence
        }
        
        let boundingRects: [CGRect] = observations.compactMap { observation in
            
            // Find the top observation.
            guard let candidate = observation.topCandidates(1).first else { return .zero }
            
            // Find the bounding-box observation for the string range.
            let stringRange = candidate.string.startIndex..<candidate.string.endIndex
            let boxObservation = try? candidate.boundingBox(for: stringRange)
            
            // Get the normalized CGRect value.
            let boundingBox = boxObservation?.boundingBox ?? .zero
            
            //            return boundingBox
            // Convert the rectangle from normalized coordinates to image coordinates.
            return VNImageRectForNormalizedRect(boundingBox, 1, 1)
            //                                                Int(image.size.width),
            //                                                Int(image.size.height))
        }
        if self.imageOrientation == CGImagePropertyOrientation.up {
            self.textBoundingRectsUp = boundingRects.map { (RectangleModel(rect: $0)) }
            self.recognizedStringsUp = recognizedStrings
            self.recognizedStringsConfidenceUp = recognizedStringsConfidence
        }
        else if self.imageOrientation == CGImagePropertyOrientation.down {
            self.textBoundingRectsDown = boundingRects.map { (RectangleModel(rect: $0)) }
            self.recognizedStringsDown = recognizedStrings
            self.recognizedStringsConfidenceDown = recognizedStringsConfidence
        }
        else if self.imageOrientation == CGImagePropertyOrientation.left {
            self.textBoundingRectsLeft = boundingRects.map { (RectangleModel(rect: $0)) }
            self.recognizedStringsLeft = recognizedStrings
            self.recognizedStringsConfidenceLeft = recognizedStringsConfidence
        }
        else { //handles orientation.right
            self.textBoundingRectsRight = boundingRects.map { (RectangleModel(rect: $0)) }
            self.recognizedStringsRight = recognizedStrings
            self.recognizedStringsConfidenceRight = recognizedStringsConfidence
        }
        for s in recognizedStrings {
            print("\(s)")
        }
    }
    //func displayTextRect(boundingRect: CGRect, foundTxt: String, image: UIImage) -> some View{
    //
    //    let scale = 1.0//UIScreen.main.scale
    //    let screenWidth = UIScreen.main.bounds.width * scale
    //    let screenHeight = UIScreen.main.bounds.height * scale
    //        return Text("\(foundTxt)")
    //            .frame(width: boundingRect.height * 1.333 * screenHeight, height: boundingRect.width * screenHeight, alignment: .topLeading)
    //            .background(Rectangle().fill(.gray).opacity(0.1))
    //            .border(Color.red)
    //            .font(.system(size: 10))
    //            .position(x: boundingRect.origin.y * 1.333 * screenHeight, y: boundingRect.origin.x * screenHeight)
    
    
    //    }
    func didDismissImagePicker() {
        for orientation in [CGImagePropertyOrientation.up,
                            CGImagePropertyOrientation.down,
                            CGImagePropertyOrientation.left,
                            CGImagePropertyOrientation.right] {
            recognizeText(image: self.image, orientation: orientation)
        }
        return
        
    }
    
    
    func transformMatrix(geometry:GeometryProxy, image:UIImage) -> CGAffineTransform {
        
        let imageViewWidth = geometry.size.width
        let imageViewHeight = geometry.size.height
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let imageViewAspectRatio = imageViewWidth / imageViewHeight
        let imageAspectRatio = imageWidth / imageHeight
        let scale = (imageViewAspectRatio > imageAspectRatio) ?
        imageViewWidth / imageWidth :
        imageViewHeight / imageHeight
        
        // Image view's `contentMode` is `scaleAspectFit`, which scales the image to fit the size of the
        // image view by maintaining the aspect ratio. Multiple by `scale` to get image's original size.
        let scaledImageWidth = imageWidth * scale
        let scaledImageHeight = imageHeight * scale
        let xValue = (imageViewWidth - scaledImageWidth) / CGFloat(2.0)
        let yValue = (imageViewHeight - scaledImageHeight) / CGFloat(2.0)
        
        var transform = CGAffineTransform.identity.translatedBy(x: xValue, y: yValue)
        transform = transform.scaledBy(x: scale, y: scale)
        return transform
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    

    
    class RectangleModel: NSObject, Identifiable {
        
        var rect: CGRect
        
        init(rect: CGRect) {
            self.rect = rect
        }
        
    }
}
