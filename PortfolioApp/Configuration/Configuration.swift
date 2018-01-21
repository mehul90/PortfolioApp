//
//  Configuration.swift
//  ThePortfolioApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation

enum Environment: String {
    case debug
    case mock
    case qa
    case release
}

class Config: ConfigType {

    let apiVersion: String
    let apiEndpoint: String
    let APIKey: String

    let environment: Environment
    let buildNumber: String
    let locale: Locale

    lazy var baseURLString = self.apiEndpoint + self.apiVersion + "/"

    required init(bundle: Bundle, locale: Locale) {
        self.locale = locale

        let endpoints = bundle.object(forInfoDictionaryKey: "API Endpoints") as! [String: String]
        let env = bundle.object(forInfoDictionaryKey: "Environment") as! String

        apiVersion = bundle.object(forInfoDictionaryKey: "API Version") as! String
        APIKey = bundle.object(forInfoDictionaryKey: "API Key") as! String
        apiEndpoint = endpoints[env]!

        environment = Environment(rawValue: env.lowercased()) ?? .release
        buildNumber = bundle.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
}
