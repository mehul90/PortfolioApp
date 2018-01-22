//
//  PortfolioCoordinator.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol PortfolioRouterInput {
    func presentDetails(forInstrument instrument: InstrumentCellDataModel) //use seperate data model.
}

final class PortfolioRouter {
    weak var viewController: PortfolioViewController!

}

extension PortfolioRouter: PortfolioRouterInput {
    func presentDetails(forInstrument instrument: InstrumentCellDataModel) {
        let detailsPage = InstrumentDetailBuilder.build(withDataModel: instrument)
        viewController.navigationController?.pushViewController(detailsPage, animated: true)
    }
}
