//
//  CryptoPriceWidget.swift
//  CryptoPriceWidget
//
//  Created by Kah Seng Lee on 18/02/2023.
//

import WidgetKit
import SwiftUI
import Intents

struct CryptoPriceEntry: TimelineEntry {
    let date: Date
    let name: String
    let symbol: String
    let price: String
}

struct CryptoPriceWidgetView: View {
    
    let entry: CryptoPriceEntry
    
    var body: some View {
        VStack {
            Text(entry.name)
                .font(.title.weight(.bold))
            Text(entry.symbol)
                .font(.footnote)
                .padding(.bottom, 8)
            Text(entry.price)
                .font(.title2.weight(.semibold))
        }
        .containerBackground(for: .widget) { }
    }
}

struct CryptoPriceTimelineProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> CryptoPriceEntry {
        
        return CryptoPriceEntry(
            date: Date(),
            name: "Bitcoin",
            symbol: "BTC",
            price: "$10000"
        )
    }

    func getSnapshot(for configuration: CryptoPriceConfigurationIntent,
                     in context: Context,
                     completion: @escaping (CryptoPriceEntry) -> ()) {
        
        let entry = CryptoPriceEntry(
            date: Date(),
            name: "Bitcoin",
            symbol: "BTC",
            price: "$10000"
        )
        
        completion(entry)
    }

    func getTimeline(for configuration: CryptoPriceConfigurationIntent,
                     in context: Context,
                     completion: @escaping (Timeline<CryptoPriceEntry>) -> ()) {
        
        // Extract required information from `configuration`
        guard
            let assetId = configuration.selectedCrypto?.identifier,
            let name = configuration.selectedCrypto?.name,
            let symbol = configuration.selectedCrypto?.symbol else {
            
            showEmptyState(completion: completion)
            return
        }
        
        Task {
            
            // Fetch asset details
            guard let assetDetails = try? await AssetFetcher.fetchAssetDetails(id: assetId) else {
                
                showEmptyState(completion: completion)
                return
            }
            
            // Create `CryptoPriceEntry` using based on user selected configuration & fetched information
            let entry = CryptoPriceEntry(
                date: Date(),
                name: name,
                symbol: symbol,
                price: assetDetails.price
            )
            
            // Trigger completion & next fetch happens 15 minutes later
            executeTimelineCompletion(completion, timelineEntry: entry)
        }
    }
    
    private func showEmptyState(completion: @escaping (Timeline<CryptoPriceEntry>) -> ()) {
        
        let entry = CryptoPriceEntry(
            date: Date(),
            name: "",
            symbol: "Please select an asset",
            price: ""
        )
        
        // Trigger completion & next fetch happens 15 minutes later
        executeTimelineCompletion(completion, timelineEntry: entry)
    }
    
    func executeTimelineCompletion(_ completion: @escaping (Timeline<CryptoPriceEntry>) -> (),
                                   timelineEntry: CryptoPriceEntry) {
        
        // Next fetch happens 15 minutes later
        let nextUpdate = Calendar.current.date(
            byAdding: DateComponents(minute: 15),
            to: Date()
        )!
        
        let timeline = Timeline(
            entries: [timelineEntry],
            policy: .after(nextUpdate)
        )
        
        completion(timeline)
    }
}

struct CryptoPriceWidget: Widget {
    
    let kind = "com.SwiftSenpaiDemo.CryptoPriceWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: CryptoPriceConfigurationIntent.self,
            provider: CryptoPriceTimelineProvider()
        ) { entry in
            CryptoPriceWidgetView(entry: entry)
        }
        .configurationDisplayName("Crypto Price Widget")
        .description("Get price for your selected asset")
        .supportedFamilies([
            .systemSmall,
        ])
    }
}

#Preview(as: .systemSmall) {
    CryptoPriceWidget()
} timeline: {
    CryptoPriceEntry(
        date: Date(),
        name: "Bitcoin",
        symbol: "BTC",
        price: "$12345"
    )
}
