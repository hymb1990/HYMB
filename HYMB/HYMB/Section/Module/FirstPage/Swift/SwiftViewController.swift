//
//  SwiftViewController.swift
//  HYMB
//
//  Created by 863Soft on 2019/4/4.
//  Copyright © 2019 hymb. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    
    @IBAction func goAnimationVC(_ sender: Any) {
        
        let VC = AnimationRefreshVC()
        self.navigationController?.pushViewController(VC, animated: true);
    }
    
}
