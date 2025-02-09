//
//  ViewController.swift
//  Lesson5-Achive
//
//  Created by Данил Марков on 05.02.2025.
//

import UIKit

private enum UserInfo {
    static let name = "Дмитрий Лобадев"
    static let bio = "Ну, наверное, в описании не нуждается"
}

private enum UIConstants {
    static let cardCornerRadius: CGFloat = 32
    static let cardShadowOpacity: Float = 0.1
    static let cardShadowRadius: CGFloat = 8
    static let cardShadowOffset: CGSize = CGSize(width: 0, height: -3)
    
    static let collectionItemSize: CGSize = CGSize(width: 170, height: 170)
    static let collectionMinimumInteritemSpacing: CGFloat = 12
    static let collectionMinimumLineSpacing: CGFloat = 16
    static let collectionSectionInset: UIEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
    
    static let profileStackSpacing: CGFloat = 16
    static let profileStackPadding: CGFloat = 24
    static let avatarImageSize: CGFloat = 80
    
    static let cardDefaultBottomConstant: CGFloat = 50
    static let collectionHiddenAlpha: CGFloat = 0
    
    static let leadingInset: CGFloat = 16
    static let cardViewHeight: CGFloat = 200
}

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    private var cardBottomConstraint: NSLayoutConstraint!
    private var isCardCollapsed: Bool = true
    private let achievements = Achievment.demoData
    
    // MARK: - UI Elements
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = UIConstants.cardCornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = UIConstants.cardShadowOpacity
        view.layer.shadowRadius = UIConstants.cardShadowRadius
        view.layer.shadowOffset = UIConstants.cardShadowOffset
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIConstants.collectionItemSize
        layout.minimumInteritemSpacing = UIConstants.collectionMinimumInteritemSpacing
        layout.minimumLineSpacing = UIConstants.collectionMinimumLineSpacing
        layout.sectionInset = UIConstants.collectionSectionInset
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.name
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.bio
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.alpha = UIConstants.collectionHiddenAlpha
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        imageView.tintColor = .systemGray5
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        setupUI()
        setupCollectionView()
    }
    
    // MARK: - Setup
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [avatarImageView, nameLabel, bioLabel])
        stackView.axis = .vertical
        stackView.spacing = UIConstants.profileStackPadding
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.addSubview(stackView)
        view.addSubview(cardView)
        view.addSubview(collectionView)
        
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCardTap)))
        
        cardBottomConstraint = cardView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -UIConstants.cardDefaultBottomConstant
        )
        
        NSLayoutConstraint.activate([
            cardBottomConstraint,
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.leadingInset),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.leadingInset),
            cardView.heightAnchor.constraint(equalToConstant: UIConstants.cardViewHeight),
            
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: UIConstants.profileStackPadding),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -UIConstants.profileStackPadding),
            stackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            avatarImageView.widthAnchor.constraint(equalToConstant: UIConstants.avatarImageSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: UIConstants.avatarImageSize),
            
            collectionView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        cardView.layer.zPosition = 1
    }
    
    private func setupCollectionView() {
        collectionView.register(AchievmentCell.self, forCellWithReuseIdentifier: "AchievmentCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alpha = UIConstants.collectionHiddenAlpha
    }
    
    // MARK: - Actions
    @objc private func handleCardTap() {
        isCardCollapsed.toggle()
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.cardBottomConstraint.constant = self.isCardCollapsed
                ? -UIConstants.cardDefaultBottomConstant
                : -(self.view.frame.height - self.view.safeAreaInsets.top - UIConstants.cardViewHeight)
            
            self.collectionView.alpha = self.isCardCollapsed ? 0 : 1
            self.bioLabel.alpha = self.isCardCollapsed ? 0 : 1
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - CollectionView DataSource & Delegate
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchievmentCell", for: indexPath) as! AchievmentCell
        cell.configure(with: achievements[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let achievement = achievements[indexPath.item]
            let detailView = DetailAchievementView(achievement: achievement)
            let horizontalInset: CGFloat = 50
            let verticalInset: CGFloat = 270
            detailView.frame = view.bounds.insetBy(dx: horizontalInset, dy: verticalInset)
            detailView.alpha = 0
            detailView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            view.addSubview(detailView)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
                detailView.alpha = 1
                detailView.transform = .identity
            }
    }
}
