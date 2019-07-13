//
//  ExtentionTableView.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/11/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import Foundation
import UIKit

extension NotesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        var reuseIdentifier = "TableViewCell"
        if note.image != nil {
            reuseIdentifier += "+image"
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? XIBTableViewCell else { return UITableViewCell() }
//        cell.setup(white: note)
        
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        guard let diteilsVC = self.storyboard?.instantiateViewController(withIdentifier: "DiteilsViewController") as? DiteilsViewController else { return }
        
        diteilsVC.note = note
        let navigationViewController = UINavigationController(rootViewController: diteilsVC)
        present(navigationViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete action")
        let deleteAction = UITableViewRowAction(style: .destructive, title: deleteTitle) { (action, indexPath) in
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        let editTitle = NSLocalizedString("Edit", comment: "Edit action")
        let editAction = UITableViewRowAction(style: .normal, title: editTitle) {_,_ in
            self.selectedIndexPath = indexPath
            let note = self.notes[self.selectedIndexPath.row]

            guard let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController else { return }
            addVC.editNote = note
            addVC.delegate = self
            let navigationViewController = UINavigationController(rootViewController: addVC)
            self.present(navigationViewController, animated: true, completion: nil)
        }
        editAction.backgroundColor = .blue
        
        return [editAction, deleteAction]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedNote = notes.remove(at: fromIndexPath.row)
        self.notes.insert(movedNote, at: to.row)
        tableView.reloadData()
    }
}
