//
//  ContentView.swift
//  DualCamera
//
//  Created by Ashwinee Dhakde on 27/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            DualCameraViewRepresentable()
                .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Dual Camera Preview")
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
            }
        }
    }
}

struct DualCameraViewRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> DualCameraView {
        DualCameraView()
    }

    func updateUIView(_ uiView: DualCameraView, context: Context) { }
}

#Preview {
    ContentView()
}
