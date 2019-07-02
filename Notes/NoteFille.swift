//
//  NoteFille.swift
//  Notes
//
//  Created by Armen Gasparyan on 7/2/19.
//  Copyright © 2019 SLTeam. All rights reserved.
//

import Foundation
import UIKit

struct Note {
    var title: String
    var description: String
    var phoneNumber: String?
    var mail: String?
    var date: String?
    var image: UIImage?
    
    init(title: String, description: String, phoneNumber: String?, mail: String? = nil, date: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.description = description
        self.phoneNumber = phoneNumber
        self.mail = mail
        self.date = date
        self.image = image
    }
    
}
