//
//  SongModelToEntity.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

class SongModelToEntity: Mapper<SongModel, SongEntity> {
    override func reverseMap(value: SongEntity) -> SongModel {
        return SongModel(wrapperType: value.wrapperType,
                             collectionType: value.collectionType,
                             artistId: value.artistId,
                             collectionId: value.collectionId,
                             trackId: value.trackId,
                             artistName: value.artistName,
                             collectionName: value.collectionName,
                             trackName: value.trackName,
                             collectionArtistName: value.collectionArtistName,
                             previewUrl: value.previewUrl,
                             artworkUrl100: value.artworkUrl100,
                             discCount: value.discCount,
                             discNumber: value.discNumber,
                             trackCount: value.trackCount,
                             trackNumber: value.trackNumber
        )
    }
}
