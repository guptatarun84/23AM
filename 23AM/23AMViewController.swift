//
//  23AMViewController.swift
//  23AM
//
//  Created by Gupta, tarun(AWF) on 5/25/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import UIKit
import AWSAuthCore
import AWSAuthUI
import AWSMobileClient
import AWSUserPoolsSignIn

class _3AMViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
//		if !AWSSignInManager.sharedInstance().isLoggedIn {
//			AWSAuthUIViewController
//				.presentViewController(with: self.navigationController!,
//									   configuration: nil,
//									   completionHandler: { (provider: AWSSignInProvider, error: Error?) in
//										if error != nil {
//											print("Error occurred: \(String(describing: error))")
//										} else {
//											// Sign in successful.
//										}
//				})
//		}
		if !AWSSignInManager.sharedInstance().isLoggedIn {
			presentAuthUIViewController()
		}
    }
	

	func presentAuthUIViewController() {
		let config = AWSAuthUIConfiguration()
		config.enableUserPoolsUI = true
		config.backgroundColor = UIColor.blue
		config.font = UIFont (name: "Helvetica Neue", size: 20)
		config.isBackgroundColorFullScreen = true
		config.canCancel = true
		
		AWSAuthUIViewController.presentViewController(
			with: self.navigationController!,
			configuration: config, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
				if error == nil {
					// SignIn succeeded.
				} else {
					// end user faced error while loggin in, take any required action here.
				}
		})
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
