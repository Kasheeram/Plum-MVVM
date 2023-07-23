//
//  RandomValueViewModel.swift
//  PlumInterview
//
//  Created by kashee on 22/07/23.
//

import Foundation

final class RandomValuesViewModel {
    
    var randomValues: [RandomValueViewModel] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    
    func getRandomValues() {
        Apis.shared.getData(url: "https://api.chucknorris.io/jokes/random") {  (result: Result<RandomValue, PlumError>) in
            
            self.eventHandler?(.stopLoading)
            switch result {
            case .success(let values):
                self.randomValues.append(RandomValueViewModel(randomValue: values))
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
}

class RandomValueViewModel {
    var iconUrl: String
    var value: String
    
    // Dependency Injection (DI)
    init(randomValue: RandomValue) {
        self.iconUrl = randomValue.iconUrl ?? ""
        self.value = randomValue.value ?? ""
    }
}


extension RandomValuesViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
