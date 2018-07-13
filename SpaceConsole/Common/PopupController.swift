//
//  PopupController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/2.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import Foundation

enum PopupStyle {
    case custom
    case center
    case actionSheet
    case leftMenu
    case presentation
}

enum PopupAnimation {
    case none
    case fade
    case fromBottom
    case fromLeft
    case fromRight
}

enum PopupDirection {
    case up
    case down
    case left
    case right
}


import UIKit

class PopupController {
    let animationDuration: TimeInterval = 0.2
    var direciton: PopupDirection = .left
//    var offset:
    var animation: PopupAnimation
    private var popupView: UIView
    private var popedOnView: UIView?
    
    var darkBG: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.alpha = 0
        return view
    }()
    
    var hideDarkBackground: Bool = false
    var dissmissWhenTapDragBG: Bool = true
    
    required init(popupView: UIView, with style: PopupAnimation) {
        self.popupView = popupView
        self.animation = style
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDarkBGAction(_:)))
        self.darkBG.addGestureRecognizer(tapGesture)

    }
    
    func popupOnView(view: UIView, with style: PopupStyle) {
        if !self.hideDarkBackground {
            view.addSubview(self.darkBG)
            self.darkBG.snp.makeConstraints { (make) in
                make.edges.equalTo(view)
            }
        }
        
//        guard let popupView = self.popupView else {
//            fatalError("尚未設久popup view!")
//        }
        
        self.popedOnView = view
        view.addSubview(self.popupView)
        
        switch style {
        case .leftMenu:
            fallthrough
        default:
            popupView.snp.makeConstraints { (make) in
                make.top.equalTo(view.snp.top)
                make.bottom.equalTo(view.snp.bottom)
                make.leading.equalTo(view.snp.leading)
                make.width.equalTo(self.popupView.snp.width)
            }
        }
        
        view.layoutSubviews()
        
        switch animation {
        case .fromLeft:
            fallthrough
        default:
            let moveDistance = popupView.frame.size.width
            
            popupView.layer.transform = CATransform3DMakeTranslation(-moveDistance, 0, 0)
            popupView.alpha = 0
            UIView.animate(withDuration: animationDuration) {
                self.popupView.alpha = 1
                self.popupView.layer.transform = CATransform3DIdentity
                self.darkBG.alpha = 1
            }
        }
        
    }

    func dismiss() {
        switch animation {
        case .fromLeft:
            fallthrough
        default:
            guard let popedOnView = self.popedOnView else { fatalError("尚未設定 popedOnView!") }

            let moveDistance = popedOnView.frame.size.width
            UIView.animate(withDuration: animationDuration, delay: 0, options: .beginFromCurrentState, animations: {
                self.popupView.layer.transform = CATransform3DMakeTranslation(-moveDistance, 0, 0)
                self.darkBG.alpha = 0
            }) { (finished) in
                self.popupView.layer.transform = CATransform3DIdentity
                self.popupView.removeFromSuperview()
                self.darkBG.removeFromSuperview()
            }

        }
    }
    
    @objc func tapDarkBGAction(_ tap:UITapGestureRecognizer) {
        if self.dissmissWhenTapDragBG {
            self.dismiss()
        }
    }
    
}


