//
//  QuizzViewController.swift
//  Fun Quiz
//
//  Created by Saliou DJALO on 03/01/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
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
    @IBOutlet weak var nbLifeLabel: UILabel!
    
    var myTimer = Timer()
    
    var questions = [Question]()
    var questionAsk: Question?
    
    var currentQuestion = 0
    var score = 0
    var nbLife = 2
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
        
        
    }
    
    @objc func processTimer(){
        
        if let testTimerLabelString = TimerLabel.text{
            if let testTimerLabelInt = Int(testTimerLabelString){
                
                let newTime = testTimerLabelInt - 1
                
                if newTime == 0{
                    nbLife = nbLife - 1
                    nbLifeLabel.text = String(nbLife)
                    self.gagne = false
                    myTimer.invalidate()
                    if nbLife == 0{
                        showMePopUp(gagne: gagne, imgAsset: UIImage(named: "game-over")!, expliQuest: "Time out. The end, Loser !!")
                    }else{
                        showMePopUp(gagne: self.gagne, imgAsset: UIImage(named: "dali-temps")!, expliQuest: "Time out ! Fait gaffe il te reste \(nbLife) vies.")
                    }

                }else{
                    TimerLabel.text = String(newTime)
                }

            }
        }
        
    }

    func LoadQuestion()->[Question]{
        var myQuestions = [Question]()
        
        // charactere speciaux
        //è
        //é
        //à
        //ç

        let questionTheWeeknd = Question(topic: "Musique", myQuest: "Qui est le chanteur des titres : \"I feel it coming\", \"Ordinary life\" et \"Hurt you\" ?", propoA: "The Weeknd", propoB: "Drake", propoC: "Lil Wayne", propoD: "Future (ou Present, je sais plus)", tagRight: 1, imgResponse: UIImage(named: "theWeeknd_Pic")!, expliResponse: "En effet, il s'agissait du beau The Weeknd.")
    
        let questionDaftPunk = Question(topic: "Musique", myQuest: "Sous quel nom de scène se cachent Thomas Bangalter & Guy Manuel de Homem Christo ?", propoA: "Justice", propoB: "Ofenbach", propoC: "Daft Punk", propoD: "Késako ! C'est qui ces deux là !", tagRight: 3, imgResponse: UIImage(named: "daft-punk")!, expliResponse: "En effet, c'était bien les Daft Punk.")
        
        let questionEvanSpiegel = Question(topic: "Technologie", myQuest: "Qui sont les deux fondateurs de l'application Snapchat ?", propoA: "Evan Spiegel & Bobby Murphy", propoB: "Ben & Nuts", propoC: "Kevin Systrom & Mike Krieger", propoD: "Gad & Kev", tagRight: 1, imgResponse: UIImage(named: "evan&bobby")!, expliResponse: "Of course. Evan tu es mon idole.")
        
        let questionSuperHero = Question(topic: "Super héros", myQuest: "Lequel de ces super héros est un héros Marvel ?", propoA: "Aquaman", propoB: "Superman", propoC: "Iron man", propoD: "Batman", tagRight: 3, imgResponse: UIImage(named: "ironMan")!, expliResponse: "Exactement. Les autres sont des héros DC Comics.")
        
        let questionAvengers = Question(topic: "Super héros", myQuest: "Dans Avengers Infinite War, il parvient à réunir les 6 germes de l'infini. Mais de qui parle t'on ?", propoA: "Thanos", propoB: "Tétanos", propoC: "Mentos", propoD: "Adèle Exarchopoulos", tagRight: 1, imgResponse: UIImage(named: "thanos")!, expliResponse: "Facile, c'était juste pour voir si tu suivais.")
        
        let questionMentalist = Question(topic: "Série", myQuest: "Mentalist, saison 6, épisode 8, l'identité de John le Rouge est enfin révélé !", propoA: "Patrick Jane", propoB: "Patrick Sauce", propoC: "le shérif thomas McAlister", propoD: "Kimball Cho", tagRight: 3, imgResponse: UIImage(named: "johnLeRouge")!, expliResponse: "Lol, je vois que t'as regardé la serie.")
        
        let questionEddyMurphy = Question(topic: "Célébrité", myQuest: "Combien d'enfants à le célèbre Eddie Murphy ?", propoA: "Aucun", propoB: "5 enfants avec 5 femmes différentes.", propoC: "10 enfants avec 5 femmes différentes.", propoD: "Autant que le roi de Swaziland.", tagRight: 3, imgResponse: UIImage(named: "eddieMurphy10")!, expliResponse: "Incroyable, mais vrai le gars à 10 gamins. Fort le Eddy !")
        
        let questionLangageProg = Question(topic: "IT", myQuest: "Faire une appli demande un long travail. Quel est le langage de programmation qui se cache derrière ce quiz ?", propoA: "Le langage des geeks", propoB: "Le langage VBA", propoC: "Le langage JavaScript", propoD: "Le langage Swift (non inventé par Taylor Swift)", tagRight: 4, imgResponse: UIImage(named: "swift")!, expliResponse: "Est pourtant c'est bien le Swift, anciennement Objectif C.")
        
        let questionBurger = Question(topic: "Bouffe", myQuest: "Lequel de ces burgers est le plus calorique : (Après ça c'est légumes pour le reste de ta semaine).", propoA: "Le Big Tasty, McDonald's", propoB: "Le Double Whopper, Burger King", propoC: "Le Big King XXL", propoD: "Le grand Veggie (l'arnaque du siècle)", tagRight: 3, imgResponse: UIImage(named: "big-king-xxl")!, expliResponse: "Avec 971 calories sur le Big King XXL, il écrase toute la concurrence.")
        
        let questionKeemaNan = Question(topic: "Bouffe", myQuest: "Ah mince, j'ai oublié. Tu peux me rappeler comment s'appelle cette pate de pain indienne fourrée de viande et accompagnée d'une sauce", propoA: "Le naan", propoB: "Le Keema Naan", propoC: "Le poulet tikka madras", propoD: "L'agneau poriyal", tagRight: 2, imgResponse: UIImage(named: "keema-naan")!, expliResponse: "Toi t'as déjà mangé indien.")
        
        let questionSenegal = Question(topic: "Géographie", myQuest: "Quelle est la capitale du Sénégal ?", propoA: "M'Bour", propoB: "Kolda", propoC: "Gorée", propoD: "Dakar", tagRight: 4, imgResponse: UIImage(named: "dakar")!, expliResponse: "Oui, c'est bien Dakar. T'es fort en géo toi.")
        
        let questionMaireLondres = Question(topic: "Politique", myQuest: "Parmi ces personnes a été élu maire de Londres le 5 Mai 2016 ?", propoA: "Shahrukh Khan", propoB: "Sadiq Khan", propoC: "Salman Khan", propoD: "Jean Michel Courtault", tagRight: 2, imgResponse: UIImage(named: "sadiq-khan")!, expliResponse: "Bravo, c'est Sadiq Khan, également le premier maire musulman de Londres.")
        
        let questionLeVau = Question(topic: "Histoire", myQuest: "Qui était Louis Le Vau ?", propoA: "Un animal", propoB: "Un architecte francais", propoC: "Un écrivain francais", propoD: "L'inventeur du Vau(cluse)", tagRight: 2, imgResponse: UIImage(named: "louis-le-vau")!, expliResponse: "En effet, il faisait parti des architectes francais de Louis le grand à Versailles.")
        
        let questionNadal = Question(topic: "Sport", myQuest: "Combien de fois Nadal a t'il remporté Roland Garros ?", propoA: "9 fois", propoB: "10 fois", propoC: "11 fois", propoD: "3500 fois, tellement il est fort.", tagRight: 3, imgResponse: UIImage(named: "rafa-nadal-rg")!, expliResponse: "11 fois, c'est quand même incroyable.")
        
        let questionBugatti = Question(topic: "Maths", myQuest: "J'ai envie d'acheter une bugatti chiron. Elle coute 2.5 millions d'€. Je mets de cote tous les mois 2000 €. Au bout de combien de temps pourrais-je avoir la voiture de mes rêves ?", propoA: "90.67 ans", propoB: "104.16 ans", propoC: "134.67 ans", propoD: "Lol. La 812 Superfast est mieux.", tagRight: 2, imgResponse: UIImage(named: "chiron")!, expliResponse: "Le calcul est simple : 2000 x 12 x 104 = 2.5 Millions d'€. Easy !")
        
        let questionJeuxVideos = Question(topic: "Jeux Videos", myQuest: "Lequel de ces individus n'est pas un personnage de jeux vidéos ?", propoA: "Marcus Holloway", propoB: "Trevor Philips", propoC: "Alex Hunter", propoD: "John Reese", tagRight: 4, imgResponse: UIImage(named: "john-reese")!, expliResponse: "John Reese est un personnage de série dans Person of Interest.")
        
        let questionPhraseKaaris = Question(topic: "Philosophie", myQuest: "Qui est l'origine de cette citation : Comme les étoiles, seule l'explosion intérieure te permettra de briller ?", propoA: "L'astronaute Thomas Pesquiet", propoB: "Le philosophe Platon", propoC: "L'écrivain Victor Hugo", propoD: "Le barrageur Kaaris", tagRight: 4, imgResponse: UIImage(named: "kaaris")!, expliResponse: "Et ouais, c'est vraiment Kaaris. Phrase citée dans le morceau \"Oiseaux\".")
        
        myQuestions.append(contentsOf: [questionTheWeeknd, questionDaftPunk, questionEvanSpiegel, questionSuperHero, questionAvengers, questionMentalist, questionEddyMurphy, questionLangageProg, questionBurger, questionKeemaNan, questionSenegal, questionMaireLondres, questionLeVau, questionNadal, questionBugatti,questionJeuxVideos,questionPhraseKaaris])
        
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
                
                // gestion des nombres de vies
                nbLife = nbLife - 1
        
                // afficher le nombre de vie
                nbLifeLabel.text = String(nbLife)
                
                // mauvaise response
                // show the pop up
                self.gagne = false
                //self.backToNavigationControler()
                self.sauvegardeBestScore(ScoreActu: self.score)
                
                if nbLife == 0 {
                    showMePopUp(gagne: gagne, imgAsset: UIImage(named: "game-over")!, expliQuest: "Loser !!")
                }else{
                    showMePopUp(gagne: gagne, imgAsset: UIImage(named: "nelson")!, expliQuest: "Fait gaffe, il te reste \(nbLife) vies !")
                }

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
        
        // just here
        expliSolution.text = expliQuest
        imageSolution.image = imgAsset
        
        if nbLife == 0 {
            typeDeResponse.text = "Perdu"
            typeDeResponse.backgroundColor = UIColor.black
            typeDeResponse.textColor = UIColor.white
            buttonPopUp1.setTitle("Quitter", for: .normal)
        }else{
            
            typeDeResponse.textColor = UIColor.black
            buttonPopUp1.setTitle("Continuer", for: .normal)
            if gagne {
                typeDeResponse.text = "Bonne réponse"
                typeDeResponse.backgroundColor = UIColor.green

            }else{
                typeDeResponse.text = "Mauvaise réponse"
                typeDeResponse.backgroundColor = UIColor.red
            }
        }
        

        
        // jaffiche le score
        scorePopPu.text = "Score : " + String(score) + "/" + String(questions.count)
        
    }
    
    @IBAction func clickButtonPopUp1(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.nbLife != 0 {
                self.fillQuizViewController()
            }else {
                self.nbLife = 2
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

// regarder si on peut sauvegader le numero de question apres une sortie de lutilisateur

