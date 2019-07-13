//
//  ColectionViewExtention.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/11/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import Foundation
import UIKit


extension NotesListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    // MARK: - Collection view data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let note = notes[indexPath.row]
        var reuseIdentifier = "CollectionViewCell"
        if note.image != nil {
            reuseIdentifier += "+image"
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.setup(white: note)
       
        return cell
    }
    
    // MARK: - Collection View Delegate Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.segmented.selectedSegmentIndex == 1 {
            let width = collectionView.frame.width / 2 - 7
            return CGSize(width: width, height: width)
        } else {
            let width = collectionView.frame.width / 3 - 7
            return CGSize(width: width, height: width)
        }
    }
}
