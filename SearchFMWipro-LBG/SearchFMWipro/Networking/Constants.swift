//
//  Constants.swift
//  SearchFMWipro
//
//  Created by AG on 09/12/23.
//  Copyright © 2023 AG. All rights reserved.
//

import Foundation

class Constants: NSObject {
    
    struct APPURL {
        
        private struct Domains {
            static let Dev = "http://ws.audioscrobbler.com"
            static let UAT = ""
            static let Local = ""
            static let QA = ""
        }
        
        private static let Domain = Domains.Dev
        
        static var baseURL:String {
            return Domain
        }
    }

    struct Keys {
        struct LastFmAPI {
            static let apiKey = "865b1ec61fa2bf0ccd6207ab3238047a"
            static let APISecret = "efd9b514e6de44df66f2c10df0d28e7f"
        }
    }
    
    struct Alert {
       static let alertErrorTitle = "Error in Response"
       static let alertErrorMessage = "Please try again in sometime"
        static let alertOK = "OK"
    }
}
