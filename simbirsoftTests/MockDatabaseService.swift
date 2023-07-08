//
//  MockDatabaseService.swift
//  simbirsoftTests
//
//  Created by Рустем on 08.07.2023.
//

import Foundation
import Realm
@testable import simbirsoft


class MockDatabaseService: DatabaseServiceProtocol {
    func saveToRealm<T>(object: T) -> Error? where T : RealmSwiftObject {
        return NSError()
    }
    
    func getTasksByDayFromRealm(selectedDate: Date) -> [simbirsoft.Task] {
        var tasks: [Task] = []
        let task = Task()
        task.id = 1
        task.name = "Название"
        task.dateStart = TimeInterval(integerLiteral: 1688814252)
        task.dateFinish = TimeInterval(integerLiteral: 1688815252)
        task.taskDescription = "Описание"
        tasks.append(task)
        return tasks
    }
    
    func isEmpty() -> Bool {
        return true
    }
    
    
}
