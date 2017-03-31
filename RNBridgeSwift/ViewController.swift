//
//  ViewController.swift
//  RNBridgeSwift
//
//  Created by 王垒 on 2017/3/30.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit

import React

public let WLWindowWidth = UIScreen.main.bounds.size.width

public let WLWindowHeight = UIScreen.main.bounds.size.height




class ViewController: UIViewController {
    
    var welcomeLabel : UILabel!
    
    var thankLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "原生VC"
        
        let btn = UIButton()
        
        btn.backgroundColor = UIColor.yellow
        
        btn.frame = CGRect.init(x: (WLWindowWidth-100) / 2, y: (WLWindowHeight-64-100)/2, width: 100, height: 100)
        
        btn.setTitle("Test", for: .normal)
        
        btn.setTitleColor(.red, for: .normal)
        
        btn.addTarget(self, action: #selector(ViewController.btnClick), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        self.welcomeLabel = UILabel()
        
        self.welcomeLabel.frame = CGRect.init(x: 20, y: (WLWindowHeight-64-100)/2 + 130, width: WLWindowWidth - 40, height: 40)
        
        self.welcomeLabel.backgroundColor = UIColor.red
        
        self.welcomeLabel.textColor = UIColor.white
        
        self.welcomeLabel.textAlignment = .center
        
        self.welcomeLabel.text = "大家好，我叫王垒"
        
        self.view.addSubview(self.welcomeLabel)
        
        self.thankLabel = UILabel()
        
        self.thankLabel.frame = CGRect.init(x: 20, y: self.welcomeLabel.frame.origin.y + 50, width: WLWindowWidth - 40, height: 40)
        
        self.thankLabel.backgroundColor = UIColor.red
        
        self.thankLabel.textColor = UIColor.white
        
        self.thankLabel.textAlignment = .center
        
        self.thankLabel.text = "英文名字King"
        
        self.view.addSubview(self.thankLabel)

    }
    
    func btnClick(){
        
        let localJSPath = URL.init(string:"http://localhost:8081/index.ios.bundle?platform=ios")
        
        let params:[String:Array<Dictionary<String, String>>] = [
        
            "scores" : [
                ["name":"iOS","value":"6"],
                ["name":"Swift","value":"66"],
            ]
        ]
        
        let rootView : RCTRootView = RCTRootView(bundleURL: localJSPath, moduleName: "RNTestViewModule", initialProperties: params, launchOptions: nil)
        
        let rnViewController = RNManagerViewController.init(backBlock: { (backParams) in
            print(backParams)
            
            if backParams is Dictionary<String, String>  {
                
                let dict = backParams as! Dictionary<String, String>
                
                self.welcomeLabel.text = dict["name"]
                self.thankLabel.text = dict["url"]
            }
            
        }) { (vc, nextParams) in
            print("vc=%@ \n  params=%@",vc,params)
        }
        
        rnViewController.view = rootView
        
        rnViewController.title = "JS写的视图"
        
        self.navigationController?.pushViewController(rnViewController, animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

