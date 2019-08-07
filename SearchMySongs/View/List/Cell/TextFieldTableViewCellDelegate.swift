//
//  TextFieldTableViewCellDelegate.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/7/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

protocol TextFieldTableViewCellDelegate: class {
    func prepareToolbar(for searchBar: UISearchBar)
    func update(searchTerm: String)
    func cancelButtonClicked()
    func searchByTerm()
}
