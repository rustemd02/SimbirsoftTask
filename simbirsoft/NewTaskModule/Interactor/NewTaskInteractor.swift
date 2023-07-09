//
//  NewTaskInteractor.swift
//  simbirsoft
//
//  Created by Рустем on 06.07.2023.
//

import Foundation
import RealmSwift

protocol NewTaskInteractorProtocol: AnyObject {
    func formatDateToCompact(date: Date) -> String
    func formatTimeToCompact(date: Date) -> String
    func ifNewTaskHasCollisions(newTaskStartTime: Date, newTaskFinishTime: Date, date: Date) -> Bool
    func ifTasksFinishesBeforeStarts(newTaskStartTime: Date, newTaskFinishTime: Date) -> Bool
    func ifTaskLastsLessThanHour(newTaskStartTime: Date, newTaskFinishTime: Date) -> Bool
    func saveTask(title: String, startTime: Date, finishTime: Date, description: String?) -> Bool
    
}

class NewTaskInteractor {
    weak var presenter: NewTaskPresenterProtocol?
}

extension NewTaskInteractor: NewTaskInteractorProtocol {
    func ifNewTaskHasCollisions(newTaskStartTime: Date, newTaskFinishTime: Date, date: Date) -> Bool {
        let tasks = DatabaseService.shared.getTasksByDayFromRealm(selectedDate: date)
        for task in tasks {
            guard let taskStartTime = task.startDate, let taskFinishTime = task.finishDate else { return true }
            if taskStartTime <= newTaskFinishTime && taskFinishTime >= newTaskStartTime {
                return true
            }
        }
        
        return false
    }

    func ifTasksFinishesBeforeStarts(newTaskStartTime: Date, newTaskFinishTime: Date) -> Bool {
        if newTaskStartTime > newTaskFinishTime {
            return true
        }
        return false
    }
    
    func ifTaskLastsLessThanHour(newTaskStartTime: Date, newTaskFinishTime: Date) -> Bool {
        let calendar = Calendar.current
        let taskStartHour = calendar.component(.hour, from: newTaskStartTime)
        let taskFinishHour = calendar.component(.hour, from: newTaskFinishTime)
        
        let comparisonResult = newTaskFinishTime.timeIntervalSince1970 - newTaskStartTime.timeIntervalSince1970
        
        if comparisonResult < 3600 && taskStartHour == taskFinishHour {
            return true
        }
        return false
        
    }
 
    func formatTimeToCompact(date: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        let hourString = String(format: "%02d", hour)
        let minuteString = String(format: "%02d", minute)
        
        return hourString + ":" + minuteString
    }
    
    func formatDateToCompact(date: Date) -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        
        let dayString = String(format: "%02d", day)
        let monthString = String(format: "%02d", month)
        
        return dayString + "." + monthString
    }
    
    func saveTask(title: String, startTime: Date, finishTime: Date, description: String?) -> Bool {
        let task = Task()
        task.id = Int(arc4random_uniform(UInt32.max))
        task.name = title
        task.taskDescription = description ?? "У дела нет описания"
        task.dateStart = startTime.timeIntervalSince1970
        task.dateFinish = finishTime.timeIntervalSince1970

        if let error = DatabaseService.shared.saveToRealm(object: task) {
            print(error)
            return false
        }
        return true
    }
}
