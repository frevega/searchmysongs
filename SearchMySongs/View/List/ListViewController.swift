//
//  ListViewController.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet
    private(set) weak var tableView: UITableView!
    private var activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private let presenter: ListPresenter?
    private let delegate: ListViewDelegate?
    private let datasource: ListViewDatasource?
    var songs = [SongView]() {
        didSet {
            reloadTableView()
        }
    }
    private(set) var isViewEditing = false
    private(set) var searchTerm: String? = nil
    
    init(presenter: ListPresenter,
         delegate: ListViewDelegate,
         datasource: ListViewDatasource
    ) {
        self.presenter = presenter
        self.delegate = delegate
        self.datasource = datasource
        super.init(nibName: String(describing: ListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.attach(view: self)
        datasource?.attach(view: self)
        presenter?.attach(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    
    override func keyboardWillAppear(notification _: NSNotification) {
        if !isViewEditing {
            isViewEditing = true
//            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    override func keyboardWillDisappear(notification _: NSNotification) {
        isViewEditing = false
        //tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
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
        let textCellname = String(describing: TextFieldTableViewCell.self)
        tableView.register(UINib(nibName: textCellname, bundle: nil), forCellReuseIdentifier: textCellname)
        let songCellname = String(describing: SongTableViewCell.self)
        tableView.register(UINib(nibName: songCellname, bundle: nil), forCellReuseIdentifier: songCellname)
        tableView.delegate = delegate
        tableView.dataSource = datasource
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func prepareNavgationItem() {
        navigationItem.title = Constants.navigationTitle
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func pushViewController(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ListViewController: ListView {
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
    
    func show(songs: [SongView]) {
        self.songs.removeAll()
        self.songs.append(contentsOf: songs);
    }
    
    func show(error: ErrorView) {
        let alertView = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertView, animated: true)
    }
}

extension ListViewController: TextFieldTableViewCellDelegate {
    func prepareToolbar(for searchBar: UISearchBar) {
        searchBar.inputAccessoryView = prepareKeyboardToolbar(textFields: nil, keyboardType: .default)
    }
    
    func update(searchTerm: String) {
        self.searchTerm = searchTerm
    }
    
    func cancelButtonClicked() {
        self.searchTerm = nil
        isViewEditing = false
    }
    
    func searchByTerm() {
        if let searchTerm = searchTerm {
            print(searchTerm)
            presenter?.fetchSongsBy(term: searchTerm)
        }
    }
}
