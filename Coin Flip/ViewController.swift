//
//  ViewController.swift
//  Coin Flip
//
//  Created by Ronald Fischer on 9/17/15.
//  Copyright © 2015 qpiapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum CoinSides {
        case HEADS
        case HEADS_ANGLE_1
        case HEADS_ANGLE_2
        case SIDE1
        case TAILS
        case TAILS_ANGLE_1
        case TAILS_ANGLE_2
        case SIDE2
    }
    var curCoinSide = CoinSides.HEADS
    var timer = NSTimer()
    var isAnimating = false
    var flips = 0
    
    @IBOutlet weak var coinSide: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    
    @IBAction func coinFlip(sender: AnyObject) {
        flips = Int(arc4random_uniform(5)) + 1
        
        if isAnimating == true {
            Flurry.logEvent("FlipIt User halted flips")
            timer.invalidate()
            isAnimating = false
        } else {
            Flurry.logEvent("FlipIt User started flips")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.13, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
            isAnimating = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        coinSide.text = "Heads"
    }
    
    func doAnimation() {

        if curCoinSide == CoinSides.HEADS {
            coinImage.image = UIImage(named: "headangle.png")
            curCoinSide = CoinSides.HEADS_ANGLE_1
        } else if curCoinSide == CoinSides.HEADS_ANGLE_1 {
            coinImage.image = UIImage(named: "side.png")
            curCoinSide = CoinSides.SIDE1
        } else if curCoinSide == CoinSides.SIDE1 {
            coinImage.image = UIImage(named: "tailangle2.png")
            curCoinSide = CoinSides.TAILS_ANGLE_2
        } else if curCoinSide == CoinSides.TAILS_ANGLE_2 {
            coinImage.image = UIImage(named: "tail.png")
            curCoinSide = CoinSides.TAILS
            coinSide.text = "Tails"
            flips = flips - 1
        } else if curCoinSide == CoinSides.TAILS {
            coinImage.image = UIImage(named: "tailangle.png")
            curCoinSide = CoinSides.TAILS_ANGLE_1
        } else if curCoinSide == CoinSides.TAILS_ANGLE_1 {
            coinImage.image = UIImage(named: "side2.png")
            curCoinSide = CoinSides.SIDE2
        } else if curCoinSide == CoinSides.SIDE2 {
            coinImage.image = UIImage(named: "headangle2.png")
            curCoinSide = CoinSides.HEADS_ANGLE_2
        } else if curCoinSide == CoinSides.HEADS_ANGLE_2 {
            coinImage.image = UIImage(named: "head.png")
            curCoinSide = CoinSides.HEADS
            coinSide.text = "Heads"
            flips = flips - 1
        }

        if flips == 0 {
            timer.invalidate()
            isAnimating = false
            
            if curCoinSide == CoinSides.HEADS {
                Flurry.logEvent("FlipIt HEADS event")
            } else {
                Flurry.logEvent("FlipIt TAILS event")
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

