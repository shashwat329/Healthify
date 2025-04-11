//
//  HKWorkoutActivityTime+Extensions.swift
//  Gym
//
//  Created by shashwat singh on 11/04/25.
//

import Foundation
import HealthKit
import SwiftUI
extension HKWorkoutActivityType {
    var name: String {
        switch self {
        case .americanFootball:             return "American Football"
        case .archery:                      return "Archery"
        case .australianFootball:           return "Australian Football"
        case .badminton:                    return "Badminton"
        case .baseball:                     return "Baseball"
        case .basketball:                   return "Basketball"
        case .bowling:                      return "Bowling"
        case .boxing:                       return "Boxing"
        case .climbing:                     return "Climbing"
        case .crossTraining:                return "Cross Training"
        case .curling:                      return "Curling"
        case .cycling:                      return "Cycling"
        case .dance:                        return "Dance"
        case .danceInspiredTraining:        return "Dance Inspired Training"
        case .elliptical:                   return "Elliptical"
        case .equestrianSports:             return "Equestrian Sports"
        case .fencing:                      return "Fencing"
        case .fishing:                      return "Fishing"
        case .functionalStrengthTraining:   return "Functional Strength Training"
        case .golf:                         return "Golf"
        case .gymnastics:                   return "Gymnastics"
        case .handball:                     return "Handball"
        case .hiking:                       return "Hiking"
        case .hockey:                       return "Hockey"
        case .hunting:                      return "Hunting"
        case .lacrosse:                     return "Lacrosse"
        case .martialArts:                  return "Martial Arts"
        case .mindAndBody:                  return "Mind and Body"
        case .mixedMetabolicCardioTraining: return "Mixed Metabolic Cardio Training"
        case .paddleSports:                 return "Paddle Sports"
        case .play:                         return "Play"
        case .preparationAndRecovery:       return "Preparation and Recovery"
        case .racquetball:                  return "Racquetball"
        case .rowing:                       return "Rowing"
        case .rugby:                        return "Rugby"
        case .running:                      return "Running"
        case .sailing:                      return "Sailing"
        case .skatingSports:                return "Skating Sports"
        case .snowSports:                   return "Snow Sports"
        case .soccer:                       return "Soccer"
        case .softball:                     return "Softball"
        case .squash:                       return "Squash"
        case .stairClimbing:                return "Stair Climbing"
        case .surfingSports:                return "Surfing Sports"
        case .swimming:                     return "Swimming"
        case .tableTennis:                  return "Table Tennis"
        case .tennis:                       return "Tennis"
        case .trackAndField:                return "Track and Field"
        case .traditionalStrengthTraining:  return "Traditional Strength Training"
        case .volleyball:                   return "Volleyball"
        case .walking:                      return "Walking"
        case .waterFitness:                 return "Water Fitness"
        case .waterPolo:                    return "Water Polo"
        case .waterSports:                  return "Water Sports"
        case .wrestling:                    return "Wrestling"
        case .yoga:                         return "Yoga"

        // iOS 10
        case .barre:                        return "Barre"
        case .coreTraining:                 return "Core Training"
        case .crossCountrySkiing:           return "Cross Country Skiing"
        case .downhillSkiing:               return "Downhill Skiing"
        case .flexibility:                  return "Flexibility"
        case .highIntensityIntervalTraining:    return "High Intensity Interval Training"
        case .jumpRope:                     return "Jump Rope"
        case .kickboxing:                   return "Kickboxing"
        case .pilates:                      return "Pilates"
        case .snowboarding:                 return "Snowboarding"
        case .stairs:                       return "Stairs"
        case .stepTraining:                 return "Step Training"
        case .wheelchairWalkPace:           return "Wheelchair Walk Pace"
        case .wheelchairRunPace:            return "Wheelchair Run Pace"

        // iOS 11
        case .taiChi:                       return "Tai Chi"
        case .mixedCardio:                  return "Mixed Cardio"
        case .handCycling:                  return "Hand Cycling"

        // iOS 13
        case .discSports:                   return "Disc Sports"
        case .fitnessGaming:                return "Fitness Gaming"

        // Catch-all
        default:                            return "Other"
        }
    }
    var image: String {
        switch self {
        case .americanFootball: return              "football"
        case .archery: return                       "target"
        case .australianFootball: return            "sportscourt"
        case .badminton: return                     "tennis.racket"
        case .baseball: return                      "sportscourt"
        case .basketball: return                    "basketball"
        case .bowling: return                       "sportscourt"
        case .boxing: return                        "figure.boxing"
        case .climbing: return                      "figure.climbing"
        case .crossTraining: return                 "figure.strengthtraining.traditional"
        case .curling: return                       "sportscourt"
        case .cycling: return                       "bicycle"
        case .dance: return                         "music.note"
        case .danceInspiredTraining: return         "music.mic"
        case .elliptical: return                    "figure.elliptical"
        case .equestrianSports: return              "horse"
        case .fencing: return                       "shield"
        case .fishing: return                       "fish"
        case .functionalStrengthTraining: return    "dumbbell"
        case .golf: return                          "flag.2.crossed"
        case .gymnastics: return                    "figure.gymnastics"
        case .handball: return                      "hand.raised"
        case .hiking: return                        "figure.hiking"
        case .hockey: return                        "hockey.puck"
        case .hunting: return                       "scope"
        case .lacrosse: return                      "sportscourt"
        case .martialArts: return                   "figure.martial.arts"
        case .mindAndBody: return                   "brain.head.profile"
        case .mixedMetabolicCardioTraining: return  "flame"
        case .paddleSports: return                  "figure.rower"
        case .play: return                          "gamecontroller"
        case .preparationAndRecovery: return "      figure.cooldown"
        case .racquetball: return                   "sportscourt"
        case .rowing: return                        "figure.rower"
        case .rugby: return                         "sportscourt"
        case .running: return                       "figure.run"
        case .sailing: return                       "sailboat"
        case .skatingSports: return                 "figure.skating"
        case .snowSports: return                    "snowflake"
        case .soccer: return                        "soccerball"
        case .softball: return                      "sportscourt"
        case .squash: return                        "sportscourt"
        case .stairClimbing: return                 "figure.stairs"
        case .surfingSports: return                 "figure.surfing"
        case .swimming: return                      "figure.pool.swim"
        case .tableTennis: return                   "sportscourt"
        case .tennis: return                        "tennis.racket"
        case .trackAndField: return                 "figure.run"
        case .traditionalStrengthTraining: return   "dumbbell"
        case .volleyball: return                    "sportscourt"
        case .walking: return                       "figure.walk"
        case .waterFitness: return                  "drop"
        case .waterPolo: return                     "sportscourt"
        case .waterSports: return                   "drop.fill"
        case .wrestling: return                     "figure.wrestling"
        case .yoga: return                          "figure.yoga"
        case .barre: return                         "figure.cooldown"
        case .coreTraining: return                  "figure.core.training"
        case .crossCountrySkiing: return            "figure.skiing.crosscountry"
        case .downhillSkiing: return                "figure.skiing.downhill"
        case .flexibility: return                   "figure.flexibility"
        case .highIntensityIntervalTraining: return "flame.fill"
        case .jumpRope: return                      "figure.jump.rope"
        case .kickboxing: return                    "figure.kickboxing"
        case .pilates: return                       "figure.cooldown"
        case .snowboarding: return                  "figure.snowboarding"
        case .stairs: return                        "figure.stairs"
        case .stepTraining: return                  "figure.step.training"
        case .wheelchairWalkPace: return            "figure.roll"
        case .wheelchairRunPace: return             "figure.roll.running"
        case .taiChi: return                        "figure.tai.chi"
        case .mixedCardio: return                   "heart.fill"
        case .handCycling: return                   "figure.hand.cycling"
        case .discSports: return                    "sportscourt"
        case .fitnessGaming: return                 "gamecontroller.fill"
        default: return                             "questionmark"
        }
    }
    var color: Color {
        switch self {
        case .americanFootball: return .brown
        case .archery: return .green
        case .australianFootball: return .orange
        case .badminton: return .mint
        case .baseball: return .indigo
        case .basketball: return .orange
        case .bowling: return .gray
        case .boxing: return .red
        case .climbing: return .teal
        case .crossTraining: return .purple
        case .curling: return .cyan
        case .cycling: return .yellow
        case .dance: return .pink
        case .danceInspiredTraining: return .pink
        case .elliptical: return .blue
        case .equestrianSports: return .brown
        case .fencing: return .gray
        case .fishing: return .blue
        case .functionalStrengthTraining: return .purple
        case .golf: return .green
        case .gymnastics: return .teal
        case .handball: return .orange
        case .hiking: return .brown
        case .hockey: return .blue
        case .hunting: return .green
        case .lacrosse: return .indigo
        case .martialArts: return .red
        case .mindAndBody: return .mint
        case .mixedMetabolicCardioTraining: return .pink
        case .paddleSports: return .blue
        case .play: return .yellow
        case .preparationAndRecovery: return .gray
        case .racquetball: return .purple
        case .rowing: return .cyan
        case .rugby: return .red
        case .running: return .orange
        case .sailing: return .teal
        case .skatingSports: return .blue
        case .snowSports: return .white
        case .soccer: return .green
        case .softball: return .yellow
        case .squash: return .indigo
        case .stairClimbing: return .gray
        case .surfingSports: return .blue
        case .swimming: return .cyan
        case .tableTennis: return .mint
        case .tennis: return .green
        case .trackAndField: return .red
        case .traditionalStrengthTraining: return .purple
        case .volleyball: return .orange
        case .walking: return .blue
        case .waterFitness: return .blue
        case .waterPolo: return .teal
        case .waterSports: return .cyan
        case .wrestling: return .red
        case .yoga: return .purple
        case .barre: return .mint
        case .coreTraining: return .indigo
        case .crossCountrySkiing: return .white
        case .downhillSkiing: return .blue
        case .flexibility: return .mint
        case .highIntensityIntervalTraining: return .pink
        case .jumpRope: return .yellow
        case .kickboxing: return .red
        case .pilates: return .gray
        case .snowboarding: return .white
        case .stairs: return .gray
        case .stepTraining: return .purple
        case .wheelchairWalkPace: return .blue
        case .wheelchairRunPace: return .blue
        case .taiChi: return .mint
        case .mixedCardio: return .pink
        case .handCycling: return .yellow
        case .discSports: return .orange
        case .fitnessGaming: return .green
        default: return .gray
        }
    }

}
