//
//  NotesTableViewCell.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/2/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var noteImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
}
