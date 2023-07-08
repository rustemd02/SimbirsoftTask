//
//  TaskListRouter.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import Foundation

protocol TaskListRouterProtocol: AnyObject {
    func presentDetailView(task: Task)
    func createNewTask(for date: Date)
}

class TaskListRouter: TaskListRouterProtocol {
    weak var view: TaskListViewController?
    
    func presentDetailView(task: Task) {
        let vc = TaskDetailModuleBuilder.build()
        vc.task = task
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func createNewTask(for date: Date) {
        let vc = NewTaskModuleBuilder.build()
        vc.date = date
        vc.delegate = view
        view?.present(vc, animated: true)
    }
}
