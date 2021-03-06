//
//  IntentViewController.swift
//  WaitTimeIntentsUI
//
//  Created by Troy Stribling on 6/6/18.
//  Copyright © 2018 Troy Stribling. All rights reserved.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet weak var waitTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>,
                       of interaction: INInteraction,
                       interactiveBehavior: INUIInteractiveBehavior,
                       context: INUIHostedViewContext,
                       completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void)
    {
        switch interaction.intentResponse {
        case let responseIntent as WaitTimeRequestIntentResponse:
            locationLabel.text = responseIntent.location
            waitTimeLabel.text = responseIntent.waitTime?.stringValue
        default:
            return
        }
        completion(true, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        let screenSize = UIScreen.main.bounds.size
        return CGSize(width: screenSize.width, height: 150.0)
    }
    
}
