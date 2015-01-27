//
//  EditViewController.swift
//  ColorfulNote
//
//  Created by TakanoriMatsumoto on 2015/01/18.
//  Copyright (c) 2015年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    var viewId: Int!
    var color: UIColor!
    let textView = UITextView()
    let dbManager = DBManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var button = UIButton()
        button.frame = CGRectMake(100, 100, 100, 100)
        button.setTitle("back", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.exclusiveTouch = true
        button.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
        textView.frame = CGRectMake(10, 300, view.bounds.width - 10 * 2, view.bounds.height - 300 - 10)
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        textView.layer.borderWidth = 1
        view.addSubview(textView)
    }
    
    override func viewWillAppear(animated: Bool) {
        textView.backgroundColor = color
        textView.text = dbManager.getText(viewId!)
    }
    
    func back() {
        dbManager.saveText(viewId!, text: textView.text)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
