//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Stephanie Parrott on 9/29/15.
//  Copyright © 2015 Stephanie Parrott. All rights reserved.
//

import UIKit

var messageOriginalCenter: CGPoint!
var checkMarkOriginalCenter: CGPoint!
var messageLeft: CGPoint!
var messageRight: CGPoint!
var checkMarkLeft: CGPoint!
var newMessageLeft: CGPoint!
var laterIconLeft: CGPoint!
var contentViewLeft: CGPoint!

class MailboxViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var greenBackground: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var composeButton: UIButton!
    @IBOutlet weak var hamburgerMenu: UIImageView!
    @IBOutlet weak var listView: UIButton!
    @IBOutlet weak var rescheduleView: UIButton!
    @IBOutlet weak var messageFeed: UIImageView!
    @IBOutlet weak var backgroundOverlay: UIView!
    @IBOutlet weak var composeOverlay: UIImageView!
    @IBOutlet weak var composeView: UIView!
    @IBOutlet weak var draftCancelButton: UIButton!
    @IBOutlet weak var laterView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var archiveView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        scrollView.contentSize = imageView.image!.size
    
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        
        contentView.addGestureRecognizer(edgeGesture)
    
        laterView.hidden = true
        archiveView.hidden = true
      
        messageOriginalCenter = messageView.center
        checkMarkOriginalCenter = checkMark.center
        checkMarkLeft = checkMark.frame.origin
        laterIconLeft = laterIcon.frame.origin
        messageLeft = messageView.frame.origin
        messageRight = CGPoint(x: messageView.frame.width, y:messageView.frame.origin.y)
        contentViewLeft = contentView.frame.origin
        
        checkMark.alpha = 0.3
        laterIcon.alpha = 0.0
        rescheduleView.alpha = 0.0
        listView.alpha = 0.0
        backgroundOverlay.alpha = 0.0
        laterView.frame.origin.x = -320
        archiveView.frame.origin.x = 320
        composeView.alpha = 0.0
        laterView.alpha = 0.0
        archiveView.alpha = 0.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // segmented controls
    @IBAction func segmentedControlAction(sender: AnyObject) {
        
        // set colors for segmented controls
        let myYellowColor = UIColor(red: 0.973, green: 0.8, blue: 0.157, alpha: 1)
        let myGreenColor = UIColor(red: 0.384, green: 0.835, blue: 0.314, alpha: 1)
        let myBlueColor = UIColor(red: 0.373, green: 0.722, blue: 0.847, alpha: 1)
        
        let subViewOfSegment: UIView = segmentedControl.subviews[0] as UIView
        
        switch segmentedControl.selectedSegmentIndex
            
        {
        // animate laterView into center
        case 0:
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.laterView.hidden = false
                self.laterView.alpha = 1.0
                self.scrollView.frame.origin.x = 320
                self.laterView.frame.origin.x = 0
                self.archiveView.frame.origin.x = 640
            })
                self.segmentedControl.tintColor = myYellowColor
        
        // animate scrollView into center
        case 1:
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.scrollView.frame.origin.x = 0
                self.laterView.frame.origin.x = -320
                self.archiveView.frame.origin.x = 320
            })
                segmentedControl.tintColor = myBlueColor
        
        // animate archiveView into center
        case 2:
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.archiveView.hidden = false
                self.scrollView.frame.origin.x = -320
                self.laterView.frame.origin.x = -640
                self.archiveView.frame.origin.x = 0
                self.archiveView.alpha = 1.0
            })
                segmentedControl.tintColor = myGreenColor
            
        default:
            break;
        }
    }
    

    // compose message
    @IBAction func onTapComposeButton(sender: UIButton) {
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            self.composeView.alpha = 1.0
            self.composeView.frame.origin = CGPoint(x:self.composeOverlay.frame.origin.x, y:21)
            self.backgroundOverlay.alpha=0.5
            }) { (Bool) -> Void in
        }
    }
    
    // cancel compose message
    @IBAction func onTapCancelButton(sender: AnyObject) {
        
        // cancel action sheet
        let alertController = UIAlertController(title:nil, message:nil, preferredStyle: .ActionSheet)
        
        // delete draft
        let deleteAction = UIAlertAction(title: "Delete Draft", style: .Destructive) { (action) in
            
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseIn, animations: { () -> Void in
                
                // hide keyboard
            UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
                
                // hide message
                self.composeView.frame.origin = CGPoint(x:self.composeOverlay.frame.origin.x, y:568)
                self.backgroundOverlay.alpha=0.0
                }) { (Bool) -> Void in
            }
        }
        
        alertController.addAction(deleteAction)
        
        // keep draft
        let keepAction = UIAlertAction(title: "Keep Draft", style: .Default) { (action) in
            
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                
                //hide keyboard
            UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
                
                //hide message
                self.composeView.frame.origin = CGPoint(x:self.composeOverlay.frame.origin.x, y:568)
                self.backgroundOverlay.alpha=0.0
                }) { (Bool) -> Void in
                    
            }

        }
        
        alertController.addAction(keepAction)
        
        // Cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    // close hamburger menu after opened
    @IBAction func menuButtonPressed(sender: AnyObject) {
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.contentView.frame.origin = CGPoint(x: 0, y: contentViewLeft.y)
        })
    }
    
    // edge pan gesture
    func onEdgePan(edgeGesture: UIScreenEdgePanGestureRecognizer) {
        
        let point = edgeGesture.locationInView(view)
        let velocity = edgeGesture.velocityInView(view)
        let translation = edgeGesture.translationInView(view)
        
        if edgeGesture.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            
        } else if edgeGesture.state == UIGestureRecognizerState.Changed {
            print("View edge left: \(contentView.frame.origin.x)")
            
            contentView.frame.origin = CGPoint(x: contentViewLeft.x + translation.x, y: contentViewLeft.y)
            
        } else if edgeGesture.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            
            // move contentView right
            if contentView.frame.origin.x > 160 {
            
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.contentView.frame.origin = CGPoint(x: 280, y: contentViewLeft.y)
                })
            }
            
            // move contentView left
            else if contentView.frame.origin.x < 160 {
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.contentView.frame.origin = CGPoint(x: 0, y: contentViewLeft.y)
                })
            }
        }
    }

    
    @IBAction func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        
        // set background colors
        let myYellowColor = UIColor(red: 0.973, green: 0.8, blue: 0.157, alpha: 1)
        let myGreenColor = UIColor(red: 0.384, green: 0.835, blue: 0.314, alpha: 1)
        let myRedColor = UIColor(red: 0.894, green: 0.239, blue: 0.153, alpha: 1)
        let myGreyColor = UIColor(red: 0.863, green: 0.863, blue: 0.863, alpha: 1)
        let myBrownColor = UIColor(red: 0.808, green: 0.588, blue: 0.384, alpha: 1)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        let point = panGestureRecognizer.locationInView(view)
        let velocity = panGestureRecognizer.velocityInView(view)
        let translation = panGestureRecognizer.translationInView(view)
        let offset = messageView.frame.origin.x
        
        let tAlpha = convertValue(offset, r1Min:30, r1Max:60, r2Min:0.0, r2Max:1)
        let tAlphaRight = convertValue(offset, r1Min:-30, r1Max:-60, r2Min:0.0, r2Max:1)
        
            if panGestureRecognizer.state == UIGestureRecognizerState.Began {
                print("Gesture began at: \(point)")
                
            } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
                print("Gesture changed at: \(point)")
                
                    //swipe from left
                
                    messageView.frame.origin = CGPoint(x: messageLeft.x + translation.x, y: messageLeft.y)
                    
                    checkMark.alpha = CGFloat(tAlpha)
                    
                    laterIcon.alpha = 0.0
                
                
                    // swipe from left and less than 60 (grey bg)
                
                    if messageView.frame.origin.x < 60 {
                    self.greenBackground.backgroundColor =  myGreyColor
                    
                    checkMark.image = UIImage(named: "archive_icon")
                    }
                
                    // swipe from left and more than 60 (move checkmark)
            
                    if messageView.frame.origin.x > 60 {
                    
                    checkMark.frame.origin = CGPoint(x: checkMarkLeft.x + translation.x-60, y:checkMarkLeft.y)
                    }
            
                    print("checkmark left: \(checkMarkLeft)")
                
                    // swipe from left and between 60 and 260 (green bg)
                
                    if messageView.frame.origin.x > 60 && messageView.frame.origin.x < 260 {
                    
                    self.greenBackground.backgroundColor = myGreenColor
                    
                    checkMark.image = UIImage(named: "archive_icon")
                    
                    }
                
                    // swipe from left and more than 260 (red bg, change checkmark to delete icon)
                
                    if messageView.frame.origin.x > 260 {
                    
                    self.greenBackground.backgroundColor = myRedColor
                    
                    checkMark.image = UIImage(named: "delete_icon")
                    }
                    print("checkmark: \(checkMark.center)")
                
                
                    // swipe from right and move message view
                    
                    messageView.frame.origin = CGPoint(x: messageLeft.x + translation.x, y: messageLeft.y)
                
                    // fade in laterIcon
                    
                    laterIcon.alpha = CGFloat(tAlphaRight)
                
                    //swipe from right - grey while 60px from edge + show laterIcon
                
                    if messageView.frame.origin.x < 0 {
                        self.greenBackground.backgroundColor = myGreyColor
    
                        laterIcon.image = UIImage(named: "later_icon")
                    }
                    print("message: \(messageView.frame.origin.x)")
                
                    // swipe from right and move laterIcon
                
                    if messageView.frame.origin.x < -60 {
                        laterIcon.frame.origin = CGPoint(x: laterIconLeft.x + translation.x+60, y:laterIconLeft.y)
                    }
                
                
                    // swipe from right and show yellow bg
                
                    if messageView.frame.origin.x < -60 && messageView.frame.origin.x > -260 {
                        
                        self.greenBackground.backgroundColor = myYellowColor
                    
                        laterIcon.image = UIImage(named: "later_icon")
                        
                        print("laterIcon: \(laterIcon.frame.origin.x)")
                    }
                
                    // swipe from right and show brown bg
                
                    if messageView.frame.origin.x < -260 {
                        
                        self.greenBackground.backgroundColor = myBrownColor
                        
                        laterIcon.image = UIImage(named: "list_icon")
                        checkMark.alpha = 0.0
                    }
                        print("velocity: \(velocity.x)")
                
                
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
                    print("Gesture ended at: \(point)")
                    
                
                // swipe from left and end after 60
                    
                if velocity.x > 0 && messageView.frame.origin.x > 60 {
                    
                    // move bg across screen and animate messagefeed up
                    
                    UIView.animateWithDuration(0.4,animations: { () -> Void in
                        self.messageView.frame.origin = CGPoint(x:500 , y: messageLeft.y)
                            
                        self.checkMark.center = CGPoint(x: 400, y:checkMarkOriginalCenter.y)
                            
                        }, completion: { (Bool) -> Void in
                            
                                
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                self.greenBackground.alpha = 0.0
                                self.messageFeed.frame.origin.y = self.messageFeed.frame.origin.y - 86
                                })
                            
                            UIView.animateWithDuration(0.0, delay: 1.0, options: .CurveEaseOut, animations: { () -> Void in
                                
                                self.messageView.frame.origin.x = 0.0
                                self.greenBackground.alpha = 1.0
                                
                                }, completion: { (Bool) -> Void in
                                    self.messageFeed.frame.origin.y = self.messageFeed.frame.origin.y + 86
                                    
                            })

                        })
                    
                }
                
                // swipe from right and end when yellow, display rescheduleView
                
                if velocity.x < 0 && messageView.frame.origin.x < -60 && messageView.frame.origin.x > -260 {
                    
                    UIView.animateWithDuration(0.4,animations: { () -> Void in
                        self.messageView.frame.origin = CGPoint(x:-400 , y: messageLeft.y)
                        
                        self.laterIcon.frame.origin = CGPoint(x: -50, y:self.laterIcon.frame.origin.y)
                        
                        }, completion: { (Bool) -> Void in
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                self.rescheduleView.alpha = 1.0
                                self.listView.alpha = 0.0
                             
                            })
                    })
                
                }
                    
                // swipe from right and end when brown, display listView
                
                else if velocity.x < 0 && messageView.frame.origin.x < -260 {
                    
                    UIView.animateWithDuration(0.4,animations: { () -> Void in
                        self.messageView.frame.origin = CGPoint(x: -400 , y: messageLeft.y)
                        
                        self.laterIcon.frame.origin = CGPoint(x: -50, y:self.laterIcon.frame.origin.y)
                        
                        }, completion: { (Bool) -> Void in
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                self.listView.alpha = 1.0
                                
                            })
                    })
                }

                
            
                // swipe from left and gesture ends before 60, move back to edge
                
                if velocity.x > 0 && messageView.frame.origin.x < 60 {
                    
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        
                        self.messageView.frame.origin = CGPoint(x:0, y:messageLeft.y)
                    })
                }
                
                if velocity.x < 0 && messageView.frame.origin.x > -60 {
                    
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        
                        self.messageView.frame.origin = CGPoint(x:0, y:messageLeft.y)
                    })
                }
        }
    }
    
    // tap listView, animate feed up and then push down
    @IBAction func onTapListView(sender: UITapGestureRecognizer) {
   
        UIView.animateWithDuration(0.0, animations: { () -> Void in
            self.listView.alpha = 0.0
            
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.greenBackground.alpha = 0.0
                    self.messageFeed.frame.origin.y = self.messageFeed.frame.origin.y - 86
                })
                    UIView.animateWithDuration(0.0, delay: 1.0, options: .CurveEaseOut, animations: { () -> Void in
                    
                    self.messageView.frame.origin.x = 0.0
                    self.greenBackground.alpha = 1.0
                    
                    }, completion: { (Bool) -> Void in
                        self.messageFeed.frame.origin.y = self.messageFeed.frame.origin.y + 86
                        
                     })
        }
    }
    
    // tap rescheduleView, animate feed up and then push down
    
    @IBAction func onTapReschedue(tapGestureRecognizer: UITapGestureRecognizer) {
        
        UIView.animateWithDuration(0.0, animations: { () -> Void in
            self.rescheduleView.alpha = 0.0
            }) { (Bool) -> Void in
                
            UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.greenBackground.alpha = 0.0
            self.messageFeed.frame.origin.y = self.messageFeed.frame.origin.y - 86
                
               UIView.animateWithDuration(0.0, delay: 1.0, options: .CurveEaseOut, animations: { () -> Void in
                
                    self.messageView.frame.origin.x = 0.0
                    self.greenBackground.alpha = 1.0
                
                    }, completion: { (Bool) -> Void in
                        self.messageFeed.frame.origin.y = self.messageFeed.frame.origin.y + 86
                    })
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
