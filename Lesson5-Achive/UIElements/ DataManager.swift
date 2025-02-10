//
//   DataManager.swift
//  Lesson5-Achive
//
//  Created by Данил Марков on 10.02.2025.
//

//
//  DataManager.swift
//  Lesson5-Achive
//

import UIKit

protocol DataManagerDelegate: AnyObject {
    func dataManager(_ manager: DataManager, didSelectAchievement achievement: Achievment)
}

final class DataManager: NSObject {
    private var achievements: [Achievment]
    weak var delegate: DataManagerDelegate?
    
    init(achievements: [Achievment]) {
        self.achievements = achievements
        super.init()
    }
}

// MARK: - UICollectionViewDataSource
extension DataManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "AchievmentCell",
            for: indexPath
        ) as! AchievmentCell
        
        cell.configure(with: achievements[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DataManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAchievement = achievements[indexPath.item]
        delegate?.dataManager(self, didSelectAchievement: selectedAchievement)
    }
}
