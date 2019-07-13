//
//  LoginViewController.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/2/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var notesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBAction func notesAction(_ sender: UIButton) {
        guard let noteVc = self.storyboard?.instantiateViewController(withIdentifier: "NotesListViewController") as? NotesListViewController else { return }
        
        let navVC = UINavigationController(rootViewController: noteVc)
        self.present(navVC, animated: true, completion: nil)
    }
}
