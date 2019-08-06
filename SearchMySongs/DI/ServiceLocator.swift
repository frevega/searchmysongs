//
//  ServiceLocator.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import Foundation

class ServiceLocator {
    private let codableHelper = CodableHelper()
    
    private var songsRestApi: SongsRestApi {
        return SongsRestApiImpl(codableHelper: codableHelper)
    }
    
    private var songsDatasource: SongsDatasource {
        return SongsDatasourceImpl(restApi: songsRestApi)
    }
    
    private var songModelToEntity: SongModelToEntity {
        return SongModelToEntity()
    }
    
    private var responseModelToEntity: ResponseModelToEntity {
        return ResponseModelToEntity(songModelToEntity: songModelToEntity)
    }
    
    private var errorModelToEntity: ErrorModelToEntity {
        return ErrorModelToEntity()
    }
    
    private var songsRepository: SongsRepository {
        return SongsRepositoryImpl(datasource: songsDatasource,
                                   responseModelToEntity: responseModelToEntity,
                                   errorModelToEntity: errorModelToEntity
        )
    }
    
    var songViewToModel: Mapper<SongView, SongModel> {
        return SongViewToModel()
    }
    
    var errorViewToModel: Mapper<ErrorView, ErrorModel> {
        return ErrorViewToModel()
    }
    
    var songsUseCase: SongsUseCase {
        return SongsUseCase(repository: songsRepository)
    }
}
