//
//  IntentHandler.swift
//  CryptoPriceIntentExtension
//
//  Created by Kah Seng Lee on 18/02/2023.
//

import Intents

class IntentHandler: INExtension, CryptoPriceConfigurationIntentHandling {
    
    func provideSelectedCryptoOptionsCollection(
        for intent: CryptoPriceConfigurationIntent
    ) async throws -> INObjectCollection<Crypto> {
        
        // Fetch list of top ten crypto from API
        let assets = try await AssetFetcher.fetchTopTenAssets()
        
        // Transform `[Asset]` to `[Crypto]`
        let cryptos = assets.map { asset in
            
            let crypto = Crypto(
                identifier: asset.id,
                display: "\(asset.name) (\(asset.symbol))"
            )
            crypto.symbol = asset.symbol
            crypto.name = asset.name
            
            return crypto
        }
        
        // Create a collection with the array of cryptos.
        let collection = INObjectCollection(items: cryptos)
        
        // Return the collections
        return collection
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}


