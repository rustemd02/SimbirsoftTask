//
//  TaskListPresenter.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import Foundation

protocol TaskListPresenterProtocol: AnyObject {
    func getDateString(date: Date) -> String
    func formatRowToTime(row: String) -> String
    func getTaskByHour(indexpath: IndexPath) -> Task?
    func getTasksForSelectedDay(selectedDate: Date) -> [Task]
    
    func presentDetailView(task: Task)
    func presentNewTaskView(for date: Date)
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
    func presentNewTaskView(for date: Date) {
        router.createNewTask(for: date)
    }
    
    func getDateString(date: Date) -> String {
        return interactor.getDateString(date: date)
    }
    
    func getTaskByHour(indexpath: IndexPath) -> Task? {
        return interactor.getTaskByHour(indexpath: indexpath)
    }
    
    func formatRowToTime(row: String) -> String {
        return interactor.formatRowToTime(row: row)
    }
    
    func getTasksForSelectedDay(selectedDate: Date) -> [Task] {
        return interactor.getTasksForSelectedDay(selectedDate: selectedDate)
    }
    
    func presentDetailView(task: Task) {
        router.presentDetailView(task: task)
    }
    
    
    
}
