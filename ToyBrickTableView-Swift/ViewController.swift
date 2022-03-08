//
//  ViewController.swift
//  ToyBrickTableView-Swift
//
//  Created by mac on 2022/3/7.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var tableView: TBTableView = {
        var tableView = TBTableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        return tableView
    }()
    private lazy var dataSource: [NSMutableDictionary] = {
        return Array()
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
        self.dataSource.removeAll()
        
        for i in (0 ..< 150) {
            self.dataSource.append(TBValue1TableViewCell.buildCellDict(configBlock: { imageView, titleLabel, subTitleLabel, config in
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
            self.dataSource.append(TBSplitLineTableViewCell.buildCellDict(backgroundColor: UIColor.black, height: 10, leftEdge: 15, rightEdge: 15))
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict: NSMutableDictionary = self.dataSource[indexPath.row]
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
        let dict: NSMutableDictionary = self.dataSource[indexPath.row]
        let tableViewCellClass: AnyClass = TBTableViewCell.tableViewCellClassOfDict(dict: dict)
        let height: Float = (tableViewCellClass as! TBTableViewCell.Type).cellRowHeightForDict(dict: dict)
        return (height == Float(UITableView.automaticDimension) || height >= 0) ? CGFloat(height) : 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let dict: NSMutableDictionary = self.dataSource[indexPath.row]
        let tableViewCellClass: AnyClass = TBTableViewCell.tableViewCellClassOfDict(dict: dict)
        let height: Float = (tableViewCellClass as! TBTableViewCell.Type).cellRowHeightForDict(dict: dict)
        if #available(iOS 11.0, *) {
            return (height == Float(UITableView.automaticDimension) || height >= 0) ? CGFloat(height) : 0
        }else {
            return height <= 1 ? 0 : CGFloat(height)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict: NSMutableDictionary = self.dataSource[indexPath.row]
        dict.executeAction()
    }
}

