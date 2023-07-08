//
//  Task.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import Foundation
import RealmSwift

struct ResponseData: Decodable {
    var task: [Task]
}

class Task: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var dateStart: TimeInterval = 0
    @objc dynamic var dateFinish: TimeInterval = 0
    @objc dynamic var name: String = ""
    @objc dynamic var taskDescription: String = ""

    enum CodingKeys: String, CodingKey {
        case id, name
        case taskDescription = "description"
        case dateStart = "date_start"
        case dateFinish = "date_finish"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        taskDescription = try container.decode(String.self, forKey: .taskDescription)
        dateStart = try container.decode(TimeInterval.self, forKey: .dateStart)
        dateFinish = try container.decode(TimeInterval.self, forKey: .dateFinish)
    }

    override static func primaryKey() -> String? {
        return "id"
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
            
            let realm = try Realm()
            
            try realm.write {
                //realm.deleteAll()
                for task in jsonData.task {
                    if realm.object(ofType: Task.self, forPrimaryKey: task.id) == nil {
                        realm.add(task)
                        print(task.name + " добавлен в Realm")
                    }
                }
            }

            return jsonData.task
            
        } catch {
            print("Error: \(error)")
        }

    }
    return nil
}



