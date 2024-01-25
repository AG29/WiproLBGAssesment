//
//  Swift Extentions.swift
//  WcitiesNetworkLayer
//
//  Created by AG on 07/12/23.
//  Copyright © 2019 Wcities. All rights reserved.
//

import Foundation

 extension String {
    
    func getCleanedURL() -> URL? {
        guard self.isEmpty == false else {
            return nil
        }
        if let url = URL(string: self) {
            return url
        } else {
            if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) , let escapedURL = URL(string: urlEscapedString){
                return escapedURL
            }
        }
        return nil
    }
    
}
