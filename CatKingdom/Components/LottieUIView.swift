//
//  LottieUIView.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import Lottie
import SwiftUI

struct LottieUIView: View {
    enum Mode {
        case lottie
        case json
    }
    
    private let mode: Mode
    private let filePath: String
    private let animation: LottieAnimation?
    
    init(filePath: String, mode: Mode = .json) {
        self.filePath = filePath
        self.mode = mode
        switch mode {
            case .lottie:
                if let url = Bundle.main.url(forResource: filePath, withExtension: "lottie") {
                    self.animation = LottieAnimation.filepath(url.path)
                } else {
                    self.animation = nil
                }
            case .json:
                self.animation = LottieAnimation.named(filePath)
        }
    }
    
    var body: some View {
        LottieView {
            animation
        } placeholder: {
            Color.clear
        }
        .looping()
        .resizable()
    }
}
