//
//  TrendingListViewController.swift
//  Pablogithub
//
//  Created by Pablo Roca on 26/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit

final class TrendingListViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: TrendingListViewModel!
    private var searchTimer: Timer?
    private var searchController: UISearchController!

    // MARK: - UI Elements

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.registerCellClass(ofType: TrendingCell.self)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = TrendingCell.designatedHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let waitingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    // MARK: - Init

    init(viewModel: TrendingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        refreshData()
    }

    // MARK: - Private

    private func configureUI() {
        title = viewModel.title
        view.backgroundColor = UIColor.pr2White

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        definesPresentationContext = true

        view.addSubview(tableView)
        view.addSubview(waitingIndicator)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            waitingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waitingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

    private func refreshData() {
        waitingIndicator.isHidden = false
        waitingIndicator.startAnimating()
        viewModel.readTrending {[weak self] (success) in
            guard let self = self else { return }
            self.waitingIndicator.isHidden = true
            self.waitingIndicator.stopAnimating()
            if success {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension TrendingListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: TrendingCell.self, for: indexPath)
        cell.configure(viewModel: viewModel.rows[indexPath.row])
        return cell
    }

}

// MARK: - UITableViewDelegate
extension TrendingListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = ProjectViewModel()
        model.project = viewModel.rows[indexPath.row]
        let viewController = ProjectViewController(viewModel: model)
        navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - UISearchResultsUpdating
extension TrendingListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (timer) in
            guard let self = self else { return }
            self.performDelayedSearch(with: text)
        })
    }

    private func performDelayedSearch(with text: String) {
        viewModel.filterRows(with: text)
        tableView.reloadData()
    }

}
