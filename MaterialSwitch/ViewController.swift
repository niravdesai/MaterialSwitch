//
//  ViewController.swift
//  MaterialSwitch
//
//  Created by Nirav Desai on 04/10/21.
//

import UIKit

class ViewController: UIViewController, MaterialSwitchDelegate {
    func switchDidChangeState(aSwitch: MaterialSwitch, currentState: MaterialSwitchState) {
        if currentState == .On {
            print("Switch was turned on")
        } else {
            print("Switch was turned off")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size: MaterialSwitchSize = (0, 0, 44)
        let aSwitch = MaterialSwitch(size: size)
        aSwitch.setup(delegate: self)
        aSwitch.center = self.view.center
        self.view.addSubview(aSwitch)
    }
}


