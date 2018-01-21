//
//  PortfolioCoordinator.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol PortfolioRouterInput {
    
}

final class PortfolioRouter {
    
    lazy var viewController: PortfolioViewController = {
        
        let controller = PortfolioViewController()
        controller.title = "Portfolio"
        let presenter = PortfolioPresenter()
        presenter.view = controller
        presenter.coordinator = self
        let interactor = PortfolioInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        controller.output = presenter
        return controller
    }()
}

extension PortfolioRouter: PortfolioRouterInput {}
