//
//  DoggyWidget.swift
//  DoggyWidget
//
//  Created by Kah Seng Lee on 23/01/2023.
//

import WidgetKit
import SwiftUI

struct DoggyEntry: TimelineEntry {
    let date: Date
    let image: UIImage
}

struct DoggyWidgetView: View {
    
    let entry: DoggyEntry
    
    var body: some View {
        Image(uiImage: entry.image)
            .resizable()
            .scaledToFill()
            .clipped()
            .containerBackground(for: .widget) { }
    }
}

struct DoggyTimelineProvider: TimelineProvider {

    typealias Entry = DoggyEntry

    func placeholder(in context: Context) -> Entry {
        let sample = UIImage(named: "sample-doggy")!
        return DoggyEntry(date: Date(), image: sample)
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        
        var snapshotDoggy: UIImage
        
        if context.isPreview && !DoggyFetcher.cachedDoggyAvailable {
            // Use local sample image as snapshot if cached image not available
            snapshotDoggy = UIImage(named: "sample-doggy")!
        } else {
            // Use cached image as snapshot
            snapshotDoggy = DoggyFetcher.cachedDoggy!
        }
        
        let entry = DoggyEntry(date: Date(), image: snapshotDoggy)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        Task {

            // Fetch a random doggy image from server
            guard let image = try? await DoggyFetcher.fetchRandomDoggy() else {
                return
            }
            
            let entry = DoggyEntry(date: Date(), image: image)
            
            // Next fetch happens 15 minutes later
            let nextUpdate = Calendar.current.date(
                byAdding: DateComponents(minute: 15),
                to: Date()
            )!
            
            let timeline = Timeline(
                entries: [entry],
                policy: .after(nextUpdate)
            )
            
            completion(timeline)
        }
    }
}

@main
struct DoggyWidget: Widget {
    
    let kind = "com.SwiftSenpaiDemo.DoggyWidgetView"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: DoggyTimelineProvider()
        ) { entry in
            DoggyWidgetView(entry: entry)
        }
        .configurationDisplayName("Doggy Widget")
        .description("Unlimited doggy all day long.")
        .supportedFamilies([
            .systemSmall,
        ])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall, widget: {
    DoggyWidget()
}, timeline: {
    DoggyEntry(date: Date(), image: UIImage(named: "sample-doggy")!)
})
