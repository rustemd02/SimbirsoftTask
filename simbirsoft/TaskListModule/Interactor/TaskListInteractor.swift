//
//  TaskListInteractor.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import Foundation

protocol TaskListInteractorProtocol: AnyObject {
    func formatRowToTime(row: String) -> String
    func getTaskByHour(indexpath: IndexPath) -> Task?
    func getTasksForSelectedDay(selectedDate: Date) -> [Task]
    func getDateString(date: Date) -> String
}

class TaskListInteractor {
    weak var presenter: TaskListPresenterProtocol?
    private var networkService: NetworkServiceProtocol
    private var databaseService: DatabaseServiceProtocol
    private var tasksForSelectedDay: [Task] = []
    
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared, databaseService: DatabaseServiceProtocol = DatabaseService.shared) {
        self.networkService = networkService
        self.databaseService = databaseService
    }
}

extension TaskListInteractor: TaskListInteractorProtocol {
    func getDateString(date: Date) -> String {
        let regex = try! NSRegularExpression(pattern: "\\d{4}")
        let dateString = date.description(with: Locale(identifier: "ru_RU"))
        let matches = regex.matches(in: dateString, range: NSRange(location: 0, length: dateString.count))

        if let match = matches.first {
            let range = match.range
            var substring = (dateString as NSString).substring(to: range.location)
            substring = substring.trimmingCharacters(in: .whitespacesAndNewlines)
            return substring
        }
        return ""
    }
    
    func formatRowToTime(row: String) -> String {
        var editedPart = row
        if editedPart.count == 1 {
            editedPart.insert("0", at: editedPart.startIndex)
        }
        editedPart.append(":00")
        return editedPart
    }
  
    
    func getTasksForSelectedDay(selectedDate: Date) -> [Task] {
        if tasksForSelectedDay.isEmpty && databaseService.isEmpty() {
            tasksForSelectedDay = networkService.loadFromJson(selectedDate: selectedDate)
            return tasksForSelectedDay
        }
        tasksForSelectedDay = databaseService.getTasksByDayFromRealm(selectedDate: selectedDate)
        return tasksForSelectedDay

    }
    
    func getTaskByHour(indexpath: IndexPath) -> Task? {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        guard let date = dateFormatter.date(from: formatRowToTime(row: indexpath.row.description)) else { return nil }
        let currentHour = calendar.component(.hour, from: date)
        for task in tasksForSelectedDay {
            guard let startDate = task.startDate, let finishDate = task.finishDate else { return nil }
            let taskStartHour = calendar.component(.hour, from: startDate)
            let taskFinishHour = calendar.component(.hour, from: finishDate)
            if currentHour >= taskStartHour && currentHour <= taskFinishHour {
                return task
            }
        }
        return nil
    }
}
