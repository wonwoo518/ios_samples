//
//  ViewController.swift
//  aaa
//
//  Created by 1002237 on 12/02/2019.
//  Copyright © 2019 1002237. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func aaa(_ sender: Any) {
        var v2 = ViewController2.init(nibName: "ViewController2", bundle: nil)
        self.navigationController?.pushViewController(v2, animated: true)
    }
}

