//
//  TextFieldTableViewCell.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/7/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var searchBar: UISearchBar!
    private weak var delegate: TextFieldTableViewCellDelegate?
    
    func setup(delegate: TextFieldTableViewCellDelegate) {
        self.delegate = delegate
        searchBar.delegate = self
        delegate.prepareToolbar(for: searchBar)
    }
}

extension TextFieldTableViewCell: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            delegate?.update(searchTerm: searchText)
        } else {
            delegate?.cancelButtonClicked()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchByTerm()
    }
}
