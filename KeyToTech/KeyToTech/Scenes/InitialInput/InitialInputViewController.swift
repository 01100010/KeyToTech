//
//  InitialInputViewController.swift
//  KeyToTech
//
//  Created by Oleksii on 7/13/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import UIKit

final class InitialInputViewController: UIViewController {

    // MARK: - Properties
    // MARK: Public
    
    let viewModel: InitialInputViewModel = .init()
    let rootView: InitialInputView = .init()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupRootView()
        self.setupViewModel()
    }
    
    // MARK: Setup
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Initial Input"
        self.navigationItem.leftBarButtonItem = self.rootView.leftBarButtonItem
        self.navigationItem.rightBarButtonItem = self.rootView.rightBarButtonItem
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    private func setupRootView() {
        self.rootView.onAcceptButtonTapped = { [weak self] in
            if
                let lowerBound = self?.rootView.lowerBound,
                let upperBound = self?.rootView.upperBound
            {
                guard lowerBound >= 0 else {
                    self?.showErrorAlert(InternalError.negativeValue)
                    return
                }
                
                guard lowerBound < upperBound else {
                    self?.showErrorAlert(InternalError.lowerIsGreaterThenUpper)
                    return
                }
                
                self?.viewModel.fetchComments(with: lowerBound)
            } else {
                self?.showErrorAlert(InternalError.absenseOfBounds)
            }
        }
    }
    
    private func setupViewModel() {
        self.viewModel.didFetchComments = { [weak self] (result) in
            switch result {
            case .success(let comments):
                let controller = ListOfCommentsViewController(
                    with: comments,
                    lowerBound: (self?.rootView.lowerBound)!,
                    upperBound: (self?.rootView.upperBound)!
                )
                
                self?.navigationController?.pushViewController(controller, animated: true)
            case .failure(let error):
                self?.showErrorAlert(error)
            }
        }
    }
    
    // MARK: - Keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.rootView.isFirstResponder {
            self.rootView.resignFirstResponder()
        }
    }
}

private extension InitialInputViewController {
    enum InternalError: LocalizedError {
        case absenseOfBounds
        case negativeValue
        case lowerIsGreaterThenUpper
        
        var errorDescription: String? {
            switch self {
            case .absenseOfBounds:
                return "Please input lower and upper bounds."
            case .negativeValue:
                return "Lower bound should be positive"
            case .lowerIsGreaterThenUpper:
                return "Please check lower and upper bounds value. Lower bound should be less the upper bound."
            }
            
        }
    }
}

