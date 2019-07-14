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
    var rootView: InitialInputView {
        return self.view as! InitialInputView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = InitialInputView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRootView()
        self.setupViewModel()
    }
    
    // MARK: Setup
    
    private func setupRootView() {
        self.rootView.onAcceptButtonTapped = { [weak self] in
            if
                let lowerBound = self?.rootView.lowerBound,
                let upperBound = self?.rootView.upperBound
            {
                guard
                    lowerBound < upperBound
                else {
                    self?.showErrorAlert(InternalError.lowerIsGreaterThenUpper)
                    return
                }
                
                self?.viewModel.fetchComments()
            } else {
                self?.showErrorAlert(InternalError.absenseOfBounds)
            }
        }
    }
    
    private func setupViewModel() {
        self.viewModel.didFetchComments = { [weak self] (result) in
            switch result {
            case .success(let comments):
                for comment in comments {
                    print(comment.body)
                }
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
        case lowerIsGreaterThenUpper
        
        var errorDescription: String? {
            switch self {
            case .absenseOfBounds:
                return "Please input lower and upper bounds."
            case .lowerIsGreaterThenUpper:
                return "Please check lower and upper bounds value. Lower bound should be less the upper bound."
            }
        }
    }
}

