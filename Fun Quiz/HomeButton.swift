//
//  HomeButton.swift
//  Fun Quiz
//
//  Created by Saliou DJALO on 03/01/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import UIKit

class HomeButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        createButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createButton()
    }
    
    func createButton(){
        layer.cornerRadius = 20
    }
    
}
