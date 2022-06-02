//
//  UITableView+DequeuingViewModel.swift
//  UniGears
//
//  Created by Bitmad on 30/5/22.
//

import Foundation
import UIKit

typealias Action = () -> Void

protocol CellItemModelling {
    var action: Action? { get }
    func cell(with tableView: UITableView) -> UITableViewCell
}

protocol Idenfiable {
    static var indetifier: String { get }
}

extension Identifiable {
    static var indetifier: String {
        String(describing: self)
    }
}

protocol NibbedComponentModelling {
    static var nib: UINib { get }
}

protocol NibedCellModelling: Identifiable, NibbedComponentModelling {}

extension NibedCellModelling {
    static var nib: UINib {
        UINib(nibName: indetifier, bundle: Bundle.main)
    }
}

extension UITableView {
    func dequeueItemModelledCell<CellType: NibedCellModelling>(for _: CellItemModelling) -> CellType {
        if dequeueReusableCell(withIdentifier: CellType.indetifier) == nil {
            register(CellType.nib, forCellReuseIdentifier: CellType.indetifier)
        }
        let cell: CellType! = dequeueReusableCell(withIdentifier: CellType.indetifier) as? CellType
        return cell
    }
}
