//
//  ConversionRateItem.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import Foundation

struct ConversionRateItem: Hashable {
    let pair: CurrencyPair
    let value: Decimal?
}
