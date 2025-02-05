//
//  AchievmentCell.swift
//  Lesson5-Achive
//
//  Created by Данил Марков on 05.02.2025.
//
import UIKit

private enum UIConstants {
    static let cornerRadius: CGFloat = 16
    static let shadowOpacity: Float = 0.1
    static let shadowRadius: CGFloat = 4
    static let shadowOffset: CGSize = CGSize(width: 0, height: 2)
    static let imageHeight: CGFloat = 60
    static let stackSpacing: CGFloat = 8
    static let stackPadding: CGFloat = 8
    static let titleLabelFont: UIFont = .systemFont(ofSize: 14, weight: .semibold)
    static let titleLabelTextColor: UIColor = .black
}

class AchievmentCell: UICollectionViewCell{
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemPink
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.titleLabelFont
        label.textColor = UIConstants.titleLabelTextColor
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = UIConstants.cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = UIConstants.shadowOpacity
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = UIConstants.shadowRadius
        layer.shadowOffset = UIConstants.shadowOffset
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = UIConstants.stackSpacing
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.stackPadding),
            imageView.heightAnchor.constraint(equalToConstant: UIConstants.imageHeight)
        ])
    }
    
    func configure(with achivment: Achievment) {
        titleLabel.text = achivment.title
        imageView.image = UIImage(systemName: achivment.iconName)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = achivment.color
    }
    
    
}
