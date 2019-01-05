//
//  Question.swift
//  Fun Quiz
//
//  Created by Saliou DJALO on 03/01/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import Foundation
import UIKit


class Question{
    
    private var _topic:String
    private var _theQuestion:String
    
    private var _propositionA:String
    private var _propositionB:String
    private var _propositionC:String
    private var _propositionD:String
    
    private var _tagCorrect:Int
    
    private var _imageResponse:UIImage
    private var _explicationResponse:String
    
    var topic:String{
        return self._topic
    }
    
    var theQuestion:String{
        return _theQuestion
    }
    
    var propositionA:String{
        return self._propositionA
    }
    
    var propositionB:String{
        return self._propositionB
    }
    
    var propositionC:String{
        return self._propositionC
    }
    
    var propositionD:String{
        return self._propositionD
    }
    
    var tagCorrect:Int{
        return self._tagCorrect
    }
    
    var imageResponse:UIImage{
        return self._imageResponse
    }
    
    var explicationResponse:String{
        return self._explicationResponse
    }
    
    init(topic:String, myQuest:String, propoA:String, propoB:String,propoC:String,propoD:String,tagRight:Int, imgResponse:UIImage, expliResponse:String) {
        self._topic=topic
        self._theQuestion=myQuest
        self._propositionA=propoA
        self._propositionB=propoB
        self._propositionC=propoC
        self._propositionD=propoD
        self._tagCorrect=tagRight
        self._imageResponse=imgResponse
        self._explicationResponse=expliResponse
    }
    
}
