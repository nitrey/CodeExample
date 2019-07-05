//
//  CurrencyPair.swift
//  Created by Alexander Antonov on 09/04/2019.
//

struct CurrencyPair: Hashable {
    
    let first: Currency
    let second: Currency
    
    var rawValue: String {
        return "\(first.rawValue)\(second.rawValue)"
    }
    
}

extension CurrencyPair {
    
    init?(rawValue: String) {
        guard rawValue.count == 2 * Currency.rawValueLength,
            let first = Currency(rawValue: rawValue.prefix(Currency.rawValueLength).toString),
            let second = Currency(rawValue: rawValue.suffix(Currency.rawValueLength).toString),
            first != second
        else { return nil }
        self.first = first
        self.second = second
    }
    
    init?(from object: CurrencyPairObject) {
        self.init(rawValue: object.rawValue)
    }
    
}
