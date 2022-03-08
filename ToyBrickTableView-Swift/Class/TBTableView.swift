//
//  TBTableView.swift
//  ToyBrickTableView-Swift
//
//  Created by mac on 2022/3/7.
//

import Foundation
import UIKit

class TBTableView: UITableView {
    private func initialize() {
        self.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
}
