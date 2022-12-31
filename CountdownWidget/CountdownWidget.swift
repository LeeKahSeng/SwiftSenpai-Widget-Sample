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
        
        Text(getFutureDate(), style: .relative)
            .padding(4)
            .font(.headline)
            .multilineTextAlignment(.center)
            .background(.red)
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
        
        let entry = CountdownEntry(
            date: Date(),
            status: "Counting down...",
            gaugeValue: 25.0
        )
        let timeline = Timeline(entries: [entry], policy: .never)
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
