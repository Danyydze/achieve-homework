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
    
    func setupPinchGesture(for collectionView: UICollectionView) {
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        collectionView.addGestureRecognizer(pinchRecognizer)
    }
    
    private func notifyDelegateAboutSelection(at indexPath: IndexPath) {
        let selectedAchievement = achievements[indexPath.item]
        delegate?.dataManager(self, didSelectAchievement: selectedAchievement)
    }
    
    @objc private func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard gesture.scale > 1.5,
              let collectionView = gesture.view as? UICollectionView,
              let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView))
        else { return }
        
        notifyDelegateAboutSelection(at: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension DataManager : UICollectionViewDataSource {
    func collectionView(_ collectionView : UICollectionView, numberOfItemsInSection section : Int) -> Int{
       return achievements.count
   }

   func collectionView(_ collectionView : UICollectionView, cellForItemAt indexPath : IndexPath)->UICollectionViewCell{
       let cell=collectionView.dequeueReusableCell(withReuseIdentifier:"AchievmentCell",for:indexPath)as! AchievmentCell

       cell.configure(with:self.achievements[indexPath.item])
       return cell
   }
}

// MARK:- UICollectionViewDelegate
extension DataManager :UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexpath = indexPath
        let selectedAcheivement = achievements[indexpath.item]
        delegate?.dataManager(self, didSelectAchievement: selectedAcheivement)
    }
}
