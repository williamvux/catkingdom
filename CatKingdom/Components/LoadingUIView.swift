//
//  LoadingUIView.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import SwiftUI

struct LoadingUIView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                    .tint(.gray)
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    LoadingUIView()
}
