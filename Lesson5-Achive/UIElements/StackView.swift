//
//  StackView.swift
//  Lesson5-Achive
//
//  Created by Данил Марков on 10.02.2025.
//

import UIKit

class StackView: UIStackView {
    init(arrangedSubviews: [UIView], spacing: CGFloat, customSpacing: CGFloat) {
        super.init(frame: .zero)
        setupStackView(arrangedSubviews: arrangedSubviews, spacing: spacing, customSpacing: customSpacing)
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView(arrangedSubviews: [UIView], spacing: CGFloat, customSpacing: CGFloat) {
        axis = .vertical
        self.spacing = spacing
        arrangedSubviews.forEach { addArrangedSubview($0) }
        setCustomSpacing(customSpacing, after: arrangedSubviews.first ?? UIView())
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        guard let iconImageView = arrangedSubviews.first as? UIImageView,
              let progressView = arrangedSubviews.dropFirst(3).first as? UIProgressView else { return }
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            progressView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
}
