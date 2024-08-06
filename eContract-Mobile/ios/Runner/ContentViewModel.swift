//
//  ContentViewModel.swift
//  Runner
//
//  Created by Dam Viet Tung on 07/12/2022.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
     
     @Published var dataResultCallBack:Data = Data()

     @Published var loginSuccess:Bool = false
     @Published var accessToken:String = ""
     @Published var messageError:String = ""
     
     init() {
    
     }

     func loginWithPassWord(userName: String, passWord:String) {

        login(completion: { LoginErrorModel, accessToken in
             
               self.accessToken = accessToken
             
               if(LoginErrorModel.status){
                    self.messageError = ""
                    self.loginSuccess = true
                    
               }
               else{
                    self.loginSuccess = false
                    //show dialog error
                    self.messageError = LoginErrorModel.messageError
               }
               
          }, userName:  userName, passWord: passWord)
          
       
    }
}

