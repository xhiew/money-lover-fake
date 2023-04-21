//
//  ExistingData.swift
//  MoneyLover
//
//  Created by xhieu21 on 11/04/2023.
//

import Foundation

struct ExistingData {
	public static var shared = ExistingData()
	private init() {}

	let groupIcons: [String] =
	["ic_home","ic_upgrade_account", "ic_money", "ic_bank", "ic_wallet3", "ic_reload", "ic_ab_bank", "ic_bank",
	 "ic_bidv" , "ic_donga_bank", "ic_education", "ic_email", "ic_gift2", "ic_grow", "ic_guide", "ic_interest_rate", "ic_marry",
	 "ic_policy", "ic_policy2", "ic_policy3", "ic_public_bank", "ic_sea_bank", "ic_shacom_bank", "ic_shb_bank", "ic_shinhan_bank",
	 "ic_techcombank", "ic_tp_bank", "ic_vib", "ic_vietcom_bank", "ic_vietin_bank", "ic_vp_bank", "ic_vr_bank",

	 "ic_home","ic_upgrade", "ic_money", "ic_bank", "ic_wallet3", "ic_reload", "ic_ab_bank", "ic_bank",
	 "ic_bidv" , "ic_donga_bank", "ic_education", "ic_email", "ic_gift2", "ic_grow", "ic_guide", "ic_interest_rate", "ic_marry",
	 "ic_policy", "ic_policy2", "ic_policy3", "ic_public_bank", "ic_sea_bank", "ic_shacom_bank", "ic_shb_bank", "ic_shinhan_bank",
	 "ic_techcombank", "ic_tp_bank", "ic_vib", "ic_vietcom_bank", "ic_vietin_bank", "ic_vp_bank", "ic_vr_bank"
	]

	let groupTypes: [GroupType] = [.monthlyExpenses, .essentialExpenses, .entertainment]

	lazy var groupDefaults: [TransactionGroup] = [
		TransactionGroup(image: "ic_home", name: "Ăn uống", isExpense: true, canDelete: false, groupType: .monthlyExpenses),
		TransactionGroup(image: "ic_upgrade", name: "Di chuyển", isExpense: true, canDelete: false, groupType: .monthlyExpenses),
		TransactionGroup(image: "ic_home", name: "Thuê nhà", isExpense: true, canDelete: false, groupType: .monthlyExpenses),
		TransactionGroup(image: "ic_wallet3", name: "Hoá đơn nước", isExpense: true, canDelete: false, groupType: .monthlyExpenses),
		TransactionGroup(image: "ic_wallet3", name: "Hoá đơn điện", isExpense: true, canDelete: false, groupType: .monthlyExpenses),
		TransactionGroup(image: "ic_wallet3", name: "Hoá đơn gas", isExpense: true, canDelete: false, groupType: .monthlyExpenses),
		TransactionGroup(image: "ic_wallet3", name: "Hoá đơn điện thoại", isExpense: true, canDelete: false, groupType: .monthlyExpenses),
		TransactionGroup(image: "ic_wallet3", name: "Hoá đơn internet", isExpense: true, canDelete: false, groupType: .monthlyExpenses),
		TransactionGroup(image: "ic_reload", name: "Hoá đơn TV", isExpense: true, canDelete: false, groupType: .monthlyExpenses),
		TransactionGroup(image: "ic_home", name: "Sửa & trang trí nhà", isExpense: true, canDelete: false, groupType: .essentialExpenses),
		TransactionGroup(image: "ic_upgrade", name: "Bảo dưỡng xe", isExpense: true, canDelete: false, groupType: .essentialExpenses),
		TransactionGroup(image: "ic_marry", name: "Khám sức khoẻ", isExpense: true, canDelete: false, groupType: .essentialExpenses),
		TransactionGroup(image: "ic_education", name: "Học tập", isExpense: true, canDelete: false, groupType: .essentialExpenses),
		TransactionGroup(image: "ic_home", name: "Vật nuôi", isExpense: true, canDelete: false, groupType: .essentialExpenses),
		TransactionGroup(image: "ic_marry", name: "Làm đẹp", isExpense: true, canDelete: false, groupType: .entertainment),
		TransactionGroup(image: "ic_education", name: "Vui - chơi", isExpense: true, canDelete: false, groupType: .entertainment),
		TransactionGroup(image: "ic_marry", name: "Thể dục - thể thao", isExpense: true, canDelete: false, groupType: .entertainment),
		TransactionGroup(image: "ic_marry", name: "Quà tặng & quyên góp", isExpense: true, canDelete: false, groupType: .entertainment),
		TransactionGroup(image: "ic_wallet3", name: "Lương", isExpense: false, canDelete: false, groupType: .revenue),
		TransactionGroup(image: "ic_reload", name: "Thu nhập khác", isExpense: false, canDelete: false, groupType: .revenue),
		TransactionGroup(image: "ic_money", name: "Thu nợ", isExpense: false, canDelete: false, groupType: .revenue),
		TransactionGroup(image: "ic_bank", name: "Vay ngân hàng", isExpense: false, canDelete: false, groupType: .revenue),
		TransactionGroup(image: "ic_money", name: "Thu lãi", isExpense: false, canDelete: false, groupType: .revenue),
		TransactionGroup(image: "ic_money", name: "Tiền trợ cấp", isExpense: false, canDelete: false, groupType: .revenue),
		TransactionGroup(image: "ic_wallet3", name: "Lương hưu", isExpense: false, canDelete: false, groupType: .revenue),
		TransactionGroup(image: "ic_upgrade_account", name: "Thu nhập khác", isExpense: nil, canDelete: false, groupType: nil)
	]
}
