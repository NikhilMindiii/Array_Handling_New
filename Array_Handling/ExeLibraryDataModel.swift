//
//  ExeLibraryDataModel.swift
//  Array_Handling
//
//  Created by mspc-68 on 13/03/24.
//

import Foundation

class ExeLibraryDataModel:NSObject{
    
    var display_name = ""
    var exercise_category_id = ""
    var image = ""
   
    init(dict:[String:Any]) {
        
        if let display_name = dict["display_name"] as? String{
            self.display_name = display_name
        }
        if let exercise_category_id = dict["exercise_category_id"] as? String{
            self.exercise_category_id = exercise_category_id
        }
        if let exercise_category_id = dict["exercise_category_id"] as? Int{
            self.exercise_category_id = "\(exercise_category_id)"
        }
        if let image = dict["image"] as? String{
            self.image = image
        }
        
        
    }
}
