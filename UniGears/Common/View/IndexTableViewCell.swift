//
//  IndexTableViewCell.swift
//  UniGears
//
//  Created by Bitmad on 30/5/22.
//

import UIKit

final class IndexTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension IndexTableViewCell: NibedCellModelling {

    func config(with viewModel: IndexSection.IndexItem) {
        var content = defaultContentConfiguration()
        content.text = viewModel.name
        contentConfiguration = content
        accessoryType = .disclosureIndicator
    }
}
