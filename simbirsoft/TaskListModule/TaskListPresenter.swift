//
//  TaskListPresenter.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import Foundation

protocol TaskListPresenterProtocol: AnyObject {
    func formatToTimeInterval(row: String) -> String
    func getTaskByHour(indexpath: IndexPath) -> Task?
    func getTasksForSelectedDay(selectedDate: Date) -> [Task]
}

class TaskListPresenter {
    
    weak var view: TaskListViewControllerProtocol?
    let router: TaskListRouterProtocol
    let interactor: TaskListInteractorProtocol
    
    init(router: TaskListRouterProtocol, interactor: TaskListInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension TaskListPresenter: TaskListPresenterProtocol {
    func getTaskByHour(indexpath: IndexPath) -> Task? {
        return interactor.getTaskByHour(indexpath: indexpath)
    }
    
    func formatToTimeInterval(row: String) -> String {
        return interactor.formatToTimeInterval(row: row)
    }
    
    func getTasksForSelectedDay(selectedDate: Date) -> [Task] {
        return interactor.getTasksForSelectedDay(selectedDate: selectedDate)
    }
    
    
    
    
}
