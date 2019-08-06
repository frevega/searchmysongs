//
//  DetailViewController.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/6/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet
    private(set) weak var tableView: UITableView!
    private var activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private let presenter: DetailPresenter?
    private let delegate: DetailViewDelegate?
    private let datasource: DetailViewDatasource?
    
    var collectionId: Int = 0
    
    init(presenter: DetailPresenter,
         delegate: DetailViewDelegate,
         datasource: DetailViewDatasource
        ) {
        self.presenter = presenter
        self.delegate = delegate
        self.datasource = datasource
        super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.attach(view: self)
        datasource?.attach(view: self)
        presenter?.attach(view: self)
        presenter?.lookupAlbumSongs(id: collectionId)
    }
    
    private func prepareIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        activityIndicatorView.backgroundColor = .lightGray
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.layer.cornerRadius = activityIndicatorView.bounds.width / 2
    }
    
    private func prepareTableView() {
        let cellName = String(describing: SongTableViewCell.self)
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.delegate = delegate
        tableView.dataSource = datasource
    }
    
    private func prepareNavgationItem() {
        navigationItem.title = Constants.navigationTitle
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension DetailViewController: DetailView {
    func prepare() {
        prepareNavgationItem()
        prepareIndicatorView()
        prepareTableView()
    }
    
    func showLoading() {
        view.isUserInteractionEnabled = false
        activityIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        view.isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
    }
    
    func show(album: [SongView]) {
        datasource?.songs.append(contentsOf: album);
    }
    
    func show(error: ErrorView) {
        let alertView = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertView, animated: true)
    }
}
