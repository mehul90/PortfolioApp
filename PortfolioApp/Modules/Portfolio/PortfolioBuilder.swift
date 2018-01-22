//
//  PortfolioBuilder.swift
//  PortfolioApp
//
//  Created by Mehul Parmar on 1/20/18.
//  Copyright © 2018 mp. All rights reserved.
//

import UIKit

final class PortfolioBuilder {
    
    static func build() -> UIViewController {
        let controller = PortfolioViewController()
        controller.title = "Portfolio"
        let presenter = PortfolioPresenter()
        presenter.view = controller
        let interactor = PortfolioInteractor()
        let router = PortfolioRouter()
        router.viewController = controller
        presenter.router = router
        interactor.output = presenter
        presenter.interactor = interactor
        controller.output = presenter
        return controller
    }
}

