//
//  RandomValueViewModel.swift
//  PlumInterview
//
//  Created by kashee on 22/07/23.
//

import Foundation

final class RandomValueViewModel {
    
    var randomValues: [RandomValue] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    
    func getRandomValues() {
        Apis.shared.getData(url: "https://api.chucknorris.io/jokes/random") {  (result: Result<RandomValue, PlumError>) in
            
            self.eventHandler?(.stopLoading)
            switch result {
            case .success(let values):
                self.randomValues.append(values)
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
}


extension RandomValueViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
