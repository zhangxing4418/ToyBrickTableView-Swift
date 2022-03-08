//
//  NSMutableDictionary+TableViewCellAction.swift
//  ToyBrickTableView-Swift
//
//  Created by mac on 2022/3/8.
//

import Foundation

final private class Action {
    var actionBlock: (() -> Void)?
}

extension NSMutableDictionary {
    func addAction(actionBlock: @escaping () -> Void) -> NSMutableDictionary {
        let action: Action = Action()
        action.actionBlock = actionBlock
        self["actionBlock"] = action
        return self
    }
    
    func executeAction() {
        let action: Action? = self["actionBlock"] as? Action
        if action?.actionBlock != nil {
            action?.actionBlock!()
        }
    }
}
