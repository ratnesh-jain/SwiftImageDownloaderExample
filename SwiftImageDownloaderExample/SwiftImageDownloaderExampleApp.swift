//
//  SwiftImageDownloaderExampleApp.swift
//  SwiftImageDownloaderExample
//
//  Created by Ratnesh Jain on 18/01/25.
//

import Dependencies
import SwiftUI

@main
struct SwiftImageDownloaderExampleApp: App {
    
    init() {
        prepareDependencies {
            $0.colorCacheConfig.allowCache = { false }
            $0.imageCacheConfig.totalCostLimit = { 10 }
            $0.storageClient.imageCachePath = { URL.temporaryDirectory.appending(path: "Images") }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
