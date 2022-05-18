//
//  ContactsViewModel.swift
//  CodingExercise
//
//  Created by Raj Rathod on 18/05/22.
//  Copyright © 2022 Rise Buildings. All rights reserved.
//

import Foundation


class ContactsViewModel : NSObject {
    var API = ContantAPIClient()
    var sortedContacts = [ContactDetails]()

    // MARK: Fetching Data from Json String file
    func GetDataFromJson(completion: ( ([ContactDetails])->())?) {
        
        API.getContacts { data in
            do {
                let decoder = JSONDecoder()
                let contactsArray = try decoder.decode(ContactsModel.self, from: data)
                
                    // Sorting Array with first_name
                    self.sortedContacts = contactsArray.contacts.sorted {
                        $0.first_name < $1.first_name
                    }
                // Assigning sorted array to closure
                completion?(self.sortedContacts)

            } catch {
                
            }
        }
    }

}
