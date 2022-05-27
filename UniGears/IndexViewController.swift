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
            case modal(storyboardName: String, identifier: String?)
            case navigationStack(storyboardName: String, identifier: String?)
        }
        
        let name: String
        let navigation: Navigation
        
        var demoViewController: UIViewController? {
            switch navigation {
            case .modal(let storyboardName, let identifier):
                return targetViewController(from: storyboardName, identifier: identifier)
            case .navigationStack(let storyboardName, let identifier):
                return targetViewController(from: storyboardName, identifier: identifier)
            }
        }
        
        private func targetViewController(from storyboardName: String, identifier: String?) -> UIViewController? {
            let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
            guard let identifier = identifier else { return storyboard.instantiateInitialViewController() }
            return storyboard.instantiateViewController(withIdentifier: identifier)
        }
    }
    
    let name: String
    let items: [IndexItem]
}


final class IndexViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    
    private(set) var sections: [IndexSection]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Demo index"
        loadSections()
    }
    
    // MARK: - Helper Functions
    private func loadSections() {
        sections = [
            .init(name: "Automation And Management", items: [
                .init(name: "Scripts - Parse info outside of project", navigation: .navigationStack(storyboardName: "AutomationAndManagement", identifier: "DemoParseInfoScriptViewController"))
            ])
        ]
    }

}

extension IndexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = item.name
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
