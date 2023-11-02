//
//  Countries.swift
//  Shopy
//
//  Created by Mohamed Adel on 01/11/2023.
//

import Foundation

class Countries {
    
    static func getCountries() -> [String] {
        let countriesCodes = Locale.Region.isoRegions
        var countries = [String]()
        
        for countryCode in countriesCodes {
            let identifier = countryCode.identifier
            
            if identifier.count == 2 && identifier != "QO" && identifier != "AQ" {
                countries.append(Locale.current.localizedString(forRegionCode: identifier) ?? "")
            }
        }
        return countries.sorted()
    }

    
}
