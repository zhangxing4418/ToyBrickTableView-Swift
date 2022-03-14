//
//  TBTableView.swift
//  ToyBrickTableView-Swift
//
//  Created by mac on 2022/3/7.
//

import Foundation
import UIKit

class TBTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    lazy var dataSources: [NSMutableDictionary] = {
        return Array()
    }()
    
    private func initialize() {
        self.dataSource = self
        self.delegate = self
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict: NSMutableDictionary = self.dataSources[indexPath.row]
        let tableViewCellClass: AnyClass = TBTableViewCell.tableViewCellClassOfDict(dict: dict)
        let reuseIdentifier: String = (tableViewCellClass as! TBTableViewCell.Type).reuseIdentifier()
        
        var tableViewCell: TBTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? TBTableViewCell)
        if tableViewCell == nil {
            tableViewCell = (tableViewCellClass as! TBTableViewCell.Type).init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
            tableViewCell?.backgroundColor = UIColor.clear
            tableViewCell?.selectionStyle = UITableViewCell.SelectionStyle.none
        }
        tableViewCell?.updateCellWithDict(dict: dict)
        return tableViewCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dict: NSMutableDictionary = self.dataSources[indexPath.row]
        let tableViewCellClass: AnyClass = TBTableViewCell.tableViewCellClassOfDict(dict: dict)
        let height: Float = (tableViewCellClass as! TBTableViewCell.Type).cellRowHeightForDict(dict: dict)
        return (height == Float(UITableView.automaticDimension) || height >= 0) ? CGFloat(height) : 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let dict: NSMutableDictionary = self.dataSources[indexPath.row]
        let tableViewCellClass: AnyClass = TBTableViewCell.tableViewCellClassOfDict(dict: dict)
        let height: Float = (tableViewCellClass as! TBTableViewCell.Type).cellRowHeightForDict(dict: dict)
        if #available(iOS 11.0, *) {
            return (height == Float(UITableView.automaticDimension) || height >= 0) ? CGFloat(height) : 0
        }else {
            return height <= 1 ? 0 : CGFloat(height)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict: NSMutableDictionary = self.dataSources[indexPath.row]
        dict.executeAction()
    }
}
