//
//  MockNetworkService.swift
//  simbirsoftTests
//
//  Created by Рустем on 08.07.2023.
//

import Foundation
@testable import simbirsoft

class MockNetworkService: NetworkServiceProtocol {
    func loadFromJson(selectedDate: Date) -> [simbirsoft.Task] {
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
    
    
}
