//
//  MessageViewController.swift
//  Mailbox
//
//  Created by Stephanie Parrott on 10/1/15.
//  Copyright © 2015 Stephanie Parrott. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    @IBOutlet weak var greenBackground: UIImageView!

    @IBOutlet weak var messageView: UIImageView!
    
    @IBOutlet weak var checkMark: UIImageView!
    
    @IBOutlet weak var laterIcon: UIImageView!

    @IBOutlet weak var deleteIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageOriginalCenter = messageView.center
        checkMarkOriginalCenter = checkMark.center
        checkMark.alpha = 0.3
        laterIcon.alpha = 0.0
    

        print("checkmark: \(checkMark.center)")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer){
        
            let point = panGestureRecognizer.locationInView(view)
            let velocity = panGestureRecognizer.velocityInView(view)
            let translation = panGestureRecognizer.translationInView(view)
            let offset = translation.x
        
            let tAlpha = convertValue(offset, r1Min:0, r1Max:60, r2Min:0.1, r2Max:1)
        
        
            if panGestureRecognizer.state == UIGestureRecognizerState.Began {
                print("Gesture began at: \(point)")
                
                
            } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
                print("Gesture changed at: \(point)")
                
                //swipe from left
                
                if velocity.x > 1 {
                    
                    messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
                    
                    
                    print("message: \(messageView.center)")
                
                    checkMark.alpha = CGFloat(tAlpha)
            
                    }
                
                    if point.x < 60 {
                    self.greenBackground.backgroundColor =  UIColor.lightGrayColor()
                        
                    checkMark.image = UIImage(named: "archive_icon")
                    }
                
                    if point.x > 90 {
                    
                    checkMark.center = CGPoint(x: checkMarkOriginalCenter.x + translation.x-50, y:checkMarkOriginalCenter.y)
                    }
                
                    if point.x > 60 && point.x < 260 {
                    
                    self.greenBackground.backgroundColor = UIColor.greenColor()
                        
                    checkMark.image = UIImage(named: "archive_icon")
                        
                    }
                
                    if point.x > 260 {
                        
                        self.greenBackground.backgroundColor = UIColor.redColor()
                        
                        checkMark.image = UIImage(named: "delete_icon")
                    }
                
                    print("checkmark: \(checkMark.center)")
                
                // swipe from right
                
                if velocity.x < 1 {
                    
                    messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
                    
                }
            }

            else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
                print("Gesture ended at: \(point)")
                
                // swipe from left and end after 60
                
                if velocity.x > 1 && point.x > 60 {
            
                    UIView.animateWithDuration(0.4,animations: { () -> Void in
                            self.messageView.center = CGPoint(x:messageOriginalCenter.x + (568-messageOriginalCenter.x) , y: messageOriginalCenter.y)
                            
                            self.checkMark.center = CGPoint(x: 400, y:checkMarkOriginalCenter.y)
                        
                            }, completion: { (Bool) -> Void in
                                self.greenBackground.alpha = 0.0
                    })
                
                    
                }
                
                // swipe from left and gesture ends before 60
                
                if velocity.x > 1 && point.x < 60 {
                    
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        
                        self.messageView.center = CGPoint(x:messageOriginalCenter.x, y: messageOriginalCenter.y)
                        
                        self.checkMark.center = CGPoint(x: 400, y:checkMarkOriginalCenter.y)

                        
                    })
                }
               
            }
    }
}
