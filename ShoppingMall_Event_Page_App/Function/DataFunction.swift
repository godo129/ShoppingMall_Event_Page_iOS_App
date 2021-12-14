//
//  DataFunction.swift
//  ShoppingMall_Event_Page_App
//
//  Created by hong on 2021/12/14.
//

import UIKit
import Alamofire
import SwiftyJSON

func getEventData(url: String) {
    
    AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { (response) in
        switch response.result {
            
        case .success(let value) :
            let eventJSON: JSON = JSON(value)
            
            updateEventData(json: eventJSON)
        
        case let .failure(error) :
            print(error)
        }
    }
    
}

func updateEventData(json: JSON) {
 

    if let lists = json["쇼핑몰 리스트"].array {
        var list: [String] = []
        
        for item in lists {
            list.append(item.stringValue)
        }
        ShoppingMallList = list
    }
    
    
    
    for ShoppingMall in ShoppingMallList {

        var item = eventDatum()

        item.name = ShoppingMall

        guard let urlList = json[ShoppingMall].dictionaryObject else {return}

        guard let imageList = urlList["image_url"].self else {return}
        
        guard let eventList = urlList["detail_url"].self else {return}
        
        item.imageURL = imageList
        item.eventURL = eventList
        
        ShoppingMallListData.append(item)
        
    }
    
    print(ShoppingMallListData)
    
    
}
