//
//  ViewController.swift
//  AVPlayerTest
//
//  Created by 武田 優依 on 2015/11/29.
//  Copyright © 2015年 武田 優依. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton()

        button.setTitle("Tap Me!", forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
        button.frame = CGRectMake(0, 0, 300, 50)
        button.layer.position = CGPoint(x: self.view.frame.width/2, y:100)
        
        button.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.2)
        
        button.addTarget(self, action: "tapped:", forControlEvents:.TouchUpInside)
        
        //viewにボタンを追加する
        self.view.addSubview(button)

    }

    func tapped(sender: UIButton) {
        let filemanager = NSFileManager.defaultManager()
        let documentsPath: AnyObject = NSTemporaryDirectory()
        
        let path = documentsPath.stringByAppendingPathComponent("movie.mp4")//TODO 呼び出すURL毎に変える
        
        if (!filemanager.fileExistsAtPath(path as String)) {
            let url = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            
            var optData:NSData? = nil
            do {
                optData = try NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            }
            catch {
                print("\(error)")
            }
            
            if let data = optData {
                
                data.writeToFile(path, atomically: true)
            }

        } else {
            print("The files already exist")
        }
        
        let player = AVPlayer(URL: NSURL(fileURLWithPath: path as String))

        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        playerViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(playerViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

