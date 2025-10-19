//
//  SplashUIView.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import SwiftUI

struct SplashUIView: View {
    var body: some View {
        VStack {
            Spacer()
            LottieUIView(filePath: "splash_cat", mode: .json)
                .square(of: 360)
                .frame(height: 200)
                .shadow(radius: 10, y: 20)
            Text("Cat Kingdom")
                .bold()
                .font(.title)
                .foregroundStyle(LinearGradient(
                    colors: [
                        .red,
                        .green,
                        .blue
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    SplashUIView()
}
