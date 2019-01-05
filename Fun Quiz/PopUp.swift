//
//  PopUp.swift
//  Fun Quiz
//
//  Created by Saliou DJALO on 04/01/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import Foundation
import UIKit

class PopUpView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        PopUpStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        PopUpStyle()
    }
    
    func PopUpStyle() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
    }
}
