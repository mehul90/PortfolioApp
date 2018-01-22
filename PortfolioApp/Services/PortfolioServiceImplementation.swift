//
//  PortfolioServiceImplementation.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

enum PortfolioServiceError: Error {
    case genericError
}

final class PortfolioServiceImplementation: PortfolioService {


    let session: URLSessionProtocol
    
    private let baseURLString: String
    private let APIKey: String
    private let APITodayEndpoint = "Portfolio?"
    private let APIDataSetEndpoint = "datasets/WIKI/"

    init(baseURLString: String, APIKey: String, session: URLSessionProtocol) {
        self.baseURLString = baseURLString
        self.APIKey = APIKey
        self.session = session
    }
    
    //MARK:-
    
    func fetchLatestPricesForInstruments(instruments: [String], completion: @escaping ((PortfolioResponse) -> ())) {
        
        let dispatchGroup = DispatchGroup()
        var allResponses: [(PortfolioResponseModel, String)?] = Array(repeating: nil, count: instruments.count)
        
        for instrument in instruments.enumerated() {
            
            dispatchGroup.enter()
            
            let requestURL = URLForInstrument(instrument: instrument.element)
            guard let requestURLForInstrument = requestURL else {
                return
            }
            DispatchQueue.global().async {
                
                let task = self.session.dataTask(with: requestURLForInstrument) { (data, response, error) in
                    guard let data = data else {
                        completion(PortfolioResponse(status: .failure(error: PortfolioServiceError.genericError)))
                        dispatchGroup.leave()
                        return
                    }
                    
                    do {
                        let response: PortfolioResponseModel = try JSONDecoder().decode(PortfolioResponseModel.self, from: data)
                        allResponses[instrument.offset] = (response, instrument.element)
                        dispatchGroup.leave()
                    } catch {
                        dispatchGroup.leave()
                    }
                }
                task.resume()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            let flatMapResponse = allResponses.flatMap{$0}
            
            if flatMapResponse.count == instruments.count {
                completion(PortfolioResponse(status: .success(listViewModel: flatMapResponse)))
            } else {
                completion(PortfolioResponse(status: .failure(error: PortfolioServiceError.genericError)))
            }
        }        
    }
    
    func fetchYearlyPrices(forInstrumentCode code: String, completion: @escaping ((InstrumentDetailResponse) -> ())) {
        let requestURL = URLForInstrumentDetails(instrument: code)
        guard let requestURLForInstrument = requestURL else {
            return
        }
        let task = self.session.dataTask(with: requestURLForInstrument) { (data, response, error) in
            guard let data = data else {
                completion(InstrumentDetailResponse(status: .failure(error: PortfolioServiceError.genericError)))
                return
            }
            
            do {
                let response: PortfolioResponseModel = try JSONDecoder().decode(PortfolioResponseModel.self, from: data)
                completion(InstrumentDetailResponse(status: .success(listViewModel: response)))
            } catch {
                completion(InstrumentDetailResponse(status: .failure(error: PortfolioServiceError.genericError)))
            }
        }
        task.resume()
    }
    
    private func URLForInstrumentDetails(instrument: String) -> URLRequest? {
        let currentDate = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let today = dateFormatter.string(from: currentDate)
        
        guard let startDate = sevenDaysAgo else {
            return nil
        }
        
        let lastDate = dateFormatter.string(from: startDate)
        let stringURL = baseURLString + APIDataSetEndpoint + instrument + ".json?column_index=4&start_date=\(lastDate)&end_date=\(today))&api_key=" + APIKey
        let url = URL(string: stringURL)
        return URLRequest(url: url!)
    }
    
    private func URLForInstrument(instrument: String) -> URLRequest? {
        let currentDate = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let today = dateFormatter.string(from: currentDate)
        
        guard let startDate = sevenDaysAgo else {
            return nil
        }
        
        let lastDate = dateFormatter.string(from: startDate)
        let stringURL = baseURLString + APIDataSetEndpoint + instrument + ".json?column_index=4&start_date=\(lastDate)&end_date=\(today))&api_key=" + APIKey
        let url = URL(string: stringURL)
        return URLRequest(url: url!)
    }
}
