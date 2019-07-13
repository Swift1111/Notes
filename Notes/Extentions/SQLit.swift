//
//  SQLit.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/12/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import UIKit
import SQLite3

extension NotesListViewController {
    
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
    
    func creatTable() {
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
    }
}
