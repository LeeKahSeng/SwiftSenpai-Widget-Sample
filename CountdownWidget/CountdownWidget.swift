//
//  CountdownWidget.swift
//  CountdownWidget
//
//  Created by Kah Seng Lee on 30/12/2022.
//

import WidgetKit
import SwiftUI

struct CountdownEntry: TimelineEntry {
    let date: Date
    let status: String
    let gaugeValue: CGFloat
}

struct CountdownWidgetView: View {
    
    let entry: CountdownEntry
    let totalCountdown = CountdownWidget.totalCountdown
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Text(getFutureDate(), style: .relative)
                .padding(4)
                .font(.headline)
                .multilineTextAlignment(.center)
                .background(.red)
            
            Gauge(value: entry.gaugeValue, in: 0...CGFloat(totalCountdown)) {
                Text("countdown")
            } currentValueLabel: {
                Text(entry.gaugeValue.formatted())
            }
            .gaugeStyle(.accessoryCircularCapacity)
            
            Text(entry.status)
                .font(.caption)
                .foregroundColor(Color(.systemGray))
        }
    }
    
    private func getFutureDate() -> Date {
        let components = DateComponents(second: totalCountdown + 1)
        let futureDate = Calendar.current.date(byAdding: components, to: Date())!
        return futureDate
    }
}

struct CountdownTimelineProvider: TimelineProvider {

    typealias Entry = CountdownEntry

    func placeholder(in context: Context) -> Entry {
        return CountdownEntry(
            date: Date(),
            status: "Counting down...",
            gaugeValue: 25.0
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = CountdownEntry(
            date: Date(),
            status: "Counting down...",
            gaugeValue: 25.0
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let totalCountdown = CountdownWidget.totalCountdown
        
        // Entries required for 1 countdown session (60 seconds)
        var entries = [CountdownEntry]()
        
        // Generate 61 entries to show countdown from 60 - 0
        for i in 0...totalCountdown {
            
            // Determine widget refresh date & create an entry
            let components = DateComponents(second: i)
            let refreshDate = Calendar.current.date(byAdding: components, to: Date())!
            
            // Calculate gauge value
            let gaugeValue = CGFloat(totalCountdown - i)
            
            // Determine status
            // Status will become "Waiting..." when `gaugeValue` reached zero
            let status = gaugeValue == 0 ? "Waiting refresh..." : "Counting down..."
            
            let entry = CountdownEntry(
                date: refreshDate,
                status: status,
                gaugeValue: gaugeValue
            )
            
            entries.append(entry)
        }
        
        // Create a timeline using `entries`
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

@main
struct CountdownWidget: Widget {
    
    static let totalCountdown = 60

    let kind = "com.SwiftSenpaiDemo.CountdownWidgetView"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: CountdownTimelineProvider()
        ) { entry in
            CountdownWidgetView(entry: entry)
        }
        .configurationDisplayName("Countdown Widget")
        .description("This is a demo widget.")
        .supportedFamilies([
            .systemSmall,
        ])
    }
}
