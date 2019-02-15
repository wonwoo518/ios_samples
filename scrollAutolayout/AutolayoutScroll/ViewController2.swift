//
//  ViewController2.swift
//  aaa
//
//  Created by 1002237 on 13/02/2019.
//  Copyright © 2019 1002237. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet var myScrollView: UIScrollView!
    lazy var clientView:UIView = {
        return UIView(frame:self.view.bounds)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clientView.addSubview(myScrollView)
        view.addSubview(clientView)
        myScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: myScrollView, attribute: .left, relatedBy: .equal, toItem: clientView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: myScrollView, attribute: .right, relatedBy: .equal, toItem: clientView, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: myScrollView, attribute: .top, relatedBy: .equal, toItem: clientView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: myScrollView, attribute: .bottom, relatedBy: .equal, toItem: clientView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
