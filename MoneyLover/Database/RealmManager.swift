//
//  RealmManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 31/03/2023.
//

extension Results {
    var optional: Results? {
        return isEmpty ? nil : self
    }
}

import RealmSwift

/*

 nhớ .optional để realm trả về nil thay vì [], tại vì mảng rỗng thì sẽ không nhảy vào return khi guard let
 let realm = try! Realm()
 let persons = realm.objects(Person.self).filter("name == %@", "John").optional

 if persons == nil {
     print("Không tìm thấy dữ liệu phù hợp.")
 } else {
     for person in persons! {
         print(person.name)
     }
 }
 */
