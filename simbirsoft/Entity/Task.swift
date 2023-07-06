//
//  Task.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import Foundation

struct ResponseData: Decodable {
    var task: [Task]
}

struct Task: Codable {
    let id: Int
    let dateStart, dateFinish: TimeInterval
    let name, description: String

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case dateStart = "date_start"
        case dateFinish = "date_finish"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        dateStart = try container.decode(TimeInterval.self, forKey: .dateStart)
        dateFinish = try container.decode(TimeInterval.self, forKey: .dateFinish)
    }
    
    var startDate: Date? {
        return Date(timeIntervalSince1970: dateStart)
    }
    
    var finishDate: Date? {
        return Date(timeIntervalSince1970: dateFinish)
    }
}

func loadJson(filename fileName: String) -> [Task]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let jsonData = try decoder.decode(ResponseData.self, from: data)
            return jsonData.task
        } catch {
            print("Error: \(error)")
        }
    }
    return nil
}

