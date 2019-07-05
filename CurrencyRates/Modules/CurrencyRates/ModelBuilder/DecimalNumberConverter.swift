//
//  DecimalNumberConverter.swift
//  Created by Alexander Antonov on 13/04/2019.
//

import Foundation

protocol DecimalNumberConverter {
    func valueText(for value: Decimal?) -> ValueText?
}

final class DecimalNumberConverterImp: DecimalNumberConverter {
    
    private let settings: Settings
    
    init(settings: Settings = .default) {
        self.settings = settings
    }
    
    private lazy var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = settings.fractionDigitsCount
        formatter.maximumFractionDigits = settings.fractionDigitsCount
        formatter.decimalSeparator = settings.separator
        return formatter
    }()
    
    func valueText(for value: Decimal?) -> ValueText? {
        guard let value = value, let stringValue = valueFormatter.string(from: value as NSDecimalNumber) else {
            return nil
        }
        let lastTwoChars = stringValue.suffix(2)
//        let centicents = (lastTwoChars == "00") ? "" : lastTwoChars.toString
        let centicents = lastTwoChars.toString
        let mainValue = stringValue.dropLast(2).toString
        return ValueText(mainValue: mainValue, centicents: centicents)
    }
    
}

extension DecimalNumberConverterImp {
    
    struct Settings {
        
        var fractionDigitsCount = 4
        var separator = "."
        
        static var `default`: Settings {
            return Settings()
        }
    }
    
}
