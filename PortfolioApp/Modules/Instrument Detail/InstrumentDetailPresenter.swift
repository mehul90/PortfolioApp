//
//  InstrumentDetailPresenter.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/21/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol InstrumentDetailViewOutput {
    func viewDidLoad()
}

protocol InstrumentDetailInteractorOutput: class {
    func updateWithData(chartPoints: [Double])
    func showError(withMessage message: String)
}

final class InstrumentDetailPresenter: InstrumentDetailViewOutput, InstrumentDetailInteractorOutput {
    weak var view: InstrumentDetailViewInput?
    var interactor: InstrumentDetailInteractorInput!
    var router: InstrumentDetailRouterInput!

    var instrumentDataModel: InstrumentCellDataModel!

    func viewDidLoad() {
        view?.showTitle(withString: "\(instrumentDataModel.instrumentName)\n\(instrumentDataModel.instrumentCode) - NASDAQ")
        view?.showLoadingIndicator()
        interactor.fetchYearlyPrices(forInstrumentCode: instrumentDataModel.instrumentCode)
    }
    
    //MARK:-
    func updateWithData(chartPoints: [Double]) {
        view?.hideLoadingIndicator()
        //handle by another data model.
        let price = (Double(instrumentDataModel.instrumentValue.dropFirst()) ?? 0.0) / 100
        view?.setSharePrice(price: String(format: "$%.2f", price))
        view?.setPriceChange(attributedText: instrumentDataModel.priceChange)
        view?.updateChart(withValues: chartPoints)
    }
    
    func showError(withMessage message: String) {
        view?.showErrorMesage(message: message)
    }
}
