//
//  ViewController.swift
//  ColorfulNote
//
//  Created by TakanoriMatsumoto on 2014/12/31.
//  Copyright (c) 2014年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class ColorfulView: UIView {
    
    var id: Int!
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
    
    var viewTapped: ((view: ColorfulView) -> Void)?
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

    var nextViewId: Int = 0
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
    var views = [ColorfulView]()
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
    
    let dbManager = DBManager()
    func create(gesture: UIPanGestureRecognizer, color: UIColor) {
        let touch = gesture.locationInView(view)
        let state = gesture.state
        if state == UIGestureRecognizerState.Began {
            let frame = CGRectMake(0, 0, 150, 150)
            newView = ColorfulView(frame: frame)
            newView!.id = nextViewId
            dbManager.resetText(nextViewId)

            nextViewId++
            newView!.backgroundColor = color
            newView!.center = CGPointMake(touch.x, touch.y)
            newView!.viewTapped = {
                [unowned self] (view: ColorfulView) in
                self.edit(view.id)
            }
            view.addSubview(newView!)

        } else if state == UIGestureRecognizerState.Changed {
            newView!.center = CGPointMake(touch.x, touch.y)
        } else if state == UIGestureRecognizerState.Ended {
            views.append(newView!)
            newView = nil
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        for view in views {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private var editViewId: Int?
    private var editViewColor: UIColor?
    func edit(viewId: Int) {
        editViewId = viewId
        editViewColor = views[viewId].backgroundColor
        self.performSegueWithIdentifier("EditSegue", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextVC = segue.destinationViewController as EditViewController
        nextVC.viewId = editViewId!
        nextVC.color = editViewColor
    }
    
}

