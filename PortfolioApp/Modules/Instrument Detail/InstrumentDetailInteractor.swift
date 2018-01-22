//
//  InstrumentDetailInteractor.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/21/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

protocol InstrumentDetailInteractorInput {
    func fetchYearlyPrices(forInstrumentCode code:String)
}

final class InstrumentDetailInteractor: InstrumentDetailInteractorInput {
    weak var output: InstrumentDetailInteractorOutput?
    let service: PortfolioService
    
    init(service: PortfolioService = PortfolioServiceBuilder().build()) {
        self.service = service
    }
    
    func fetchYearlyPrices(forInstrumentCode code: String) {
        DispatchQueue.global().async {
            self.service.fetchYearlyPrices(forInstrumentCode: code, completion: { response in
                DispatchQueue.main.async {
                    switch response.status {
                    case .success(listViewModel: let responseModel):
                        let points = responseModel.dataset.data.map{$0.value}
                        self.output?.updateWithData(chartPoints: Array(points.reversed()))
                    default:
                        self.output?.showError(withMessage: "Error !!")
                    }
                }
            })
        }
    }
    
}
