//
//  AssetFetcher.swift
//  SwiftSenpai-Widget-Sample
//
//  Created by Kah Seng Lee on 18/02/2023.
//

import Foundation

struct Asset: Codable {
    let id: String
    let name: String
    let symbol: String
}

struct AssetDetails: Codable {
    let priceUsd: String
    
    /// Formatted price value
    var price: String {
        let value = Double(priceUsd) ?? 0
        return "$" + String(format: "%.2f", value)
    }
}

struct AssetFetcher {
    
    private struct Response<T: Codable>: Codable {
        let data: T
    }
    
    static func fetchTopTenAssets() async throws -> [Asset] {
        
        let url = URL(string: "https://api.coincap.io/v2/assets?limit=10")!

        // Fetch JSON data
        let (data, _) = try await URLSession.shared.data(from: url)

        // Parse the JSON data
        let response = try JSONDecoder().decode(Response<[Asset]>.self, from: data)
        
        let assets = response.data
        
        return assets
    }
    
    static func fetchAssetDetails(id: String) async throws -> AssetDetails {

        let url = URL(string: "https://api.coincap.io/v2/assets/\(id)")!

        // Fetch JSON data
        let (data, _) = try await URLSession.shared.data(from: url)

        // Parse the JSON data
        let response = try JSONDecoder().decode(Response<AssetDetails>.self, from: data)
        
        let assetDetails = response.data
        
        return assetDetails
    }
}
