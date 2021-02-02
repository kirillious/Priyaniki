//
//  ViewModel.swift
//  Pryaniky
//
//  Created by Kirill on 29.01.2021.
//

import Foundation
import Kingfisher

protocol FetchingJSONDelegate {
    func transmissionOfData(for dataPriyanik: PrynianikyJSON)
}


struct FetchingJSON {
    var delegate: FetchingJSONDelegate?
    
    func parseJSON(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask (with: url) { (data, response, error) in
                if error != nil {
                }

                do {
                    let decoder = JSONDecoder()
                    let pryanikiData = try decoder.decode(PrynianikyJSON.self, from: data!)
                    self.delegate?.transmissionOfData(for: pryanikiData)
                    
                } catch {
                    print(error)
                    print("its workimg3")
                    
                }
        
            }; task.resume()
        }
    }
    
    
}
