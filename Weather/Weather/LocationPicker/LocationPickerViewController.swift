//
//  LocationPickerViewController.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LocationPickerViewController: BaseViewController {

    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    private static let cellIdentifier = "LocationCell"

    private var viewModel: LocationPickerViewModel!

    init(viewModel: LocationPickerViewModel!) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    override func loadView() {
        super.loadView()

        setupUI()
    }

    private func setupUI() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Enter location"
        view.addSubview(searchBar)
        self.searchBar = searchBar

        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }

        let tableView = UITableView()
        view.addSubview(tableView)
        self.tableView = tableView

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.leading.trailing.equalTo(view)
        }

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
    }

    private func setupBindings() {
        let input = LocationPickerViewModel.Inputs(search: searchBar.rx.text.orEmpty.asObservable())
        let output = viewModel.bind(input)

        output.locations
            .bind(to: tableView.rx.items(cellIdentifier: Self.cellIdentifier)) { _, res, cell in
                cell.textLabel?.text = res
            }
            .disposed(by: disposeBag)
    }
}

extension LocationPickerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return isValidText(text: text)
    }

    private func isValidText(text: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]")
        return regex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.utf8.count)) != nil
    }
}
