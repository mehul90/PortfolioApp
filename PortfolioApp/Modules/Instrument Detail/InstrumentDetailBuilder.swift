//
//  InstrumentDetailBuilder.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/21/18.
//  Copyright © 2018 mp. All rights reserved.
//

import UIKit

final class InstrumentDetailBuilder {
    
    static func build(withDataModel dataModel: InstrumentCellDataModel) -> UIViewController {
        let controller = InstrumentDetailViewController()
        let presenter = InstrumentDetailPresenter()
        presenter.view = controller
        let interactor = InstrumentDetailInteractor()
        let router = InstrumentDetailRouter()
        router.viewController = controller
        presenter.router = router
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.instrumentDataModel = dataModel
        controller.output = presenter
        return controller
    }
}
