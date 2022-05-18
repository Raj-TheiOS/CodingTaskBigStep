//
//  ContactsModel.swift
//  CodingExercise
//
//  Created by Raj Rathod on 18/05/22.
//  Copyright © 2022 Rise Buildings. All rights reserved.
//

import Foundation

// MARK:- Creating Model for the cities data
struct ContactsModel: Decodable {
    var contacts: [ContactDetails]
}

struct ContactDetails : Decodable {
    var first_name, image_url, last_name, tag_handle: String
}

