//
//  CurrencyRatesService.swift
//  Created by Alexander Antonov on 12/04/2019.
//

import Foundation

// MARK: - Response type
struct CurrencyRatesResponse: Equatable {
    let rates: [CurrencyPair: Decimal]
}

// MARK: - Protocol
protocol CurrencyRatesService {
    func obtainRates(for currencyPairs: [CurrencyPair], completion: @escaping (Result<CurrencyRatesResponse, APIError>) -> Void)
}

// MARK: - Implementation
final class CurrencyRatesServiceImp: CurrencyRatesService {
    
    typealias RawResponse = [String: Decimal]
    
    // MARK: - Properties
    private let networkService: NetworkService
    private let decoder = JSONDecoder()
    
    // MARK: - Init
    init(networkService: NetworkService = NetworkServiceImp()) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    func obtainRates(for currencyPairs: [CurrencyPair], completion: @escaping (Result<CurrencyRatesResponse, APIError>) -> Void) {
        
        guard currencyPairs.isNotEmpty else {
            completion(.failure(.invalidParameters))
            return
        }
        let queryItems = currencyPairs.map { URLQueryItem(name: "pairs", value: $0.rawValue)  }
        let endpoint = Endpoint(destination: APIEndpoints.currencyRates, queryItems: queryItems)
        guard let url = endpoint.url else {
            completion(.failure(.invalidParameters))
            return
        }
        
        networkService.performRequest(url: url) { [weak self] result in
            
            switch result {
                
            case .success(let data):
                guard let self = self, let rawResponse = try? self.decoder.decode(RawResponse.self, from: data) else {
                    completion(.failure(.decoding))
                    return
                }
                var rates: [CurrencyPair: Decimal] = [:]
                rawResponse.forEach {
                    guard let pair = CurrencyPair(rawValue: $0.key) else { return }
                    rates[pair] = $0.value
                }
                let response = CurrencyRatesResponse(rates: rates)
                completion(.success(response))
                
            case .failure:
                completion(.failure(.network))
            }
        }
        
    }
    
}
