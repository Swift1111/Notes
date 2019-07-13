//
//  NotesDiteilsViewController.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/5/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import UIKit

class DiteilsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var note: Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.addGesture()
    }
    
    private func setup() {
        if let note = self.note {
            self.titleLabel.text = note.title
            self.descriptionTextView.text = note.description
            self.phoneNumberLabel.text = note.phoneNumber
            self.noteImageView.image = note.image
            self.mailLabel.text = note.mail
            self.dateLabel.text = note.date
        }
    }
    
    private func addGesture() {
        self.phoneNumberLabel.isUserInteractionEnabled = true
        self.mailLabel.isUserInteractionEnabled = true
        
        let NumberTapGestur = UITapGestureRecognizer(target: self, action: #selector(phoneNumberTaped(_:)))
        let mailTapGestur = UITapGestureRecognizer(target: self, action: #selector(mailTaped(_:)))
        
        self.phoneNumberLabel.addGestureRecognizer(NumberTapGestur)
        self.mailLabel.addGestureRecognizer(mailTapGestur)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func phoneNumberTaped(_ sender: Any) {
        self.showAlert(title: "Phone Number", message: "Can not call out on your phone")
    }
    
    @objc func mailTaped(_ sender: Any) {
        self.showAlert(title: "Mail", message: "Can not send mail")
    }
}
