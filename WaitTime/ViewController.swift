//
//  ViewController.swift
//  WaitTime
//
//  Created by Troy Stribling on 6/6/18.
//  Copyright © 2018 Troy Stribling. All rights reserved.
//

import UIKit
import Intents
import IntentsUI

class ViewController: UIViewController, UITextFieldDelegate, INUIAddVoiceShortcutViewControllerDelegate {

    @IBOutlet weak var waitTimeLabel: UILabel!
    @IBOutlet weak var waitTimeLocationLabel: UILabel!
    @IBOutlet weak var waitTimeLocationTextField: UITextField!
    @IBOutlet weak var waitTimeResultView: UIView!
    @IBOutlet weak var addSiriShortcutButton: UIButton!
    
    var intent: WaitTimeRequestIntent!
    var siriShortcutViewController: INUIAddVoiceShortcutViewController?
    
    var waitTime: Int {
        return Int.random(in: 0..<90)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waitTimeResultView.isHidden = true
        addSiriShortcutButton.isHidden = true
    }
    
    func createWaitTimeRequestIntent(for location: String?, with waitTime: Int) {
        intent = WaitTimeRequestIntent()
        intent.location = location
        intent.suggestedInvocationPhrase = waitTimeLocationTextField.text.map {"\($0) wait time"} ?? "Wait time"
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate { _ in }
    }
    
    @IBAction func handleLocation() {
        let locationWaitTime = waitTime
        let location = waitTimeLocationTextField.text?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        waitTimeLocationTextField.resignFirstResponder()
        waitTimeLabel.text = String(locationWaitTime)
        waitTimeLocationLabel.text = location
        createWaitTimeRequestIntent(for: location, with: locationWaitTime)
        waitTimeResultView.isHidden = false
        addSiriShortcutButton.isHidden = false
    }
    
    @IBAction func handleAddSiriShortCut() {
        guard let intent = intent, let shortcut = INShortcut(intent: intent) else {
            return
        }
        siriShortcutViewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        siriShortcutViewController!.delegate = self
        present(siriShortcutViewController!, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        siriShortcutViewController?.dismiss(animated: true)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        siriShortcutViewController?.dismiss(animated: true)
    }
    
}


