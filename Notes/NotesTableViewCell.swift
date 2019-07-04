//
//  NotesTableViewCell.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/2/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.noteImageView?.subviews.forEach({
//            if let label = $0 as? UILabel {
//                label.isHidden = label.text == "" ? true : false
//            } else if let imageView = $0 as? UIImageView {
//                imageView.isHidden = imageView.image == nil ? true : false
//            }
//        })
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(clickLabel(_:)))
        self.mailLabel.addGestureRecognizer(tapGesture)
    }

    func setup(white note: Note) {
        self.titleLabel.text = note.title
        self.descriptionLabel.text = note.description
        self.phoneNumberLabel.text = note.phoneNumber
        self.mailLabel.text = note.mail
        self.dateLabel.text = note.date
        if let noteImageView = self.noteImageView {
            noteImageView.image = note.image
        }
    }
    
    @objc func clickLabel(_ selector: Any) {
        print(555)
    }
    
    
}
