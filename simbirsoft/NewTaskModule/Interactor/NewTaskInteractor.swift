//
//  NewTaskInteractor.swift
//  simbirsoft
//
//  Created by Рустем on 06.07.2023.
//

import Foundation

protocol NewTaskInteractorProtocol: AnyObject {
    func formatDateToCompact(date: Date) -> String
    func formatTimeToCompact(date: Date) -> String
    func ifNewTaskHasCollisions(newTaskStartTime: Date, newTaskFinishTime: Date, date: Date) -> Bool
    
}

class NewTaskInteractor {
    weak var presenter: NewTaskPresenterProtocol?
}

extension NewTaskInteractor: NewTaskInteractorProtocol {
    func ifNewTaskHasCollisions(newTaskStartTime: Date, newTaskFinishTime: Date, date: Date) -> Bool {
        let tasks = NetworkService.shared.getTasksByDay(selectedDate: date)
        for task in tasks {
            guard let taskStartTime = task.startDate, let taskFinishTime = task.finishDate else { return true }
            if taskStartTime <= newTaskFinishTime && taskFinishTime >= newTaskStartTime {
                return true
            }
        }
        
        return false
    }

    
 
    func formatTimeToCompact(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        if let date = dateFormatter.date(from: date.description) {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            
            let hourString = String(format: "%02d", hour)
            let minuteString = String(format: "%02d", minute)
            
            return hourString + ":" + minuteString
        }
        return ""
    }
    
    func formatDateToCompact(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        if let date = dateFormatter.date(from: date.description) {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            
            let dayString = String(format: "%02d", day)
            let monthString = String(format: "%02d", month)
            
            return dayString + "." + monthString
        }
        return "сегодня"
    }
}