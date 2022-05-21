//
//  RealmService.swift
//  Copyright © 2019 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    
    static let shared = RealmService()
    
    var realm = try! Realm()
    //=====================
    // Mark: - Create
    //=====================
    func create<T: Object>(object: T) {
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            post(error)
        }
    }
    //====================
    // Mark: - Replace
    //=====================
    func replace<T: Object>(object: T) {
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            post(error)
        }
    }
    //===============
    // Mark: - Read
    //===============
    func read<T: Object>(object: T.Type) -> Results<T>!  {
        let realm = RealmService.shared.realm
        let results = realm.objects(T.self)
        return results
    }
    //=================
    // Mark: - Update
    //=================
    func update<T: Object>(object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }
    //======================================================================================================
    // Mark: - Append an object to a 'List' (which is actually an Array, but realm doesn't currently support Arrays)
    //======================================================================================================
    func appendToList<T: Object>(list: List<T>?, with items: [T]) {
        let realm = try! Realm()
        do {
            try! realm.write {
                list?.append(objectsIn: items)
            }
        }
    }
    //==================
    // Mark: - Delete
    //==================
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }
    
    func remove<T: Object>(objectsOfInstanceType instanceType: T.Type) {
        let realm = try! Realm()
        let objects = realm.objects(instanceType)
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            post(error)
        }
        
    }
    
    //=====================================================================
    // MARK: Perform a function straight after observing a change in Realm
    //=====================================================================
    
    private var notificationToken = NotificationToken()
    
    func changesObserved(completion: @escaping () -> ())   {
        notificationToken = realm.observe { (notification, realm) in
            completion()
        }
    }
    
    func stopObservingChanges() {
        notificationToken.invalidate()
    }
    //====================================================
    // MARK: Check for a specific object with primary key
    //====================================================
    
    func objectExists<T: Object>(object: T.Type, withPrimaryKey primaryKey: Int) -> Bool {
        return realm.object(ofType: object.self, forPrimaryKey: primaryKey) != nil
    }
    //=========================
    // MARK: Error handling
    //=========================
    
    enum ErrorNotification {
        static let realmError = Notification.Name("RealmError")
    }
    
    func post(_ error: Error) {
        NotificationCenter.default.post(name: ErrorNotification.realmError, object: error)
    }
    
    func observeRealmError(in vc: UIViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: ErrorNotification.realmError,
                                               object: nil,
                                               queue: nil) { (notification) in
                                                completion(notification.object as? Error)
        }
    }
    
    func stopObservingErrors(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: ErrorNotification.realmError, object: nil)
    }
}
