//: Playground - noun: a place where people can play

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

extension UIButton {
    
    func actionHandle(controlEvents control :UIControlEvents, identifier: Int? = nil, ForAction action:@escaping () -> Void) {
        tag = identifier ?? Int(arc4random_uniform(UInt32.max))
        actionHandleBlock(action)
        addTarget(self, action: #selector(triggerActionHandleBlock), for: control)
    }
    
}

//Examples
let button1 = UIButton()
button1.actionHandle(controlEvents: .touchUpInside, identifier: nil) {
    print("Hello")
}



let button2 = UIButton()
button2.actionHandle(controlEvents: .touchUpInside, identifier: nil) {
    print("Hi")
}

let view1 = UIView()
view1.addGesture(gestureType: .tap, identifier: nil) {
    
}

button2.sendActions(for: .touchUpInside)
button1.sendActions(for: .touchUpInside)
