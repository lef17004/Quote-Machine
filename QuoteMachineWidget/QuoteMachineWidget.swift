//
//  QuoteMachineWidget.swift
//  QuoteMachineWidget
//
//  Created by Michael Le Fevre on 10/16/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for minuteOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset * 5, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct QuoteMachineWidgetEntryView : View {
    
    let text: String = UserDefaults(suiteName: "group.com.quotemachinegroup")!.array(forKey: "QuoteList")?.randomElement() as? String ?? "Here's to the crazy ones..."
    
    var entry: Provider.Entry

    var body: some View {
        
        ZStack {
            Image(uiImage: #imageLiteral(resourceName: "goldbackground"))
                .resizable()
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
        }
            
            
            
    }
}



@main
struct QuoteMachineWidget: Widget {
    let kind: String = "QuoteMachineWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            QuoteMachineWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct QuoteMachineWidget_Previews: PreviewProvider {
    static var previews: some View {
        QuoteMachineWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

