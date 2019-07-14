//
//  InitialInputView.swift
//  KeyToTech
//
//  Created by Oleksii on 7/13/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import UIKit

final class InitialInputView: UIView {
    
    // MARK: - Properties
    // MARK: Callbacks
    
    var onAcceptButtonTapped: (() -> Void)?
    
    // MARK: Public
    
    var lowerBound: Int? {
        if let lowerBound = self.lowerBoundTextField.text {
            return Int(lowerBound)
        } else {
            return nil
        }
    }
    
    var upperBound: Int? {
        if let upperBound = self.upperBoundTextField.text {
            return Int(upperBound)
        } else {
            return nil
        }
    }
    
    override var isFirstResponder: Bool {
        return self.lowerBoundTextField.isFirstResponder || self.upperBoundTextField.isFirstResponder
    }
    
    var leftBarButtonItem: UIBarButtonItem {
        return .init(barButtonSystemItem: .done, target: self, action: #selector(self.accept))
    }
    
    var rightBarButtonItem: UIBarButtonItem {
        return .init(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel))
    }
    
    // MARK: Private
    
    private var stackView: UIStackView!
    private var lowerBoundTextField: UITextField!
    private var upperBoundTextField: UITextField!
    private var acceptButton: UIButton!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.setupStackView()
        self.setupLowerBoundTextField()
        self.setupUpperBoundTextField()
        self.setupAcceptButton()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    // MARK: Override
    
    @discardableResult override func resignFirstResponder() -> Bool {
        return self.endEditing(true)
    }
    
    // MARK: Actions
    
    @objc private func cancel() {
        self.resignFirstResponder()
        self.lowerBoundTextField.text = nil
        self.upperBoundTextField.text = nil
    }
    
    @objc private func accept() {
        self.resignFirstResponder()
        self.onAcceptButtonTapped?()
    }
    
    // MARK: Setup
    
    private func setupStackView() {
        self.stackView = UIStackView(frame: .zero)
        self.stackView.axis = .vertical
        self.stackView.alignment = .fill
        self.stackView.distribution = .fill
        self.stackView.spacing = 8.0
        self.addSubview(self.stackView)
    }
    
    private func setupLowerBoundTextField() {
        self.lowerBoundTextField = UITextField(frame: .zero)
        self.lowerBoundTextField.textColor = .white
        self.lowerBoundTextField.tintColor = .white
        self.lowerBoundTextField.keyboardAppearance = .dark
        self.lowerBoundTextField.keyboardType = .numberPad
        self.lowerBoundTextField.borderStyle = .roundedRect
        self.lowerBoundTextField.backgroundColor = .darkGray
        self.lowerBoundTextField.attributedPlaceholder = .init(
            string: "lower bound",
            attributes: [.foregroundColor: UIColor.gray]
        )
        self.stackView.addArrangedSubview(self.lowerBoundTextField)
    }
    
    private func setupUpperBoundTextField() {
        self.upperBoundTextField = UITextField(frame: .zero)
        self.upperBoundTextField.textColor = .white
        self.upperBoundTextField.tintColor = .white
        self.upperBoundTextField.keyboardAppearance = .dark
        self.upperBoundTextField.keyboardType = .asciiCapableNumberPad
        self.upperBoundTextField.borderStyle = .roundedRect
        self.upperBoundTextField.backgroundColor = .darkGray
        self.upperBoundTextField.attributedPlaceholder = .init(
            string: "upper bound",
            attributes: [.foregroundColor: UIColor.gray]
        )
        self.stackView.addArrangedSubview(self.upperBoundTextField)
    }
    
    private func setupAcceptButton() {
        self.acceptButton = UIButton(type: .system)
        self.acceptButton.setTitle("Accept", for: .normal)
        self.acceptButton.setTitleColor(.white, for: .normal)
        self.acceptButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        self.acceptButton.backgroundColor = .darkGray
        self.acceptButton.cornerRadius = 5.0
        self.acceptButton.addTarget(self, action: #selector(self.accept), for: .touchUpInside)
        self.stackView.addArrangedSubview(self.acceptButton)
    }
    
    private func setupConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 64),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -64)
        ])
    }
}
