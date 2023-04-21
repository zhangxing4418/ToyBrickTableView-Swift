//
//  TBValue1TableViewCell.swift
//  ToyBrickTableView-Swift
//
//  Created by mac on 2022/3/7.
//

import Foundation
import UIKit

class TBValue1TableViewCellConfig {
    var height: Float?
    var accessoryView: UIView?
    var backgroundColor: UIColor?
}

class TBValue1TableViewCellArguments {
    var configBlock: ((_ imageView: UIImageView, _ titleLabel: UILabel, _ subTitleLabel: UILabel, _ config: TBValue1TableViewCellConfig) -> TBValue1TableViewCellConfig)?
//    var indexConfigBlock: ((_ imageView: UIImageView, _ titleLabel: UILabel, _ subTitleLabel: UILabel, _ config: TBValue1TableViewCellConfig, _ index :Int) -> TBValue1TableViewCellConfig)?
}

class TBValue1TableViewCell: TBTableViewCell {
    override class func reuseIdentifier() -> String {
        return NSStringFromClass(TBValue1TableViewCell.self)
    }
    
    override class func cellRowHeightForDict(dict: NSMutableDictionary) -> Float {
        return dict["height"] as! Float
    }
    
    static func buildCellDict(configBlock: @escaping (_ imageView: UIImageView, _ titleLabel: UILabel, _ subTitleLabel: UILabel, _ config: TBValue1TableViewCellConfig) -> TBValue1TableViewCellConfig) -> NSMutableDictionary {
        let dict = super.buildCellDict(cls: TBValue1TableViewCell.self)
        let arguments = TBValue1TableViewCellArguments()
        arguments.configBlock = configBlock
        dict["Arguments"] = arguments
        dict["height"] = Float(44)
        return dict
    }
    
//    static func buildCellDict(indexConfigBlock: @escaping (_ imageView: UIImageView, _ titleLabel: UILabel, _ subTitleLabel: UILabel, _ config: TBValue1TableViewCellConfig, _ index: Int) -> TBValue1TableViewCellConfig) -> NSMutableDictionary {
//        let dict = super.buildCellDict(cls: TBValue1TableViewCell.self)
//        let arguments = TBValue1TableViewCellArguments()
//        arguments.indexConfigBlock = indexConfigBlock
//        dict["Arguments"] = arguments
//        dict["height"] = Float(44)
//        return dict
//    }
    
    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        self.textLabel?.textColor = UIColor.black
        self.textLabel?.font = UIFont.systemFont(ofSize: 13)
        self.detailTextLabel?.textColor = UIColor.white
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    override func updateCellWithDict(dict: NSMutableDictionary) {
        let arguments: TBValue1TableViewCellArguments = dict["Arguments"] as! TBValue1TableViewCellArguments
        if arguments.configBlock != nil {
            let config = arguments.configBlock?(self.imageView!, self.textLabel!, self.detailTextLabel!, TBValue1TableViewCellConfig())
            dict["height"] = Float(config?.height ?? 0)
            self.accessoryView = config?.accessoryView
            self.backgroundColor = config?.backgroundColor ?? UIColor.white
            self.contentView.backgroundColor = config?.backgroundColor ?? UIColor.white
        }
//        if arguments.indexConfigBlock != nil {
//
//        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
