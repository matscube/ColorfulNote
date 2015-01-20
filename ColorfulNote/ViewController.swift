//
//  ViewController.swift
//  ColorfulNote
//
//  Created by TakanoriMatsumoto on 2014/12/31.
//  Copyright (c) 2014年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class ColorfulView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
/*        let textView = UITextView()
        textView.frame = CGRectMake(10, 10, 40, 40)
        textView.backgroundColor = UIColor.clearColor()
        self.addSubview(textView)*/
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "edit")
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewTapped: ((view: UIView) -> Void)?
    func edit() {
        viewTapped?(view: self)
    }

    private var locInSelf: CGPoint?
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        let touch = touches.anyObject()! as UITouch
        locInSelf = touch.locationInView(self)
        superview!.bringSubviewToFront(self)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        let touch = touches.anyObject()! as UITouch
        let locationInSuperView = touch.locationInView(superview)
        let x = locationInSuperView.x - locInSelf!.x
        let y = locationInSuperView.y - locInSelf!.y
        self.frame.origin = CGPointMake(x, y)
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let blueView = UIView()
        blueView.frame = CGRectMake(view.frame.width - 50, 100, 50, 50)
        blueView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.8)
        view.addSubview(blueView)
        
        let redView = UIView()
        redView.frame = CGRectMake(0, 100, 50, 50)
        redView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8)
        view.addSubview(redView)

        let yellowView = UIView()
        yellowView.frame = CGRectMake(0, 200, 50, 50)
        yellowView.backgroundColor = UIColor(red: 1, green: 1, blue: 0, alpha: 0.8)
        view.addSubview(yellowView)

        let greenView = UIView()
        greenView.frame = CGRectMake(view.frame.width - 50, 200, 50, 50)
        greenView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
        view.addSubview(greenView)

        let blueGesture = UIPanGestureRecognizer()
        blueGesture.addTarget(self, action: "createBlue:")
        blueView.addGestureRecognizer(blueGesture)
        let redGesture = UIPanGestureRecognizer()
        redGesture.addTarget(self, action: "createRed:")
        redView.addGestureRecognizer(redGesture)
        let yellowGesture = UIPanGestureRecognizer()
        yellowGesture.addTarget(self, action: "createYellow:")
        yellowView.addGestureRecognizer(yellowGesture)
        let greenGesture = UIPanGestureRecognizer()
        greenGesture.addTarget(self, action: "createGreen:")
        greenView.addGestureRecognizer(greenGesture)
    }
    
    var newView: ColorfulView?
    func createRed(gesture: UIPanGestureRecognizer) {
        let color = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8)
        create(gesture, color: color)
    }
    func createBlue(gesture: UIPanGestureRecognizer) {
        let color = UIColor(red: 0, green: 0, blue: 1, alpha: 0.8)
        create(gesture, color: color)
    }
    func createYellow(gesture: UIPanGestureRecognizer) {
        let color = UIColor(red: 1, green: 1, blue: 0, alpha: 0.8)
        create(gesture, color: color)
    }
    func createGreen(gesture: UIPanGestureRecognizer) {
        let color = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
        create(gesture, color: color)
    }
    
    func create(gesture: UIPanGestureRecognizer, color: UIColor) {
        let touch = gesture.locationInView(view)
        let state = gesture.state
        if state == UIGestureRecognizerState.Began {
            let frame = CGRectMake(0, 0, 50, 50)
            newView = ColorfulView(frame: frame)
            newView!.backgroundColor = color
            newView!.center = CGPointMake(touch.x, touch.y)
            newView!.viewTapped = {
                [unowned self] (view: UIView) in
                self.edit()
            }
            view.addSubview(newView!)
        } else if state == UIGestureRecognizerState.Changed {
            newView!.center = CGPointMake(touch.x, touch.y)
        } else if state == UIGestureRecognizerState.Ended {
            newView = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func edit() {
        self.performSegueWithIdentifier("EditSegue", sender: self)
    }
    
}

