//
//  ViewController.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let serviceLocator = ServiceLocator()
        let useCase = serviceLocator.songsUseCase
        
        useCase.searchSongs(term: "Never enough", limit: 20) { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error.message)")
                }
                return
            }
            
            print("response: \(response.resultCount!)")
        }
        
        useCase.lookupCollection(collectionId: 294466638) { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error.message)")
                }
                return
            }
            
            print("response: \(response.resultCount!)")
        }
    }
}

