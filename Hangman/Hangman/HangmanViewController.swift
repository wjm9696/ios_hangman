//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var currentWord: UILabel!
    @IBOutlet weak var prevLetter: UILabel!
    @IBOutlet weak var incorrects: UILabel!
    var hangmanModel : HangmanModel?
    var currentPressLetter = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        currentWord.text = phrase
        print(phrase)
        hangmanModel = HangmanModel(word:phrase)
        currentWord.text = hangmanModel?.getCurrentDisplayWord()
        image.image = UIImage(named: "hangman1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func pressGuess(_ sender: UIButton) {
        
        if let model = hangmanModel{
            if(model.tryLetter(letter: currentPressLetter)){
                currentWord.text = model.getCurrentDisplayWord()
                if(model.checkWin()){
                    let alert = UIAlertController(title: "Good Job", message: "You win", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default, handler: { (action) in
                        self.restart()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                incorrects.text = model.getIncorrectString()
                image.image = UIImage(named: model.getImgName())
                if(model.checkLost()){
                    let alert = UIAlertController(title: "Oh No", message: "You lose", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default, handler: { (action) in
                        self.restart()
                    }))
                    self.present(alert, animated: true, completion: nil)

                }
            }
        
        }
    }
    @IBAction func startOver(_ sender: UIButton) {
        restart()
    }
    
    func restart(){
        viewDidLoad()
        incorrects.text = ""
        currentPressLetter = ""
        prevLetter.text = ""
    }
    
    @IBAction func pressLetter(_ sender: UIButton) {
        if let buttonName = sender.titleLabel{
            prevLetter.text = buttonName.text
            currentPressLetter = buttonName.text!
        }
        
    }
}
