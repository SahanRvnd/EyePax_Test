//
//  FilterOptionVM.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import Foundation

class FilterOptionVM: BaseVM {
    
    var filterOptions: [FilterOptionData]?
    
    
}

struct FilterOptionData {
    var title:String?
    var itemList: [String]?
}
