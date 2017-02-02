//
//  Closures.swift
//  
//
//  Created by Micah Wilson on 2/1/17.
//
//

import Foundation
import UIKit

enum GestureType {
    case tap, longPress, pan, pinch, swipe, rotation, screenEdgePan
}

extension UIView {
    
    fileprivate func actionHandleBlock(_ action:(() -> Void)? = nil) {
        struct Action {
            static var actions = [Int : (Void) -> Void]()
        }
        
        if Action.actions[self.tag] == nil {
            Action.actions[self.tag] = action
        } else {
            Action.actions[self.tag]?()
            Action.actions[self.tag] = nil
        }
    }
    
    @objc fileprivate func triggerActionHandleBlock() {
        actionHandleBlock()
    }
    
    func addGesture(gestureType type: GestureType, identifier: Int? = nil, ForAction action:@escaping () -> Void) {
        tag = identifier ?? Int(arc4random_uniform(UInt32.max))
        actionHandleBlock(action)
        isUserInteractionEnabled = true
        
        switch type {
        case .tap:
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(triggerActionHandleBlock)))
        case .longPress:
            addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(triggerActionHandleBlock)))
        case .pan:
            addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(triggerActionHandleBlock)))
        case .pinch:
            addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(triggerActionHandleBlock)))
        case .swipe:
            addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(triggerActionHandleBlock)))
        case .rotation:
            addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(triggerActionHandleBlock)))
        case .screenEdgePan:
            addGestureRecognizer(UIScreenEdgePanGestureRecognizer(target: self, action: #selector(triggerActionHandleBlock)))
        }
        
    }
    
}

extension UIControl {
    
    func actionHandle(controlEvents control :UIControlEvents, identifier: Int? = nil, ForAction action:@escaping () -> Void) {
        tag = identifier ?? Int(arc4random_uniform(UInt32.max))
        actionHandleBlock(action)
        addTarget(self, action: #selector(triggerActionHandleBlock), for: control)
    }
    
}
