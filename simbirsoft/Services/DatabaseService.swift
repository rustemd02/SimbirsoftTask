//
//  DatabaseService.swift
//  simbirsoft
//
//  Created by Рустем on 06.07.2023.
//

import Foundation
import RealmSwift

class DatabaseService {
    static let shared = DatabaseService()
    
    func saveToRealm<T: Object>(object: T) -> Error? {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
                print("Сохранено в Realm")
            }
        } catch {
            return error
        }
        return nil
    }
    
    func getTasksByDayFromRealm(selectedDate: Date) -> [Task] {
        do {
            let calendar = Calendar.current
            let realm = try Realm()
            let tasks = realm.objects(Task.self)
            let filteredTasks = tasks.filter { task in
                guard let startDate = task.startDate, let finishDate = task.finishDate else { return false }
                return calendar.isDate(selectedDate, inSameDayAs: startDate) || calendar.isDate(selectedDate, inSameDayAs: finishDate)
            }
            return Array(filteredTasks)
        } catch {
            print(error)
        }
        return []
    }
    
    func isEmpty() -> Bool {
        do {
            let realm = try Realm()
            let tasks = realm.objects(Task.self)
            return tasks.isEmpty
        } catch {
            print(error)
        }
        return true
    }
}
