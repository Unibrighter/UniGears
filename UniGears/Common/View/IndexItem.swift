//
//  IndexItem.swift
//  UniGears
//
//  Created by Bitmad on 30/5/22.
//

import UIKit

struct IndexSection {
    
    struct IndexItem {
        
        enum Navigation {
            case navigationStack(storyboardName: String, identifier: String)
        }
        
        let name: String
        let navigation: Navigation
    }
    
    let name: String
    let items: [IndexItem]
}


extension IndexSection.IndexItem {
    
    private static let cellIdentifier: String = "IndexTableViewCell"
    
    var demoViewController: UIViewController {
        switch navigation {
        case .navigationStack(let storyboardName, let identifier):
            return UIStoryboard.init(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
        }
    }
    
    public func configuredCell(within tableView: UITableView) -> UITableViewCell {
        if tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier) == nil {
            tableView.register(UINib(nibName: Self.cellIdentifier, bundle: nil), forCellReuseIdentifier: Self.cellIdentifier)
        }
        
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier)
        var content = cell.defaultContentConfiguration()
        content.text = self.name
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension IndexSection {
    static let sections: [IndexSection] = [
        .init(name: "Automation And Management", items: [
            .init(name: "Scripts - Parse info outside of project", navigation: .navigationStack(storyboardName: "AutomationAndManagement", identifier: "DemoParseInfoScriptViewController"))
        ])
    ]
}
