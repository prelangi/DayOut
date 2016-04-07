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
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
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
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.card1ImageView.center = CGPoint(x: self.originalCenter.x+250, y: self.originalCenter.y)
            let angle =  CGFloat(45 * M_PI/180)
            self.card1ImageView.transform = CGAffineTransformRotate(self.originalTransform, angle)
            
            }) { (finished:Bool) -> Void in
                if finished == true {
                    self.card1ImageView.hidden = true
                }
                
                
        }
        
    }

    @IBAction func onCancel(sender: AnyObject) {
        
        card1ImageView.hidden = false
        card1ImageView.center = originalCenter
        card1ImageView.transform = originalTransform
        
//        self.card1ImageView.hidden = false
//        UIView.animateWithDuration(1.0, animations: { () -> Void in
//            self.card1ImageView.center = CGPoint(x: self.originalCenter.x-250, y: self.originalCenter.y)
//            let angle =  CGFloat(-45 * M_PI/180)
//            self.card1ImageView.transform = CGAffineTransformRotate(self.originalTransform, angle)
//            
//            }) { (finished:Bool) -> Void in
//                if finished == true {
//                    self.card1ImageView.hidden = true
//                }
//                
//                
//        }
        
        
        
    }
    
    @IBAction func onSwipe(sender: UIPanGestureRecognizer) {
        
        print("Panning")
        
        let translation = sender.translationInView(view)
        let point = sender.locationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            //originalCenter =
            originalCenter = card1ImageView.center
            originalTransform = card1ImageView.transform
            
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            card1ImageView.center = CGPoint(x: self.originalCenter.x + sender.translationInView(view).x, y: originalCenter.y)
            
            var multiplier = 1.0
            if point.y < view.frame.height/2 {
                multiplier = -1.0
            } else {
                multiplier = 1.0
            }
            
            let xOffset = translation.x
            let angle = CGFloat(multiplier * 1 * M_PI/180) / 20 * xOffset
            
            self.card1ImageView.transform = CGAffineTransformRotate(originalTransform, angle)
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            if translation.x > 100 || translation.x < -100 {
                self.card1ImageView.hidden = true
            }
            else {
                self.card1ImageView.transform = originalTransform
                self.card1ImageView.center = originalCenter
            }
        }

        
        
    }
}

