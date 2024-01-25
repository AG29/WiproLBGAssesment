//
//  EndpointType.swift
//  SearchFMWipro
//
//
//  Created by AG on 09/12/23.
//  Copyright © 2023 AG. All rights reserved.
//

import Foundation

protocol EndpointType {

    var baseURL: URL { get }

    var path: String { get }

}
