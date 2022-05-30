//
//  IndexViewController.swift
//  UniGears
//
//  Created by Bitmad on 25/5/22.
//

import UIKit

struct IndexSection {
    
    struct IndexItem {
        
        enum Navigation {
            case navigationStack(storyboardName: String, identifier: String)
        }
        
        let name: String
        let navigation: Navigation
        
        var demoViewController: UIViewController {
            switch navigation {
            case .navigationStack(let storyboardName, let identifier):
                return UIStoryboard.init(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
            }
        }
    }
    
    static let sections: [IndexSection] = [
        .init(name: "Automation And Management", items: [
            .init(name: "Scripts - Parse info outside of project", navigation: .navigationStack(storyboardName: "AutomationAndManagement", identifier: "DemoParseInfoScriptViewController"))
        ])
    ]
    
    let name: String
    let items: [IndexItem]
}


final class IndexViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: - Properties

    private var searchController: UISearchController! {
        didSet {
            searchController.searchResultsUpdater = self
        }
    }
    
    private(set) lazy var filteredSections: [IndexSection] = []
    
    // MARK: - Computed Variables
    
    private var isSearchBarEmpty: Bool {
      searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var sections: [IndexSection] {
        isSearchBarEmpty ? IndexSection.sections : filteredSections
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Demo Gear..."
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        navigationItem.title = "Demo index"
        navigationItem.searchController = searchController
    }
    
    // MARK: - Helper Functions
    
    private func filter(_ sections: [IndexSection], with searchText: String) -> [IndexSection.IndexItem] {
        return sections.flatMap {
            $0.items
        }.filter{
            $0.name.lowercased().contains(searchText.lowercased())
        }.compactMap { $0 }
    }
}

// MARK: Compliance - UITableViewDataSource

extension IndexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        // TODO: change this into dequeue pattern
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = item.name
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // TODO: fix the font styling for the title for the section header, currently the size is too big and text is blocked.
        sections[section].name
    }
}

// MARK: Compliance - UITableViewDelegate

extension IndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]

        switch item.navigation {
        case .navigationStack:
            navigationController?.pushViewController(item.demoViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Compliance - UISearchControllerDelegate

extension IndexViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        let filteredItems = filter(IndexSection.sections, with: searchText)
        
        filteredSections = [.init(name: "Filtered", items: filteredItems)]
        tableView.reloadData()
    }
}

extension IndexViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
}
