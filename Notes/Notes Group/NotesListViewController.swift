//
//  NotesListViewController.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/2/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import UIKit
import SQLite3

class NotesListViewController: UIViewController, AddNoteViewControllerDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var segmented: UISegmentedControl!
    
    var fileURL: URL!
    var db: OpaquePointer?
    var statement: OpaquePointer?
    
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    var notes: [Note] = []
    var selectedIndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.creatTable()
    }
    
    func setup() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
                
        self.tableView.rowHeight = UITableView.automaticDimension
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        self.tableView.estimatedRowHeight = 120
        self.title = "Notes"
        
        self.segmented.selectedSegmentIndex = 1
        self.segmented.backgroundColor = .lightText
        self.segmented.tintColor = .black
    }
    
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        guard let addNoteVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController else { return }
        addNoteVC.delegate = self
        let navVC = UINavigationController(rootViewController: addNoteVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    @IBAction func segmentedSelected(_ sender: UISegmentedControl) {
        self.tableView.isHidden = sender.selectedSegmentIndex == 0 ? false : true
        self.collectionView.isHidden = !self.tableView.isHidden
        self.collectionView.reloadData()
    }
    
    //MARK: - AddNoteViewControllerDelegate
    func noteCreated(note: Note) {
        self.notes.append(note)
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
    
    func noteEditing(note: Note) {
        self.notes[selectedIndexPath.row] = note
        self.tableView.reloadData()
    }
}

