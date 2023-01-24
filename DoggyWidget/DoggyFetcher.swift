//
//  DoggyFetcher.swift
//  SwiftSenpai-Widget-Sample
//
//  Created by Kah Seng Lee on 23/01/2023.
//

import Foundation
import UIKit

struct Doggy: Decodable {
    let message: URL
    let status: String
}

struct DoggyFetcher {
    
    enum DoggyFetcherError: Error {
        case imageDataCorrupted
    }
    
    private static var cachePath: URL {
        URL.cachesDirectory.appending(path: "doggy.png")
    }
    
    static var cachedDoggy: UIImage? {
        guard let imageData = try? Data(contentsOf: cachePath) else {
            return  nil
        }
        return UIImage(data: imageData)
    }
    
    static var cachedDoggyAvailable: Bool {
        cachedDoggy != nil
    }
    
    static func fetchRandomDoggy() async throws -> UIImage {

        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!

        // Fetch JSON data
        let (data, _) = try await URLSession.shared.data(from: url)

        // Parse the JSON data
        let doggy = try JSONDecoder().decode(Doggy.self, from: data)
        
        // Fetch image from URL
        let (imageData, _) = try await URLSession.shared.data(from: doggy.message)
        
        // Spawn another task to cache the downloaded image
        Task {
            try? await cache(imageData)
        }
        
        guard let image = UIImage(data: imageData) else {
            throw DoggyFetcherError.imageDataCorrupted
        }
        
        return image
    }
    
    private static func cache(_ imageData: Data) async throws {
        try imageData.write(to: cachePath)
    }
}
