//
//  dataManager.swift
//  Gym
//
//  Created by shashwat singh on 14/04/25.
//


import Foundation

struct dataManager{
    static func sourceofTruth(_ userInput: String, completion: @escaping (String?) -> Void) {
        let apiKey = "AIzaSyAAA6hGpYM-tIq0Fj_ZoRlotMLjTXdjvxY"
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "contents": [
                ["parts": [["text": userInput]]]
            ]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Error encoding JSON: \(error)")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error:", error.localizedDescription)
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response JSON:", json)
                    if let candidates = json["candidates"] as? [[String: Any]],
                       let firstCandidate = candidates.first,
                       let content = firstCandidate["content"] as? [String: Any],
                       let parts = content["parts"] as? [[String: Any]],
                       let firstPart = parts.first,
                       let responseText = firstPart["text"] as? String {
                        completion(responseText)
                        return
                    }
                }
                print("Unexpected JSON structure")
                completion(nil)
            } catch {
                print("Error decoding JSON:", error)
                completion(nil)
            }
        }

        task.resume()
    }

}
struct Data{
    var problem: String
    var solution: String
}

