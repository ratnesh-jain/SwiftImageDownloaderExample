//
//  ContentView.swift
//  SwiftImageDownloaderExample
//
//  Created by Ratnesh Jain on 18/01/25.
//

import AppAsyncImage
import FetchingView
import SwiftUI

struct ContentView: View {
    var images: [URL] = Array(1...100).compactMap {
        URL(string: "https://picsum.photos/id/\($0)/200/250")
    }
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], content: {
                ForEach(images, id: \.self) { url in
                    AppAsyncImage(url: url)
                }
            })
            .padding()
        }
        .fetchingStateView {
            Image(systemName: "photo")
                .foregroundStyle(.secondary)
                .font(.system(size: 120))
                .overlay {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .background(.background.secondary)
        }
        .errorStateView { message in
            VStack {
                Image(systemName: "photo")
                    .font(.system(size: 100))
                    .foregroundStyle(.secondary)
                    .overlay {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.yellow)
                            .font(.largeTitle)
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.secondary.opacity(0.15))
        }
    }
}

#Preview {
    ContentView()
        #if os(macOS)
        .frame(minWidth: 1024, minHeight: 720)
        #endif
}
