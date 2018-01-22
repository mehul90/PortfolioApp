//
//  PortfolioController.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import UIKit

protocol PortfolioViewInput: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func reloadTableView()
    func updatePortfolioValue(with value: String)
    func updateGainLossLabel(with value: NSAttributedString)
    func showErrorMesage(message: String)
}

final class PortfolioViewController: UIViewController, PortfolioViewInput, UITableViewDelegate, UITableViewDataSource {

    var output: PortfolioViewOutput!
    let cellReuseIdentifier = "reuseIdentifier"
    
    @IBOutlet weak var portfolioValueLabel: UILabel!
    @IBOutlet weak var gainLossLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Portfolio"
        navigationController?.navigationBar.backgroundColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let movieCellNib = UINib(nibName: "InstrumentCellTableViewCell", bundle: nil)
        tableView.register(movieCellNib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableFooterView = UIView()
        output.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.instrumentsDataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        guard let instrumentCell = cell as? InstrumentCellTableViewCell else {
            return UITableViewCell()
        }
        let dataModel = output.instrumentsDataModels[indexPath.row]
        instrumentCell.instrumentCode.text = dataModel.instrumentCode
        instrumentCell.instrumentName.text = dataModel.instrumentName
        instrumentCell.instrumentValue.text = dataModel.instrumentValue
        instrumentCell.priceChange.attributedText = dataModel.priceChange
        instrumentCell.accessoryType = .disclosureIndicator
        return instrumentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectedInstrumentAtIndex(index: indexPath.row)
    }
        
    // MARK:- PortfolioViewInput
    func showLoadingIndicator() {
        portfolioValueLabel.isHidden = true
        gainLossLabel.isHidden = true
        tableView.isHidden = true
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        portfolioValueLabel.isHidden = false
        gainLossLabel.isHidden = false
        tableView.isHidden = false
        loadingIndicator.stopAnimating()
    }
    
    func showErrorMesage(message: String) {
        portfolioValueLabel.isHidden = false
        gainLossLabel.isHidden = true
        tableView.isHidden = true
        loadingIndicator.stopAnimating()
        //Show error or do whatever...
        portfolioValueLabel.text = "Error !!"
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func updatePortfolioValue(with value: String) {
        portfolioValueLabel.text = value
    }
    
    func updateGainLossLabel(with value: NSAttributedString) {
        gainLossLabel.attributedText = value
    }
}
