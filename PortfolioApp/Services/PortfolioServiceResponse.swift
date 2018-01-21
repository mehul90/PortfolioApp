//
//  PortfolioServiceResponse.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

struct PortfolioResponseModel: Decodable {
    var dataset: Dataset
    
    struct Dataset: Decodable {
        var data: [PortfolioData]
        
        struct PortfolioData: Decodable {
            let date : String
            let value : Double
            
            init(from decoder: Decoder) throws {
                var container = try decoder.unkeyedContainer()
                date = try container.decode(String.self)
                value = try container.decode(Double.self)
            }
        }
    }
}

struct PortfolioResponse {
    enum Status {
        case success(listViewModel: [(PortfolioResponseModel, String)])
        case failure(error: Error)
    }

    let status: Status
}
