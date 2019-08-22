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

enum ShowActionType: Int {
    case show = 1, dismiss
}

extension UIViewController {
    
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
