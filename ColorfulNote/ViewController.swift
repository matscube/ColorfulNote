//
//  ViewController.swift
//  ColorfulNote
//
//  Created by TakanoriMatsumoto on 2014/12/31.
//  Copyright (c) 2014年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class ColorfulView: UIView {
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        let touch = touches.anyObject()!
        let location = touch.locationInView(superview)
        self.center = location
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
    
    var newView: UIView?
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
            newView = ColorfulView()
            newView!.backgroundColor = color
            newView!.frame = CGRectMake(0, 0, 50, 50)
            newView!.center = CGPointMake(touch.x, touch.y)
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


}

