//
//  HomepageViewController.swift
//  Fun Quiz
//
//  Created by Saliou DJALO on 03/01/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {
    
    @IBOutlet weak var BestScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fun Quiz"
        
        // Do any additional setup after loading the view.
    }
    
    // quand la vue apparait
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let bestScoreUserDefault = UserDefaults.standard.integer(forKey: "score")
        BestScoreLabel.text = String(bestScoreUserDefault)

    }
    

}
