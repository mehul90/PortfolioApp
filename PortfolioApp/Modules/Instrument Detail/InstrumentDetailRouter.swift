//
//  InstrumentDetailCoordinator.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/21/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol InstrumentDetailRouterInput {
    
}

final class InstrumentDetailRouter {
    weak var viewController: InstrumentDetailViewController!

}

extension InstrumentDetailRouter: InstrumentDetailRouterInput {}
