//
//  DetailPresenterImpl.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/6/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

class DetailPresenterImpl {
    private weak var view: DetailView?
    private let useCase: SongsUseCase
    private let songViewToModel: Mapper<SongView, SongModel>
    private let errorViewToModel: Mapper<ErrorView, ErrorModel>
    
    init(useCase: SongsUseCase,
         songViewToModel: Mapper<SongView, SongModel>,
         errorViewToModel: Mapper<ErrorView, ErrorModel>
        ) {
        self.useCase = useCase
        self.songViewToModel = songViewToModel
        self.errorViewToModel = errorViewToModel
    }
}

extension DetailPresenterImpl: DetailPresenter {
    func attach(view: DetailView) {
        self.view = view
        view.prepare()
    }
    
    func lookupAlbumSongs(id: Int) {
        view?.showLoading()
        useCase.lookupCollection(collectionId: id) { (response, error) in
            self.view?.hideLoading()
            guard let response = response else {
                if let error = error {
                    self.view?.show(error: self.errorViewToModel.reverseMap(value: error))
                }
                return
            }
            
            if response.resultCount ?? 0 > 0 {
                self.view?.show(album: self.songViewToModel.reverseMap(values: response.results))
            } else {
                self.view?.show(error: self.getGenericErrorView())
            }
        }
    }
    
    private func getGenericErrorView() -> ErrorView {
        return ErrorView(message: "Ups! There's nothing to show!")
    }
}
