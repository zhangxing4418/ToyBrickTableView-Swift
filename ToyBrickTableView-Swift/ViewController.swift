//
//  ViewController.swift
//  ToyBrickTableView-Swift
//
//  Created by mac on 2022/3/7.
//

import UIKit

class ViewController: UIViewController {
    private lazy var tableView: TBTableView = {
        var tableView = TBTableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        return tableView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        
        self.buildCellDataSource()
    }
    
    private func buildCellDataSource() {
        self.tableView.dataSources.removeAll()
        
        for i in (0 ..< 150) {
            self.tableView.dataSources.append(TBValue1TableViewCell.buildCellDict(configBlock: { imageView, titleLabel, subTitleLabel, config in
                titleLabel.text = "标题"
                titleLabel.font = UIFont.systemFont(ofSize: 20)
                subTitleLabel.text = "详情"
                subTitleLabel.textColor = UIColor.lightGray
                config.height = 50
                config.backgroundColor = UIColor.systemRed
                return config
            }).addAction(actionBlock: {
                print("第\(i + 1)行")
            }))
            self.tableView.dataSources.append(TBSplitLineTableViewCell.buildCellDict(backgroundColor: UIColor.black, height: 10, leftEdge: 15, rightEdge: 15))
        }
    }
}

