//
//  PortfolioService.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

protocol PortfolioService {
    func fetchLatestPricesForInstruments(instruments: [String], completion: @escaping ((PortfolioResponse) -> ()))
    
    func fetchYearlyPrices(forInstrumentCode code:String, completion: @escaping ((InstrumentDetailResponse) -> ()))

}

//Just for unit testing
protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
