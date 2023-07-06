//
//  TaskDetailInteractor.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import Foundation

protocol TaskDetailInteractorProtocol: AnyObject {
    func getTimeFromDate(date: Date) -> String
}

class TaskDetailInteractor {
    weak var presenter: TaskDetailPresenterProtocol?
    
}

extension TaskDetailInteractor: TaskDetailInteractorProtocol {
    func getTimeFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: date)
        return timeString

    }
    
    
}
