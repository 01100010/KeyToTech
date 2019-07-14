//
//  UIViewController+Alert.swift
//  KeyToTech
//
//  Created by Oleksii on 7/13/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import UIKit

private let unknownErrorMessage = "An unknown error has occurred"

extension UIViewController {
    
    /// Show an alert on the view controller.
    func showAlert(
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertController.Style = .alert,
        actions: [UIAlertAction] = [.ok],
        completion: (() -> Void)? = nil
        ) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.showAlert(
                    title: title,
                    message: message,
                    preferredStyle: preferredStyle,
                    actions: actions,
                    completion: completion
                )
            }
            return
        }
        
        let alert = UIAlertController.createAlert(
            title: title,
            message: message,
            preferredStyle: preferredStyle,
            actions: actions
        )
        
        self.present(alert, animated: true, completion: completion)
    }
    
    /// Show an alert on the view controller.
    func showAlert(
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertController.Style = .alert,
        action: UIAlertAction,
        completion: (() -> Void)? = nil
        ) {
        self.showAlert(
            title: title,
            message: message,
            preferredStyle: preferredStyle,
            actions: [action],
            completion: completion
        )
    }
    
    /// Show an alert on the view controller for the specified error.
    func showErrorAlert(
        title: String? = "Error",
        _ error: LocalizedError?,
        unknownMessage: String = unknownErrorMessage,
        actions: [UIAlertAction] = [.ok],
        completion: (() -> Void)? = nil
        ) {
        self.showAlert(
            title: title,
            message: error?.errorDescription ?? unknownMessage,
            actions: actions,
            completion: completion
        )
    }
    
    /// Show an alert on the view controller for the specified error.
    func showErrorAlert(
        title: String? = "Error",
        _ error: LocalizedError?,
        unknownMessage: String = unknownErrorMessage,
        action: UIAlertAction,
        completion: (() -> Void)? = nil
        ) {
        self.showErrorAlert(
            title: title,
            error,
            actions: [action],
            completion: completion
        )
    }
}

extension UIAlertController {
    static func createAlert(
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertController.Style = .alert,
        actions: [UIAlertAction] = [.ok]
        ) -> UIAlertController {
        let alert = self.init(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { alert.addAction($0) }
        return alert
    }
    
}

extension UIAlertAction {
    static func ok(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return .init(title: "OK", style: .cancel, handler: handler)
    }
    
    static func cancel(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return .init(title: "Cancel", style: .cancel, handler: handler)
    }
    
    static func dismiss(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return .init(title: "Dismiss", style: .cancel, handler: handler)
    }
    
    static func delete(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return .init(title: "Delete", style: .destructive, handler: handler)
    }
    
    static func normal(_ title: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return .init(title: title, style: .default, handler: handler)
    }
    
    static func destructive(_ title: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return .init(title: title, style: .destructive, handler: handler)
    }
    
    // Allow being accessed as properties:
    static var cancel: UIAlertAction {
        return .cancel()
    }
    
    static var ok: UIAlertAction {
        return .ok()
    }
    
    static var dismiss: UIAlertAction {
        return .dismiss()
    }
    
    static var delete: UIAlertAction {
        return .delete()
    }
    
    static var normal: UIAlertAction {
        return .normal("Normal")
    }
    
    static var destructive: UIAlertAction {
        return .destructive("Destructive")
    }
}
