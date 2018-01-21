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
    func viewWillAppear()
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
    var coordinator: PortfolioRouterInput!

    var instrumentsDataModels: [InstrumentCellDataModel] = []
    
    func viewDidLoad() {
        view?.showLoadingIndicator()
    }
    
    func viewWillAppear() {
        interactor.fetchAllInstruments()
    }
    
    //MARK:-
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
        
        let percentagePriceChangeAttributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : percentage > 0 ? UIColor.green : UIColor.red,
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
