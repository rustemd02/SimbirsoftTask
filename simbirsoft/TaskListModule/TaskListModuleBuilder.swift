//
//  TaskListModuleBuilder.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import UIKit

class TaskListModuleBuilder: UIViewController {
    static func build() -> TaskListViewController {
        let interactor = TaskListInteractor()
        let router = TaskListRouter()
        let presenter = TaskListPresenter(router: router, interactor: interactor)
        let viewController = TaskListViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}
