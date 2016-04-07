//
//  ViewController.swift
//  DayOut
//
//  Created by Prasanthi Relangi on 4/6/16.
//  Copyright © 2016 prasanthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card1ImageView: UIImageView!
    @IBOutlet weak var card1Background: UIImageView!
    @IBOutlet weak var card2ImageView: UIImageView!
    @IBOutlet weak var card2Background: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    var currentCardIndex:Int = 0
    
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    //For pan gesture handling
    var originalCenter: CGPoint!
    var originalTransform: CGAffineTransform!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        originalCenter = card1ImageView.center
        originalTransform = card1ImageView.transform
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLike(sender: AnyObject) {
        doLikeAnimation()
    }

    @IBAction func onCancel(sender: AnyObject) {
        doCancelAnimation()
    }
    
    func doCancelAnimation() {
        var cardView: UIImageView!
        var cardBackgroundView: UIImageView!
        
        if currentCardIndex == 0 {
            cardView = card1ImageView
            cardBackgroundView = card1Background
        }
        else {
            cardView = card2ImageView
            cardBackgroundView = card2Background
        }
        
        cardView.hidden = false
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            self.originalCenter = cardView.center
            self.originalTransform = cardView.transform
            cardView.center = CGPoint(x: self.originalCenter.x-250, y: self.originalCenter.y)
            let angle =  CGFloat(-45 * M_PI/180)
            cardView.transform = CGAffineTransformRotate(self.originalTransform, angle)
            
            }) { (finished:Bool) -> Void in
                if finished == true {
                    cardView.hidden = true
                    cardBackgroundView.hidden = true
                    if self.currentCardIndex == 1 {
                        self.likeButton.hidden = true
                        self.cancelButton.hidden = true
                    }
                    self.currentCardIndex += 1
                }
                
                
        }
        
        
    }
    
    func doLikeAnimation() {
        
        var cardView: UIImageView!
        var cardBackgroundView: UIImageView!
        
        if currentCardIndex == 0 {
            cardView = card1ImageView
            cardBackgroundView = card1Background
        }
        else {
            cardView = card2ImageView
            cardBackgroundView = card2Background
        }
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.originalCenter = cardView.center
            self.originalTransform = cardView.transform
            
            cardView.center = CGPoint(x: self.originalCenter.x+250, y: self.originalCenter.y)
            let angle =  CGFloat(45 * M_PI/180)
            cardView.transform = CGAffineTransformRotate(self.originalTransform, angle)
            
            }) { (finished:Bool) -> Void in
                if finished == true {
                    cardView.hidden = true
                    cardBackgroundView.hidden = true
                    
                    if self.currentCardIndex == 1 {
                        self.likeButton.hidden = true
                        self.cancelButton.hidden = true
                    }
                    self.currentCardIndex += 1
                }
        }
    }
    
    
    
    func doTinderAnimation(sender: UIPanGestureRecognizer, cardView: UIImageView, cardBackgroundView: UIImageView) {
        let translation = sender.translationInView(view)
        let point = sender.locationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            //originalCenter =
            originalCenter = cardView.center
            originalTransform = cardView.transform
            
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            cardView.center = CGPoint(x: self.originalCenter.x + sender.translationInView(view).x, y: originalCenter.y)
            
            var multiplier = 1.0
            if point.y < view.frame.height/2 {
                multiplier = -1.0
            } else {
                multiplier = 1.0
            }
            
            let xOffset = translation.x
            let angle = CGFloat(multiplier * 1 * M_PI/180) / 20 * xOffset
            
            cardView.transform = CGAffineTransformRotate(originalTransform, angle)
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            if translation.x > 100 || translation.x < -100 {
                cardView.hidden = true
                cardBackgroundView.hidden = true
                currentCardIndex += 1
            }
            else {
                cardView.transform = originalTransform
                cardView.center = originalCenter
            }
        }

    }
    
    @IBAction func onCard2Swipe(sender: UIPanGestureRecognizer) {
        
        //print("Card2 panning")
        doTinderAnimation(sender, cardView: card2ImageView, cardBackgroundView: card2Background)
        
        likeButton.hidden = true
        cancelButton.hidden = true
        
        
    }
    @IBAction func onSwipe(sender: UIPanGestureRecognizer) {
        
        //print("Panning")
        doTinderAnimation(sender, cardView: card1ImageView,cardBackgroundView: card1Background)
 
   
        
    }
}

