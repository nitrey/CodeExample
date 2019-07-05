//
//  Currency.swift
//  Created by Alexander Antonov on 08/04/2019.
//

enum Currency: String, Hashable, CaseIterable {
    
    static let rawValueLength = 3
    
    case GBP
    case EUR
    case USD
    case AUD
    case CAD
    case CZK
    case DKK
    case JPY
    case PLN
    case RON
    case SEK
    case BGN
    case BRL
    case CHF
    case CNY
    case HKD
    case HRK
    case HUF
    case IDR
    case ILS
    case INR
    case ISK
    case KRW
    case MXN
    case MYR
    case NOK
    case NZD
    case PHP
    case RUB
    case SGD
    case THB
    case ZAR
    
    var label: String {
        return rawValue
    }
    
    var name: String {
        switch self {
        case .AUD:  return "Australian Dollar"
        case .BGN:  return "Bulgarian lev"
        case .BRL:  return "Brazilian real"
        case .CAD:  return "Canadian dollar"
        case .CHF:  return "Swiss franc"
        case .CNY:  return "Chinese Yuan"
        case .CZK:  return "Czech koruna"
        case .DKK:  return "Danish krone"
        case .EUR:  return "Euro"
        case .GBP:  return "Pound sterling"
        case .HKD:  return "Hong Kong dollar"
        case .HRK:  return "Croatian kuna"
        case .HUF:  return "Hungarian forint"
        case .IDR:  return "Indonesian rupiah"
        case .ILS:  return "Israeli new shekel"
        case .INR:  return "Indian rupee"
        case .ISK:  return "Icelandic króna"
        case .JPY:  return "Japanese yen"
        case .KRW:  return "South Korean won"
        case .MXN:  return "Mexican peso"
        case .MYR:  return "Malaysian ringgit"
        case .NOK:  return "Norwegian krone"
        case .NZD:  return "New Zealand dollar"
        case .PHP:  return "Philippine peso"
        case .PLN:  return "Polish zloty"
        case .RON:  return "Romanian leu"
        case .RUB:  return "Russian ruble"
        case .SEK:  return "Swedish krona"
        case .SGD:  return "Singapore dollar"
        case .THB:  return "Thai baht"
        case .USD:  return "United States dollar"
        case .ZAR:  return "South African rand"
        }
    }
    
}

// MARK: - CustomStringConvertible
extension Currency: CustomStringConvertible {
    
    var description: String {
        return rawValue
    }
    
}
