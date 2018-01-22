//
//  InstrumentDetailController.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/21/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol InstrumentDetailViewInput: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showTitle(withString title: String)
    func setSharePrice(price: String)
    func setPriceChange(attributedText: NSAttributedString)
    func showErrorMesage(message: String)
}

final class InstrumentDetailViewController: UIViewController, InstrumentDetailViewInput {
    var output: InstrumentDetailViewOutput!

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lastPrice: UILabel!
    @IBOutlet weak var priceChange: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidesWhenStopped = true
        output.viewDidLoad()
    }
        
    // MARK:- InstrumentDetailViewInput
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        lastPrice.isHidden = true
        priceChange.isHidden = true
    }
    
    func showTitle(withString title: String) {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .white
        label.text = title
        self.navigationItem.titleView = label
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        lastPrice.isHidden = false
        priceChange.isHidden = false
    }
    
    func setSharePrice(price: String) {
        lastPrice.text = price
    }
    
    func setPriceChange(attributedText: NSAttributedString) {
        priceChange.attributedText = attributedText
    }
    
    func showErrorMesage(message: String) {

        
    }
}
