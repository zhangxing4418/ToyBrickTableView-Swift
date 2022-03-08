//
//  TBTableViewCell.swift
//  ToyBrickTableView-Swift
//
//  Created by mac on 2022/3/7.
//

import Foundation
import UIKit

class TBTableViewCell: UITableViewCell {
    class func reuseIdentifier() -> String {
        let reuseIdentifier = NSStringFromClass(self)
        return reuseIdentifier
    }
    
    class func cellRowHeight() -> Float {
        return Float(44.0)
    }
    
    class func cellRowHeightForDict(dict: NSMutableDictionary) -> Float {
        return self.cellRowHeight()
    }
    
    class func cellRowEstimatedHeight() -> Float {
        return self.cellRowHeight()
    }
    
    class func cellRowEstimatedHeightForDict(dict: NSMutableDictionary) -> Float {
        return self.cellRowEstimatedHeight()
    }
    
    class func dictKeyOfClassName() -> String {
        return "className"
    }
    
    class func tableViewCellClassOfDict(dict: NSMutableDictionary) -> AnyClass {
        let cls :AnyClass = dict[TBTableViewCell.dictKeyOfClassName()] as! AnyClass
        return cls
    }
    
    class func buildCellDict(cls: AnyClass) -> NSMutableDictionary {
        return [TBTableViewCell.dictKeyOfClassName() : cls]
    }
    
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateCellWithDict(dict: NSMutableDictionary) {
        
    }
}
