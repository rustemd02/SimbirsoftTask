//
//  DatabaseService.swift
//  simbirsoft
//
//  Created by Рустем on 06.07.2023.
//

import Foundation
import RealmSwift

class DatabaseService {
    static let shared = DatabaseService()
    
    func saveToRealm<T: Object>(object: T) -> Error? {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
                print("Сохранено в Realm")
            }
        } catch {
            return error
        }
        return nil
    }
}
