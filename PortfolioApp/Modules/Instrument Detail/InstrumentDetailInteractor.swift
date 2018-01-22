//
//  InstrumentDetailInteractor.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/21/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation
import CoreLocation

protocol InstrumentDetailInteractorInput {

}

final class InstrumentDetailInteractor: InstrumentDetailInteractorInput {
    weak var output: InstrumentDetailInteractorOutput?
    let service: PortfolioService

    init(service: PortfolioService = PortfolioServiceBuilder().build()) {
        self.service = service
    }
    
}
