//
//  ViewController.swift
//  ColorfulNote
//
//  Created by TakanoriMatsumoto on 2014/12/31.
//  Copyright (c) 2014年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let blueView = UIView()
        blueView.frame = CGRectMake(view.frame.width - 50, 100, 50, 50)
        blueView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.9)
        view.addSubview(blueView)
        
        let gesture = UISwipeGestureRecognizer()
        view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

