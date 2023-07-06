//
//  NewTaskModuleBuilder.swift
//  simbirsoft
//
//  Created by Рустем on 06.07.2023.
//

import UIKit

class NewTaskModuleBuilder: UIViewController {
    static func build() -> NewTaskViewController {
        let interactor = NewTaskInteractor()
        let router = NewTaskRouter()
        let presenter = NewTaskPresenter(router: router, interactor: interactor)
        let viewController = NewTaskViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}
