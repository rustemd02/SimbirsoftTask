//
//  TaskDetailPresenter.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import Foundation

protocol TaskDetailPresenterProtocol: AnyObject {
    func getTimeFromDate(date: Date) -> String
}

class TaskDetailPresenter {
    weak var view: TaskDetailViewControllerProtocol?
    let router: TaskDetailRouterProtocol
    let interactor: TaskDetailInteractorProtocol
    
    init(router: TaskDetailRouterProtocol, interactor: TaskDetailInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension TaskDetailPresenter: TaskDetailPresenterProtocol {
    func getTimeFromDate(date: Date) -> String {
        return interactor.getTimeFromDate(date: date)
    }
    
    
}
