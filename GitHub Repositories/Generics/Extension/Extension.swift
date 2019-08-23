//
//  Extension.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/26/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit
import SCLAlertView
import KRProgressHUD



extension UIViewController {
    
    enum ShowActionType: Int {
        case show = 1, dismiss
    }
    
    // MARK: - Alert
    
    func showAlertWarning(_ message: String = "") {
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: false
        )
        SCLAlertView(appearance: appearance).showAlertWarning(message)
    }
    
    func showAlert(_ title:String = "", _ message: String = "", type: SCLAlertViewStyle = .success) {
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: false
        )
        SCLAlertView(appearance: appearance).showSuccess(title, subTitle: message, closeButtonTitle: "OK")
    }
    
    
    // MARK: - Loader
    
    func showLoader() {
        showLoading(action: .show, message: "Loading...", completeHandler: nil)
    }
    
    func hideLoader() {
        showLoading(action: .dismiss, message: "", completeHandler: nil)
    }
    
    func showLoading(action: ShowActionType = .show, message: String = "", completeHandler: (() -> ())?) -> Void {
        switch action {
        case .show:
            KRProgressHUD.show(withMessage: message)
            break
        case .dismiss:
            KRProgressHUD.dismiss(completeHandler)
            break
        }
    }
}


extension UIView {
    
    func animateFor(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: animationOptions, animations: {
                    self.transform = .init(scaleX: 1.2, y: 1.2)
            }, completion: completion)
        } else {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: animationOptions, animations: {
                    self.transform = .identity
            }, completion: completion)
        }
    }
}
