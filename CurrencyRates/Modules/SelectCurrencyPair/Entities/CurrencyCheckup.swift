//
//  CurrencyCheckup.swift
//  Created by Alexander Antonov on 10/04/2019.
//

typealias CurrencyCheckup = (Currency) -> Bool

enum CurrencyCheckupType {
    case pairDoesntExist(first: Currency)
    case anyPossiblePairExist
    case currenciesDontMatch(other: Currency)
}
