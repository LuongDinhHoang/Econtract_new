//
//  Utils.swift
//  Runner
//
//  Created by Dam Viet Tung on 08/12/2022.
//

import Foundation
import SwiftUI

func convertDataResultCallBack(dataResultCallBack:Data) -> String{
     
     do{
          let jsonResult = try JSONSerialization.jsonObject(with: dataResultCallBack, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
          
          let decoder = JSONDecoder()
 
          do {
               let  dataDictionaryDataFont = jsonResult?["dataFront"]  as? NSDictionary ?? NSDictionary()
               var jsonDataFont: NSData = try JSONSerialization.data(withJSONObject: dataDictionaryDataFont, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
               let dataFontDictionary = try JSONSerialization.jsonObject(with: jsonDataFont as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
          
               var transactionId:String = dataFontDictionary?["transactionId"] as? String ?? ""
               return transactionId
            
          } catch {
              print(error.localizedDescription)
               return ""
          }

     }
     catch{
          print(error.localizedDescription)
          return ""
     }
     
}
func convertHexColor(indexColor:Int) -> UInt{
     
     switch(indexColor){
          case 1 : return 0xdee9f3
          case 2 : return 0xffffff
          case 3 : return 0xf1f1f1
          case 4 : return 0xfdc975
          case 5 : return 0x2565c1
          case 6 : return 0xf1f1f1
          default: return  0xdee9f3
     }
}
func convertHexColorText(indexColor:Int) -> UInt{
     
     switch(indexColor){
          case 1 : return 0x000000
          case 2 : return 0xffffff
          case 3 : return 0xf1f1f1
          case 4 : return 0xfdc975
          case 5 : return 0x2565c1
          case 6 : return 0xf1f1f1
          default: return  0x000000
     }
}

func convertIdToTitle(idDocument:Int) -> String{
     switch(idDocument){
          case 1 : return "Chứng minh thư nhân dân"
          case 2 : return "Căn cước công dân cũ"
          case 3 : return "Bằng lái xe"
          case 4 : return "Hộ chiếu"
          case 5 : return "Căn cước công dân gắn chíp"
          case 6 : return "Chứng minh thư quân đội"
          case 7 : return "Khác"
          default: return  "Khác"
     }
}


struct DataFont: Codable {
 
     var gender: String
     var id_card: String
     var nation: String

     var expiry: String
     var permanent_address: String
     var home_town: String
     var datetime_create: String
     var day_of_birth: String
     var transactionId: String
     var full_name: String
  
   
}


struct DataBack: Codable {
    var category: String
     var day_of_issue: String
     var place_of_issue: String
     var datetime_create: String
     var ethnic: String
     var religion: String
     var transactionId: String

}
     
     
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}


struct LoginErrorModel{
     
     var status: Bool
     var messageError: String

}
struct ResponseLoginMode:Decodable{
     
     var tokenId:String
     var tokenKey: String
     var accessToken: String
     var type: String
     var refreshToken:String
     
}

func login (completion: @escaping(LoginErrorModel, String) -> Void, userName:String, passWord:String) -> Void{
     loginWithPassWord(completion: { LoginErrorModel,accessToken  in
          completion(LoginErrorModel, accessToken)
     }, userName: userName, passWord: passWord)
      
}
///Api Login
func loginWithPassWord(completion: @escaping(LoginErrorModel, String) -> Void,userName:String, passWord:String) -> Void {
     
     let url = URL(string: "https://apiekyc.demozone.vn/auth/signin")!

     let jsonString = ["email" : "\(userName)", "password" : "\(passWord)"]
     
     guard let httpBody = try? JSONSerialization.data(withJSONObject: jsonString, options: []) else {
             return
         }

     var request = URLRequest(url: url)
     request.httpMethod = "POST"
     request.httpBody = httpBody
     request.setValue("application/json", forHTTPHeaderField: "Content-Type")

     let dataTask = URLSession.shared.dataTask(with: request){ (data, response, error) in
          
          if data == nil {
                return
             }
          let dataAsString = String(data: data!, encoding: .utf8)
          
          guard error == nil else {
                return
             }

           let decoder = JSONDecoder()
          print ("ApiProvider loginWithPassWord userName = \(userName) | pass = \(passWord)")
          print ("ApiProvider loginWithPassWord dataAsString = \(dataAsString!)")
          
          do {
                  
               let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary

               let status = jsonResult?["status"] as! String
               
               
               do {
                    if(status == "OK"){
                         let dataJson = jsonResult?["data"] as! [String: Any]
                         let jsonData = try? JSONSerialization.data(withJSONObject:dataJson)
                         let responseLoginMode = try decoder.decode(ResponseLoginMode.self, from: jsonData!) as ResponseLoginMode
                         let defaults = UserDefaults.standard
//                         defaults.set(responseLoginMode.tokenKey, forKey: AppConstants.tokenKey)
//                         defaults.set(responseLoginMode.tokenId, forKey: AppConstants.tokenId)
//                         defaults.set(responseLoginMode.accessToken, forKey: AppConstants.accessToken)
                         
                         completion(LoginErrorModel(status: true, messageError: ""), responseLoginMode.accessToken)
                    }
                    else{
                         let message = jsonResult?["message"] as! String
                         completion(LoginErrorModel(status: false, messageError: message), "")
                    }
               }
               catch {
                    completion(LoginErrorModel(status: false, messageError: "\(error)"), "")
               }
               
                } catch {
                     completion(LoginErrorModel(status: false, messageError: "\(error)"),"")
                     return
                }
       }
       dataTask.resume()
   }
