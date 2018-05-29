//
//  AlamoFireWrapper.swift
//  iOS Challenge
//
//  Created by Tarun Gupta on 5/12/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlamoFireWrapper: NSObject {
	
	class func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
		Alamofire.request(strURL,
						  method: .get,
						  parameters: nil,
						  encoding: URLEncoding.default,
						  headers: nil).responseJSON { (responseObject) -> Void in
							//			print(responseObject)
							if responseObject.result.isSuccess {
								let resJson = JSON(responseObject.result.value!)
								success(resJson)
							}
							if responseObject.result.isFailure {
								let error : Error = responseObject.result.error!
								failure(error)
							}
		}
	}
	
	class func requestPOSTURL(_ strURL : String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
		Alamofire.request(strURL,
						  method: .post,
						  parameters: nil,
						  encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
			if responseObject.result.isSuccess {
				let resJson = JSON(responseObject.result.value!)
				success(resJson)
			}
			if responseObject.result.isFailure {
				let error : Error = responseObject.result.error!
				failure(error)
			}
		}
	}
}
