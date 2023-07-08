//
//  NetworkService.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func loadFromJson(selectedDate: Date) -> [Task]
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    
    //TODO: на первом запуске json, потом уже с realm
    func loadFromJson(selectedDate: Date) -> [Task] {
        let calendar = Calendar.current
        if let tasks = loadJson(filename: "tasks") {
            let filteredTasks = tasks.filter { task in
                guard let startDate = task.startDate, let finishDate = task.finishDate else { return false }
                return calendar.isDate(selectedDate, inSameDayAs: startDate) || calendar.isDate(selectedDate, inSameDayAs: finishDate)
            }
            return filteredTasks
        }
        return []
    }
}
