//
//  IntentHandler.swift
//  WaitTimeIntents
//
//  Created by Troy Stribling on 6/6/18.
//  Copyright © 2018 Troy Stribling. All rights reserved.
//

import Intents

class IntentHandler: INExtension, WaitTimeRequestIntentHandling {
    
    var waitTime: NSNumber {
        return Int.random(in: 0..<90) as NSNumber
    }
    
    let locationHasWaitTime = ["San Francisco, San Jose, Dallas"]

    func handle(intent: WaitTimeRequestIntent, completion: @escaping (WaitTimeRequestIntentResponse) -> Swift.Void) {
        guard let location = intent.location else {
            let errorRespopnse = WaitTimeRequestIntentResponse(code: .invalidLocation, userActivity: nil)
            completion(errorRespopnse)
            return
        }
        if locationHasWaitTime.contains(location) {
            let response = WaitTimeRequestIntentResponse.success(waitTime: waitTime, location: location)
            completion(response)
        } else {
            let errorRespopnse = WaitTimeRequestIntentResponse.waitTimeNotAvailable(location: location)
            completion(errorRespopnse)
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
}
