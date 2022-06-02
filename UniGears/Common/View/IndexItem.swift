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
        let action: Action?
    }

    let name: String
    let items: [IndexItem]
}

extension IndexSection.IndexItem: CellItemModelling {
    func cell(with tableView: UITableView) -> UITableViewCell {
        let cell: IndexTableViewCell! = tableView.dequeueItemModelledCell(for: self)
        cell.config(with: self)
        return cell
    }

    var demoViewController: UIViewController {
        switch navigation {
        case .navigationStack(let storyboardName, let identifier):
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
        }
    }
}

extension IndexSection {
    static let sections: [IndexSection] = [
        .init(name: "Automation And Management", items: [
            .init(
                name: "Scripts - Parse info outside of project",
                navigation: .navigationStack(storyboardName: "AutomationAndManagement", identifier: "DemoParseInfoScriptViewController"),
                action: nil
            ),
        ]),
    ]
}
