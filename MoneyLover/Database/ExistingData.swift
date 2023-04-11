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

	let groupIcons: [String] = ["ic_home","ic_upgrade", "ic_money", "ic_bank", "ic_wallet3", "ic_reload", "ic_ab_bank", "ic_bank",
															"ic_bidv" , "ic_donga_bank", "ic_education", "ic_email", "ic_gift2", "ic_grow", "ic_guide", "ic_interest_rate", "ic_marry",
															"ic_policy", "ic_policy2", "ic_policy3", "ic_public_bank", "ic_sea_bank", "ic_shacom_bank", "ic_shb_bank", "ic_shinhan_bank",
															"ic_techcombank", "ic_tp_bank", "ic_vib", "ic_vietcom_bank", "ic_vietin_bank", "ic_vp_bank", "ic_vr_bank",

															"ic_home","ic_upgrade", "ic_money", "ic_bank", "ic_wallet3", "ic_reload", "ic_ab_bank", "ic_bank",
															"ic_bidv" , "ic_donga_bank", "ic_education", "ic_email", "ic_gift2", "ic_grow", "ic_guide", "ic_interest_rate", "ic_marry",
															"ic_policy", "ic_policy2", "ic_policy3", "ic_public_bank", "ic_sea_bank", "ic_shacom_bank", "ic_shb_bank", "ic_shinhan_bank",
															"ic_techcombank", "ic_tp_bank", "ic_vib", "ic_vietcom_bank", "ic_vietin_bank", "ic_vp_bank", "ic_vr_bank"]
	let groupTypes: [GroupType] = [.monthlyExpenses, .essentialExpenses, .entertainment]
}
