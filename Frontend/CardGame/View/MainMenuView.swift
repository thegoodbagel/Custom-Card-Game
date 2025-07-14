//
//  MainMenuView.swift
//  CardGame
//
//  Created by Abrianna Zhang on 7/14/25.
//

import Foundation
import SwiftUI
import PhotosUI

enum NavigationDestination: Hashable {
    case game
}

struct MainMenuView: View {
    @State private var path: [NavigationDestination] = []
    @State private var cardBackImage: UIImage? = nil
    @State private var showImagePicker = false

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 40) {
                Text("Card Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Button("Play Game") {
                    path.append(.game)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)

                Button("Upload Card Back") {
                    showImagePicker = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(12)

                if let image = cardBackImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
            }
            .padding()
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .game:
                    GameView()
                }
            }
            .sheet(isPresented: $showImagePicker) {
                PhotoPicker(image: $cardBackImage)
            }
        }
    }
}
