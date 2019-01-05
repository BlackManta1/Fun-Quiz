//
//  QuizzViewController.swift
//  Fun Quiz
//
//  Created by Saliou DJALO on 03/01/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
// pour demain, le timer et les vies
// le logo de lappli, les captures, etc..

import UIKit

class QuizzViewController: UIViewController {
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var myQuestion: UILabel!
    @IBOutlet weak var ButtonA: PropositionButton!
    @IBOutlet weak var ButtonB: PropositionButton!
    @IBOutlet weak var ButtonC: PropositionButton!
    @IBOutlet weak var ButtonD: PropositionButton!
    
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var typeDeResponse: UILabel!
    @IBOutlet weak var popUpView: PopUpView!
    @IBOutlet weak var imageSolution: UIImageView!
    @IBOutlet weak var expliSolution: UILabel!
    @IBOutlet weak var scorePopPu: UILabel!
    @IBOutlet weak var buttonPopUp1: PropositionButton!
    
    // timer
    @IBOutlet weak var TimerLabel: UILabel!
    var myTimer = Timer()
    
    var questions = [Question]()
    var questionAsk: Question?
    
    var currentQuestion = 0
    var score = 0
    var gagne = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hiddenPopUp(YesOrNo: true)
        
        // et tu vas me mettre le titre
        title = "Question " + String(currentQuestion + 1)
        // chargement des questions
        questions = self.LoadQuestion()
        // replissage des questions
        self.fillQuizViewController()
        
        // lancer le timer
        
        
        
    }
    
    @objc func processTimer(){
        
        if let testTimerLabelString = TimerLabel.text{
            if let testTimerLabelInt = Int(testTimerLabelString){
                
                let newTime = testTimerLabelInt - 1
                
                if newTime == 0{
                    myTimer.invalidate()
                    showMePopUp(gagne: false, imgAsset: UIImage(named: "timer")!, expliQuest: "Temps ecoule ! C'est perdu !")
                }else{
                    TimerLabel.text = String(newTime)
                }

            }
        }
        
        
        
    }
    
    
    
    
    func LoadQuestion()->[Question]{
        var myQuestions = [Question]()
        
        // on commemce avec deux questions pour linstant

        let questionTheWeeknd = Question(topic: "Musique", myQuest: "Qui est le chanteur des titres : \"I feel it coming\", \"Ordinary life\" et \"Hurt you\" ?", propoA: "The Weeknd", propoB: "Drake", propoC: "Lil Wayne", propoD: "Future (ou Present, je sais plus)", tagRight: 1, imgResponse: UIImage(named: "theWeeknd_Pic")!, expliResponse: "En effet, il s'agissait bien de The Weeknd.")
    
        let questionDaftPunk = Question(topic: "Musique", myQuest: "Sous quel nom de scene se cachent Thomas Bangalter & Guy Manuel de Homem Christo ?", propoA: "Justice", propoB: "Ofenbach", propoC: "Daft Punk", propoD: "Kesako ! C'est qui ces deux la !", tagRight: 3, imgResponse: UIImage(named: "daft-punk")!, expliResponse: "En effet, c'etait bien les Daft Punk.")
        
        myQuestions.append(contentsOf: [questionTheWeeknd, questionDaftPunk])
        
        return myQuestions
    }
    
    //  ou je vais remplir mes questions
    func fillQuizViewController(){
        
        // jenleve le fond noir
        self.hiddenPopUp(YesOrNo: true)
        
        if currentQuestion<questions.count {
           // myQuestion
            questionAsk = questions[currentQuestion]
            if let TestQuestion = questionAsk{
                
                title = "Question " + String(currentQuestion + 1)
                themeLabel.text = TestQuestion.topic
                myQuestion.text = TestQuestion.theQuestion
                ButtonA.setTitle(TestQuestion.propositionA, for: .normal)
                ButtonB.setTitle(TestQuestion.propositionB, for: .normal)
                ButtonC.setTitle(TestQuestion.propositionC, for: .normal)
                ButtonD.setTitle(TestQuestion.propositionD, for: .normal)
            }else{
                self.backToNavigationControler()
            }
            
        currentQuestion = currentQuestion + 1
        }else{
            // bravo tu es un grand gagnant
            score = questions.count
            self.sauvegardeBestScore(ScoreActu: self.score)
            self.backToNavigationControler()
            // il faudra cree un pop up gagnant
        }
        
        // des  quon a terminer de remplir les questions on lance le chrono
        TimerLabel.text = "30"
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(QuizzViewController.processTimer), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func ClickOnProposition(_ sender: Any) {
        
        // des que le gars, clicke sur une proposition on arrete le timer
        myTimer.invalidate()
        
        // je dois ici verifier le tag
        if let testQuest = self.questionAsk, let bouton = sender as? UIButton{
            if bouton.tag == testQuest.tagCorrect{
                // bonne reponse
                gagne = true
                score = score + 1 // je mettrai le score dans le pop up
                self.sauvegardeBestScore(ScoreActu: self.score)
                showMePopUp(gagne: gagne, imgAsset: questions[currentQuestion-1].imageResponse, expliQuest: questions[currentQuestion-1].explicationResponse)
                
            }else{
                // mauvaise response
                // show the pop up
                gagne = false
                //self.backToNavigationControler()
                self.sauvegardeBestScore(ScoreActu: self.score)
                showMePopUp(gagne: gagne, imgAsset: UIImage(named: "nelson")!, expliQuest: "Pour avoir l'explication faut gagner, looser !")
            }
            
        }else{
            // cela signifie quil ya une erreur
            self.backToNavigationControler()
        }
        
        
    }
    
    func showMePopUp(gagne:Bool, imgAsset:UIImage, expliQuest:String){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.hiddenPopUp(YesOrNo: false)
            
        }) { (success) in
            
        }
        
        expliSolution.text = expliQuest
        imageSolution.image = imgAsset
        
        if gagne {
            typeDeResponse.text = "Bonne reponse"
            buttonPopUp1.setTitle("Continuer", for: .normal)
            
        }else{
            typeDeResponse.text = "Mauvaise reponse"
            typeDeResponse.backgroundColor = UIColor.red
            buttonPopUp1.setTitle("Quitter", for: .normal)
        }
        
        // jaffiche le score
        scorePopPu.text = "Score : " + String(score) + "/" + String(questions.count)
        
    }
    
    @IBAction func clickButtonPopUp1(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.gagne {
                self.fillQuizViewController()
            }else{
                self.backToNavigationControler()
            }
        }) { (success) in
            
        }

    }
    
    func backToNavigationControler(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func hiddenPopUp(YesOrNo:Bool){
        if YesOrNo {
            // invisible
            BackView.alpha = 0
            popUpView.alpha = 0
        }else{
            // visible
            BackView.alpha = 1
            popUpView.alpha = 1
        }
    }
    
    func sauvegardeBestScore(ScoreActu:Int){
        let userScore = UserDefaults.standard.integer(forKey: "score")
        if ScoreActu > userScore {
            UserDefaults.standard.set(ScoreActu, forKey: "score")
            UserDefaults.standard.synchronize()
        }
    }

}
