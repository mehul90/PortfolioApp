//
//  PortfolioPresenter.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol PortfolioViewOutput {
    func viewDidLoad()
    func viewDidAppear()
    func selectedInstrumentAtIndex(index: Int)
    var instrumentsDataModels: [InstrumentCellDataModel] {get}
}

protocol PortfolioInteractorOutput: class {
    func update(withDataModels dataModels: [InstrumentCellDataModel])
    func update(header portfolioValue:String, gainLoss: Double, percentage: Double)
    func showError(withMessage message: String)
}

final class PortfolioPresenter: PortfolioViewOutput, PortfolioInteractorOutput {
    weak var view: PortfolioViewInput?
    var interactor: PortfolioInteractorInput!
    var router: PortfolioRouterInput!

    var instrumentsDataModels: [InstrumentCellDataModel] = []
    
    func viewDidLoad() {
        view?.showLoadingIndicator()
    }
    
    func viewDidAppear() {
        interactor.fetchAllInstruments()
    }
    
    //MARK:-
    
    func selectedInstrumentAtIndex(index: Int) {
        router.presentDetails(forInstrument: instrumentsDataModels[index])
    }
    
    func update(withDataModels dataModels: [InstrumentCellDataModel]) {
        instrumentsDataModels = dataModels
        view?.hideLoadingIndicator()
        view?.reloadTableView()
    }
    
    func update(header portfolioValue: String, gainLoss: Double, percentage: Double) {
        view?.updatePortfolioValue(with: portfolioValue)
        
        let priceChangeAttributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : UIColor.lightGray,
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        let priceChangeAttributedString = NSMutableAttributedString(string: "Today's gain/loss: ", attributes: priceChangeAttributes)
        let appGreen = UIColor(red:0.42, green:0.74, blue:0.06, alpha:1.0)
        let percentagePriceChangeAttributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : percentage > 0 ? appGreen : UIColor.red,
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        
        let priceChangePrefix = percentage >= 0 ? "+" : ""

        let percentagePriceChangeAttributedString = NSMutableAttributedString(string: String(format: "%@%.2f(%.2f%)", priceChangePrefix, gainLoss, percentage), attributes: percentagePriceChangeAttributes)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(priceChangeAttributedString)
        mutableAttributedString.append(percentagePriceChangeAttributedString)
        view?.updateGainLossLabel(with: mutableAttributedString)
    }
    
    func showError(withMessage message: String) {
        view?.showErrorMesage(message: message)
    }
}
