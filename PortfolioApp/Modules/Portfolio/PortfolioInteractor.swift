//
//  PortfolioInteractor.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol PortfolioInteractorInput {
    func fetchAllInstruments()
}

struct Instrument {
    let code: String
    let name: String
    let quantity: Int
}

final class PortfolioInteractor: PortfolioInteractorInput {
    weak var output: PortfolioInteractorOutput?
    let service: PortfolioService
    let portfolioHoldings: [Instrument]
    
    init(service: PortfolioService = PortfolioServiceBuilder().build()) {
        self.service = service
        portfolioHoldings = [Instrument(code: "FB",name: "Facebook", quantity: 100),
                             Instrument(code: "PG",name: "Proctor and Gamble",  quantity: 100),
                             Instrument(code: "KO",name: "Coco Cola",  quantity: 100),
                             Instrument(code: "GS",name: "Goldman Sachs",  quantity: 100),
                             Instrument(code: "JPM",name: "JP Morgan",  quantity: 100)]
    }
    
    func fetchAllInstruments() {
        //storage.getInstrumentList()  //gives name, quantity.
        
        //        self.output?.updateWithResponse(response: PortfolioResponse(status: .failure(error: PortfolioServiceError.genericError)))
        
        let instrumentCodes = portfolioHoldings.map {return $0.code}
        
        self.service.fetchLatestPricesForInstruments(instruments: instrumentCodes) { response in
            DispatchQueue.main.async {
                switch response.status {
                case .success(listViewModel: let responseModel):
                    self.output?.update(withDataModels: self.viewModel(fromResponse: responseModel))
                    
                    //TODO: calculate portfolio value, gain/loss, percentage gain loss.
                    self.output?.update(header: "$68864.00", gainLoss: 373.445, percentage: 0.43)
                    break
                default:
                    break
                }
            }
        }
    }
    
    private func viewModel(fromResponse response: [(PortfolioResponseModel, String)])-> [InstrumentCellDataModel] {
        var dataCells: [InstrumentCellDataModel] = []
        
        for instrument in response {
            let lastValue = instrument.0.dataset.data.first?.value ?? 0
            let previousValue = instrument.0.dataset.data[1].value
            let priceChangeString = priceChangeMutableString(forLastValue: lastValue, previousValue: previousValue)
            
            let firstMatchingInstrument = portfolioHoldings.first(where: {
                $0.code == instrument.1
            })
            
            if let matchingInstrument = firstMatchingInstrument {
                let instrumentValue = lastValue * Double(matchingInstrument.quantity)
                let cellDataModel = InstrumentCellDataModel(instrumentCode: matchingInstrument.code,
                                                            instrumentName: matchingInstrument.name,
                                                            instrumentValue: String(format: "$%.2f", instrumentValue),
                                                            priceChange: priceChangeString)
                dataCells.append(cellDataModel)
            }
        }
        return dataCells
    }
    
    private func priceChangeMutableString(forLastValue lastValue: Double, previousValue: Double) -> NSMutableAttributedString {
        let priceDiff = lastValue - previousValue
        let percentagePriceDiff = (priceDiff/previousValue)*100
        
        let priceChangePrefix = priceDiff >= 0 ? "+" : "-"
        
        let priceChangeAttributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : UIColor.lightGray,
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        let priceChangeAttributedString = NSMutableAttributedString(string: String(format: "%@ %.2f\n", priceChangePrefix, abs(priceDiff)), attributes: priceChangeAttributes)
        
        let percentagePriceChangeAttributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : priceDiff >= 0 ? UIColor.green : UIColor.red,
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        let percentagePriceChangeAttributedString = NSMutableAttributedString(string: String(format: "(%.2f%%)", percentagePriceDiff), attributes: percentagePriceChangeAttributes)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(priceChangeAttributedString)
        mutableAttributedString.append(percentagePriceChangeAttributedString)
        return mutableAttributedString
    }
    
}
