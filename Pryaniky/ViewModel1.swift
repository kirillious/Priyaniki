//
//  LondonScammer.swift
//  Pryaniky
//
//  Created by Kirill on 01.02.2021.
//

import Foundation
import SwiftyJSON

protocol SwiftyJSONDelegate {
    func updateLabels(for priyanikData: JSON)
}

struct ParsingOfData {
    
    var delegate: SwiftyJSONDelegate?
    
    
    func urlRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask (with: url) { (data, response, error) in
                if error != nil {
                }
                
                if let json = try? JSON(data) {
                    self.delegate?.updateLabels(for: json)
                }
 
            }; task.resume()
        }
    }
}
