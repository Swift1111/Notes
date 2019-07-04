//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/2/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import UIKit

protocol AddNoteViewControllerDelegate {
    func noteCreated(note: Note)
    func noteEditing(note: Note)
}

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    var delegate: AddNoteViewControllerDelegate?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var selectedImageButton: UIButton!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
  
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var editNote: Note?
    
    var note: Note {
        let title = titleTextField.text
        let description = descriptionTextView.text
        let image = noteImageView.image
        let phoneNumber = phoneNumberTextField.text
        let mail = mailTextField.text
        
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        let date = dateFormater.string(from: datePicker.date)
        
        return Note(title: title!,
                    description: description!,
                    phoneNumber: phoneNumber,
                    mail: mail,
                    date: date,
                    image: image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateSaveButtonState()
        registerForKeyboardNotifications()
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        if let _ = self.editNote {
            delegate?.noteEditing(note: self.note)
        } else if let _ = self.titleTextField.text, let _ = self.descriptionTextView.text {
            delegate?.noteCreated(note: self.note)
        }
        updateSaveButtonState()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func updateSaveButtonState() {
        if let editNote = self.editNote {
            self.titleTextField.text = editNote.title
            self.descriptionTextView.text = editNote.description
            self.phoneNumberTextField.text = editNote.phoneNumber
            self.noteImageView.image = editNote.image
            self.mailTextField.text = editNote.mail
        }
    }
    
    
    
    // MARK: - ImagePicker
    @IBAction func selectedImageButton(_ sender: UIButton) {
        openImagePicker()
    }
    
    func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.noteImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Kayboard notification
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo,
            let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
