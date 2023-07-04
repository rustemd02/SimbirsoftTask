//
//  TaskDetailModuleBuilder.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import UIKit

class TaskDetailModuleBuilder: UIViewController {
    static func build() -> TaskDetailViewController {
        let interactor = TaskDetailInteractor()
        let router = TaskDetailRouter()
        let presenter = TaskDetailPresenter(router: router, interactor: interactor)
        let viewController = TaskDetailViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}
