//
//  NotesListViewController.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/2/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import UIKit
import SQLite3



class NotesListViewController: UITableViewController, AddNoteViewControllerDelegate {
    
    /////////////////////////
    var fileURL: URL!
    var db: OpaquePointer?
    var statement: OpaquePointer?
    
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    func open() {
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    }
    
    func close() {
        if sqlite3_close(db) != SQLITE_OK {
            print("error cloasing database")
        }
        
        db = nil
    }
    /////////////////////////////
    
    var notes: [Note] = []
    var selectedIndexPath = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.estimatedRowHeight = 120
        self.title = "Notes"
        
        /////////////////////////
        fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Note.sqlite")
        
        open()
        
        let text = """
                    CREATE TABLE Note(Id INT PRIMARY KEY NOT NULL,Name TEXT);
                   """
        if sqlite3_exec(db, text, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        close()
        
//        print(fileURL)
        
    }
    
    

    @IBAction func addAction(_ sender: UIBarButtonItem) {
        guard let addNoteVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController else { return }
        addNoteVC.delegate = self
        let navVC = UINavigationController(rootViewController: addNoteVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        var reuseIdentifier = "NotesTableViewCell"
        if note.image != nil {
            reuseIdentifier += "+image"
        }
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NotesTableViewCell else { return UITableViewCell() }
        
        cell.setup(white: note)
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        guard let diteilsVC = self.storyboard?.instantiateViewController(withIdentifier: "DiteilsViewController") as? DiteilsViewController else { return }
        diteilsVC.note = note
        let navigationViewController = UINavigationController(rootViewController: diteilsVC)
        present(navigationViewController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete action")
        let deleteAction = UITableViewRowAction(style: .destructive,
                                                title: deleteTitle) { (action, indexPath) in
                                                    self.notes.remove(at: indexPath.row)
                                                    tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editTitle = NSLocalizedString("Edit", comment: "Edit action")
        let editAction = UITableViewRowAction(style: .normal,
                                                  title: editTitle) {_,_ in
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedNote = notes.remove(at: fromIndexPath.row)
        notes.insert(movedNote, at: to.row)
        tableView.reloadData()
    }
    
    //MARK: - AddNoteViewControllerDelegate

    func noteCreated(note: Note) {
        self.notes.append(note)
        self.tableView.reloadData()
    }
    
    func noteEditing(note: Note) {
        self.notes[selectedIndexPath.row] = note
        self.tableView.reloadData()
    }
    
}
