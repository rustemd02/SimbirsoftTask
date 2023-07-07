//
//  NewTaskPresenter.swift
//  simbirsoft
//
//  Created by Рустем on 06.07.2023.
//

import Foundation

protocol NewTaskPresenterProtocol: AnyObject {
    func formatDateToCompact(date: Date) -> String
    func formatTimeToCompact(date: Date) -> String
    func ifNewTaskHasCollisions(startTime: Date, finishTime: Date, date: Date) -> Bool
    func saveTask(title: String, startTime: Date, finishTime: Date, description: String?) -> Bool

}

class NewTaskPresenter {
    weak var view: NewTaskViewControllerProtocol?
    let interactor: NewTaskInteractorProtocol
    let router: NewTaskRouterProtocol
    
    init(router: NewTaskRouterProtocol, interactor: NewTaskInteractorProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension NewTaskPresenter: NewTaskPresenterProtocol {
    func ifNewTaskHasCollisions(startTime: Date, finishTime: Date, date: Date) -> Bool {
        return interactor.ifNewTaskHasCollisions(newTaskStartTime: startTime, newTaskFinishTime: finishTime, date: date)
    }
    
    func formatDateToCompact(date: Date) -> String {
        return interactor.formatDateToCompact(date: date)
    }
    
    func formatTimeToCompact(date: Date) -> String {
        return interactor.formatTimeToCompact(date: date)
    }

    func saveTask(title: String, startTime: Date, finishTime: Date, description: String?) -> Bool {
        return interactor.saveTask(title: title, startTime: startTime, finishTime: finishTime, description: description)
    }
    
}
