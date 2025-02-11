//
//  DetailAchievementView.swift
//  Lesson5-Achive
//
//  Created by Данил Марков on 09.02.2025.
//

import UIKit

// MARK: - DetailAchievementViewDelegate

protocol DetailAchievementViewDelegate: AnyObject {
    func detailAchievementViewDidRequestClose(_ view: DetailAchievementView)
}

final class DetailAchievementView: UIView {
    
    // MARK: - Properties
    
    private let achievement: Achievment
    weak var delegate: DetailAchievementViewDelegate?
    
    // MARK: - UI Elements
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = achievement.currentProgress >= achievement.maxProgress
        ? achievement.color
        : .systemGray4
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.text = achievement.title
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = achievement.description
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = achievement.color
        view.progress = Float(achievement.currentProgress) / Float(achievement.maxProgress)
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.text = achievement.obtainedDate?.formatted(date: .abbreviated, time: .omitted)
        label.isHidden = achievement.obtainedDate == nil
        return label
    }()
    
    // MARK: - Init
    
    init(achievement: Achievment) {
        self.achievement = achievement
        super.init(frame: .zero)
        setupView()
        configureGestures()
        addCloseButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 5)
        iconImageView.image = UIImage(systemName: achievement.iconName)?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 60))
        let stackView = StackView(
            arrangedSubviews: [
                iconImageView,
                titleLabel,
                descriptionLabel,
                progressView,
                dateLabel
            ],
            spacing: 16,
            customSpacing: 24
        )
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func addCloseButton() {
        addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    // MARK: - Gestures
    
    private func configureGestures() {
        let pinchGesture = UIPinchGestureRecognizer(
            target: self,
            action: #selector(handlePinchGesture(_:))
        )
        addGestureRecognizer(pinchGesture)
    }
    
    // MARK: - Actions
    
    @objc private func closeButtonTapped() {
        animateClose()
    }
    
    @objc private func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard gesture.state == .ended else { return }
        if gesture.scale < 0.7 {
            animateClose()
        }
    }
    
    private func animateClose() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 0
            self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.detailAchievementViewDidRequestClose(self)
        }
    }
}
