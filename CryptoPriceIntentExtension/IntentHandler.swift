//
//  IntentHandler.swift
//  CryptoPriceIntentExtension
//
//  Created by Kah Seng Lee on 18/02/2023.
//

import Intents

class IntentHandler: INExtension, CryptoPriceConfigurationIntentHandling {
    
    func provideSelectedCryptoOptionsCollection(for intent: CryptoPriceConfigurationIntent, with completion: @escaping (INObjectCollection<Crypto>?, Error?) -> Void) {
        
    }
    
    func provideSelectedCryptoOptionsCollection(for intent: CryptoPriceConfigurationIntent) async throws -> INObjectCollection<Crypto> {
        
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}


