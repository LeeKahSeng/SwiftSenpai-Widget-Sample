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
        Text(entry.name)
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
        
        let entry = CryptoPriceEntry(
            date: Date(),
            name: "Bitcoin",
            symbol: "BTC",
            price: "$10000"
        )
        
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
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
