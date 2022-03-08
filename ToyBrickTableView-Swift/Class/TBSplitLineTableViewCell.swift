//
//  TBSplitLineTableViewCell.swift
//  ToyBrickTableView-Swift
//
//  Created by mac on 2022/3/8.
//

import Foundation
import UIKit

class TBSplitLineTableViewCell: TBTableViewCell {
    lazy var splitLineView: UIView = {
        let lineView: UIView = UIView.init(frame: CGRect.zero)
        lineView.backgroundColor = UIColor.clear
        return lineView
    }()
    
    override class func reuseIdentifier() -> String {
        return NSStringFromClass(TBSplitLineTableViewCell.self)
    }
    
    override class func cellRowHeightForDict(dict: NSMutableDictionary) -> Float {
        return dict["height"] as! Float
    }
    
    static func buildCellDict(backgroundColor: UIColor, height: Float, leftEdge: Float, rightEdge: Float) -> NSMutableDictionary {
        let dict = super.buildCellDict(cls: TBSplitLineTableViewCell.self)
        dict["bgColor"] = backgroundColor
        dict["height"] = height
        dict["leftEdge"] = leftEdge
        dict["rightEdge"] = rightEdge
        return dict
    }
    
    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(self.splitLineView)
    }
    
    override func updateCellWithDict(dict: NSMutableDictionary) {
        let bgColor: UIColor = dict["bgColor"] as! UIColor
        let height: CGFloat = dict["height"] as! CGFloat
        let leftEdge: CGFloat = dict["leftEdge"] as! CGFloat
        let rightEdge: CGFloat = dict["rightEdge"] as! CGFloat
        if bgColor.isEqual(UIColor.clear) {
            self.contentView.backgroundColor = UIColor.clear
        }
        self.splitLineView.backgroundColor = bgColor
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.splitLineView.frame = CGRect(x: leftEdge, y: 0, width: self.contentView.frame.width - leftEdge - rightEdge, height: height)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
