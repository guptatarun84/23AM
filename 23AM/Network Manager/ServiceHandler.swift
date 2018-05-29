//
//  ServiceHandler.swift
//  iOS Challenge
//
//  Created by Tarun Gupta on 5/12/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import Foundation
import SwiftyJSON

/*!
* discussion This method is a request to fetch the address based on search string .
* @param address- Search String
* @returns completionHandler - success
* @exception completionHandler - error
*/
func getPhotos(completionHandler: @escaping (JSON?, Error?) -> ()) {
	let url : String = "https://kqlpe1bymk.execute-api.us-west-2.amazonaws.com/Prod/users/self/media/recent"
	AlamoFireWrapper.requestGETURL(url, success: {
		(jsonResponse) -> Void in
		completionHandler(jsonResponse, nil)
	}) {
		(error) -> Void in
		completionHandler(nil, error)
	}
}

func Logout(completionHandler: @escaping (JSON?, Error?) -> ()) {
	AlamoFireWrapper.requestPOSTURL(LOGOUT, success: {
		(jsonResponse) -> Void in
		completionHandler(jsonResponse, nil)
	}) {
		(error) -> Void in
		completionHandler(nil, error)
	}
}
