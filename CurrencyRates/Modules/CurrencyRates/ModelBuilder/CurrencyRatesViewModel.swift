//
//  CurrencyRatesViewModel.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import Foundation

struct CurrencyRatesViewModel {
    
    let sections: [Section]
    let isEmpty: Bool // if contains no items
    
    var items: [ConversionRateCell.Model] {
        for section in sections {
            guard case .rates(let items) = section else { continue }
            return items
        }
        return []
    }
    
    var ratesSectionIndex: Int? {
        for (index, section) in sections.enumerated() {
            guard case .rates = section else { continue }
            return index
        }
        return nil
    }
        
}

extension CurrencyRatesViewModel {
    
    enum Section {
        case largeAddPair
        case smallAddPair
        case rates([ConversionRateCell.Model])
        
        var numberOfRows: Int {
            switch self {
            case .largeAddPair:     return 1
            case .smallAddPair:     return 1
            case .rates(let items): return items.count
            }
        }
        
    }
    
}
