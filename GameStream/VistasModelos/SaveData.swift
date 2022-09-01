//
//  SaveData.swift
//  GameStream
//
//  Created by Jhon Rueda on 25/08/22.
//

import Foundation


class SaveData{
    var name:String = ""
    var email: String = ""
    var password: String = ""
    
    func saveData(email:String, password:String, name:String) -> Bool{
        UserDefaults.standard.set([email, password, name], forKey: "userInfo")
        
        return true
    }
    
    func getData() -> [String] {
        let userInfo : [String] = UserDefaults.standard.stringArray(forKey: "userInfo")!
        
        return userInfo
    }
    
    func  validateInfo(email:String, password:String)->Bool{
        var savedEmail = ""
        var savedPassword = ""
       
        if UserDefaults.standard.object(forKey: "userInfo") != nil{
            savedEmail = UserDefaults.standard.stringArray(forKey: "userInfo")![0]
            savedPassword = UserDefaults.standard.stringArray(forKey: "userInfo")![1]
            
            if(email == savedEmail && password == savedPassword){
                return true
            }else{
                return false
            }
            
        }else{
            return false
        }
    }
    
}
