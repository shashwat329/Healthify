//
//  HistoricView.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//
//
//
//import SwiftUI
//import Charts
//
//// MARK: - Enums
//
//enum TimeFrame: String, CaseIterable, Identifiable {
//    case daily = "Daily"
//    case weekly = "Weekly"
//    case monthly = "Monthly"
//
//    var id: String { self.rawValue }
//}
//
//enum ActivityType: String {
//    case calories = "Calories"
//    case steps = "Steps"
//    case distance = "Distance"
//}
//
//// MARK: - Model
//
//struct ActivityData: Identifiable {
//    let id = UUID()
//    let date: Date
//    let type: ActivityType
//    let value: Double
//}
//
//// MARK: - Sample Data
//
//let sampleActivities: [ActivityData] = [
//    ActivityData(date: .now, type: .calories, value: 450),
//    ActivityData(date: .now, type: .steps, value: 8000),
//    ActivityData(date: .now, type: .distance, value: 5.2),
//    
//    ActivityData(date: Calendar.current.date(byAdding: .day, value: -1, to: .now)!, type: .calories, value: 390),
//    ActivityData(date: Calendar.current.date(byAdding: .day, value: -1, to: .now)!, type: .steps, value: 7500),
//    ActivityData(date: Calendar.current.date(byAdding: .day, value: -1, to: .now)!, type: .distance, value: 4.8),
//]
//
//// MARK: - View
//
//struct ChartView: View {
//    var allActivities: [ActivityData]
//    @State private var selectedTimeFrame: TimeFrame = .daily
//
//    var filteredActivities: [ActivityData] {
//        let calendar = Calendar.current
//        let now = Date()
//
//        switch selectedTimeFrame {
//        case .daily:
//            return allActivities.filter { calendar.isDate($0.date, inSameDayAs: now) }
//        case .weekly:
//            let weekAgo = calendar.date(byAdding: .day, value: -6, to: now)!
//            return allActivities.filter { $0.date >= weekAgo }
//        case .monthly:
//            let monthAgo = calendar.date(byAdding: .month, value: -1, to: now)!
//            return allActivities.filter { $0.date >= monthAgo }
//        }
//    }
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Activity Summary")
//                .font(.title2.bold())
//                .padding(.horizontal)
//
//            Picker("Time Frame", selection: $selectedTimeFrame) {
//                ForEach(TimeFrame.allCases) { timeframe in
//                    Text(timeframe.rawValue).tag(timeframe)
//                }
//            }
//            .pickerStyle(.segmented)
//            .padding(.horizontal)
//
//            Chart {
//                ForEach(filteredActivities) { activity in
//                    BarMark(
//                        x: .value("Date", activity.date, unit: .day),
//                        y: .value("Value", activity.value)
//                    )
//                    .foregroundStyle(by: .value("Type", activity.type.rawValue))
//
//                }
//            }
//            .chartLegend(position: .bottom)
//            .frame(height: 300)
//            .padding()
//        }
//        Spacer()
//    }
//}
//
//#Preview {
//    ChartView(allActivities: sampleActivities)
//}
