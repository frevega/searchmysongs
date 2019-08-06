//
//  SongListViewDelegate.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/5/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit
import AlamofireImage

class SongTableViewCell: UITableViewCell {
    @IBOutlet
    private weak var songImage: UIImageView!
    @IBOutlet
    private weak var songTitle: UILabel!
    @IBOutlet
    private weak var albumTitle: UILabel!
    @IBOutlet
    private weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(
        imageUrl: String,
        songTitle: String,
        albumTitle: String,
        artisName: String
    ) {
        if let url = URL(string: imageUrl) {
            songImage.af_setImage(withURL: url)
        }
        self.songTitle.text = songTitle
        self.albumTitle.text = albumTitle
        self.artistName.text = artisName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        songImage.image = UIImage(named: "placeholder")
        songTitle.text = nil
        artistName.text = nil
    }
}
