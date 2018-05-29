//
//  ViewController.swift
//  23AM
//
//  Created by Tarun Gupta on 5/12/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import UIKit
import SwiftyJSON
import AWSCognitoAuth

class ViewController: UIViewController, AWSCognitoAuthDelegate {
	func getViewController() -> UIViewController {
		return self;
	}

	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var logoutButton: UIButton!
	var auth: AWSCognitoAuth = AWSCognitoAuth.default()
	var session: AWSCognitoAuthUserSession?
	var firstLoad: Bool = true
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.auth.delegate = self;
		if(self.auth.authConfiguration.appClientId.contains("SETME")){
			self.alertWithTitle("Error", message: "Info.plist missing necessary config under AWS->CognitoUserPool->Default")
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if(self.firstLoad){
			self.loginClicked(loginButton)
		}
		self.firstLoad = false
	}
	
	func alertWithTitle(_ title:String, message:String?) -> Void {
		DispatchQueue.main.async {
			let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
			let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) in
				alert.dismiss(animated: false, completion: nil)
			}
			alert.addAction(action)
			self.present(alert, animated: true, completion: nil)
		}
	}

	@IBAction func loginClicked(_ sender: Any) {
//		getAddress(completionHandler: { response, error in
//			print(response!)
//		})
		self.auth.getSession(self) { (session:AWSCognitoAuthUserSession?, error:Error?) in
			if(error != nil) {
				self.session = nil
				self.alertWithTitle("Error", message: (error! as NSError).userInfo["error"] as? String)
			}else {
				self.session = session
			}
			self.refresh()
		}
	}

	@IBAction func logout(_ sender: Any) {
		self.auth.signOut(self) { (error:Error?) in
			if(error != nil){
				self.alertWithTitle("Error", message: (error! as NSError).userInfo["error"] as? String)
			}else {
				self.session = nil
				self.alertWithTitle("Info", message: "Session completed successfully")
			}
			self.refresh()
		}
	}
	
	func getBestToken() -> AWSCognitoAuthUserSessionToken? {
		if(self.session != nil){
			if((self.session?.idToken) != nil){
				return self.session?.idToken!
			}else if((self.session?.accessToken) != nil){
				return self.session?.accessToken!
			}
		}
		return nil;
	}

	func refresh () {
		DispatchQueue.main.async {
			self.loginButton.isEnabled = self.session == nil
			self.logoutButton.isEnabled = self.session != nil
			self.title = self.session?.username;
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

