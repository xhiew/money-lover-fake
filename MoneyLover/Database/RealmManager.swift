//
//  RealmManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 31/03/2023.
//

import RealmSwift

enum TransactionKeyPath: String {
	case amount
	case date
}

enum TransactionGroupKeyPath: String {
	case groupType
}

extension Results {
	var optional: Results? {
		return isEmpty
		? nil
		: self
	}
}

class RealmManager {
	static var realm = try! Realm()

	static func getAll<T: Object>() -> [T]? {
		let response = realm.objects(T.self)
		let result = Array(response)
		return result
	}

	static func clear<T: Object>(objects: [T]) -> Bool {
		do {
			try realm.write({
				realm.delete(objects)
			})
		} catch let error {
			print("cannot clear, error: \(error)")
			return false
		}
		return true
	}

	static func create<T: Object>(object: T) -> Bool {
		do {
			try realm.write({
					realm.add(object)
			})
		} catch let error {
			print("cannot create new object, error: \(error)")
			return false
		}
		return true
	}

	static func delete<T: Object>(object: T) -> Bool {
		do {
			try realm.write({
				realm.delete(object)
			})
		} catch let error {
			print("cannot delete object, error: \(error)")
			return false
		}
		return true
	}
}

//MARK: - Filter Transactions
extension RealmManager {
	static func getAllExpenseTransactionsInMonth(date: Date = Date()) -> [Transaction]? {
		let response = realm.objects(Transaction.self).filter("group.isExpense == true AND isIgnore == false AND date BETWEEN {%@,%@}", date.customStart(of: .month) ?? Date(), date.customEnd(of: .month) ?? Date()).sorted(byKeyPath: TransactionKeyPath.amount.rawValue, ascending: false).optional
		guard let response = response else { return nil }
		let result = Array(response)
		return result
	}

	static func getAllExpenseTransactionsInWeek(date: Date = Date()) -> [Transaction]? {
		let response = realm.objects(Transaction.self).filter("group.isExpense == true AND isIgnore == false AND date BETWEEN {%@,%@}", date.customStart(of: .weekOfMonth) ?? Date(), date.customEnd(of: .weekOfMonth) ?? Date()).sorted(byKeyPath: TransactionKeyPath.amount.rawValue, ascending: false).optional
		guard let response = response else { return nil }
		let result = Array(response)
		return result
	}

	static func getAllTransactionsInMonth(date: Date) -> [Transaction]? {
		let response = realm.objects(Transaction.self).filter("date BETWEEN {%@,%@}", date.customStart(of: .month) ?? Date(), date.customEnd(of: .month) ?? Date()).sorted(byKeyPath: TransactionKeyPath.date.rawValue, ascending: false).optional
		guard let response = response else { return nil }
		let result = Array(response)
		return result
	}

	static func getAllTransactionsInCurrentMonth(date: Date) -> [Transaction]? {
		let response = realm.objects(Transaction.self).filter("date BETWEEN {%@,%@}", date.customStart(of: .month) ?? Date(), Date()).sorted(byKeyPath: TransactionKeyPath.date.rawValue, ascending: false).optional
		guard let response = response else { return nil }
		let result = Array(response)
		return result
	}

	static func getAllTransactionInFuture() -> [Transaction]? {
		let response = realm.objects(Transaction.self).filter("date > %@", Date()).sorted(byKeyPath: TransactionKeyPath.date.rawValue, ascending: true).optional
		guard let response = response else { return nil }
		let result = Array(response)
		return result
	}

	static func getThreeRecentTransaction() -> [Transaction]? {
		let response = realm.objects(Transaction.self).filter("date <= %@", Date()).sorted(byKeyPath: TransactionKeyPath.date.rawValue, ascending: false).prefix(3)
		let result = Array(response)
		return result
	}
}

//MARK: - Filter Transaction Groups
extension RealmManager {
	static func addDefaultGroups(groups: [TransactionGroup]) {
		do {
			try realm.write({
				realm.add(groups)
			})
		} catch let error {
			print("cannot create new object, error: \(error)")
		}
	}

	static func getAllGroupsAndSort() -> [TransactionGroup] {
		let response = realm.objects(TransactionGroup.self).filter("groupType != nil").sorted(byKeyPath: TransactionGroupKeyPath.groupType.rawValue, ascending: true)
		let result = Array(response)
		return result
	}

	static func getChangeAmountGroup() -> TransactionGroup? {
		let response = realm.objects(TransactionGroup.self).filter("groupType == nil")
		let result = Array(response).first
		return result
	}
}
