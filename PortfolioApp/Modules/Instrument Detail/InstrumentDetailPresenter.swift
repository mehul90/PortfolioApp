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
    func updateWithData()
}

final class InstrumentDetailPresenter: InstrumentDetailViewOutput, InstrumentDetailInteractorOutput {
    weak var view: InstrumentDetailViewInput?
    var interactor: InstrumentDetailInteractorInput!
    var router: InstrumentDetailRouterInput!

    var instrumentDataModel: InstrumentCellDataModel!

    func viewDidLoad() {
        view?.showTitle(withString: "\(instrumentDataModel.instrumentName)\n\(instrumentDataModel.instrumentCode) - NASDAQ")
        view?.showLoadingIndicator()
        
        updateWithData()//TODO: 
        
    }
    
    //MARK:-
    func updateWithData() {
        view?.hideLoadingIndicator()
        view?.setSharePrice(price: instrumentDataModel.instrumentValue)
        view?.setPriceChange(attributedText: instrumentDataModel.priceChange)
    }
}
