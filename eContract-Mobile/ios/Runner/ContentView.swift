//
//  ContentView.swift
//  Runner
//
//  Created by Dam Viet Tung on 07/12/2022.
//

import SwiftUI
import BkavEkycSDK
import Combine

struct ContentView: View {
     var typeID: Int
     var accessToken: String
     var backgroundColor: UInt
     var textColor: UInt
     var sizeText: Int
     var sizeTitle: Int
     var dismissAction: ((_ dataResultCallBack:String) -> Void)
     
 
     @State var isActive : Bool = false
     @State var isActiveCapture : Bool = false
     @State var transactionIdCallBack:String = ""
     @State private var action: Int? = 0
     @State var isShowDialogLoadding = false
     @State var isShowDialogError = false
     @StateObject private var model = ContentViewModel()
     
     var body: some View {
          GeometryReader { geometry in
               if #available(iOS 14.0, *) {
                    NavigationView {
                          ZStack{
                                   ScrollView(showsIndicators: false){
                                       VStack{

                                           NavigationLink(destination: IdentityDocumentPage(accessToken: accessToken,
                                                                                            textColor: textColor,
                                                                                            backgroundColor: backgroundColor,
                                                                                            sizeText: sizeText,
                                                                                            sizeTitle: sizeTitle,
                                                                                            isLiveDetection: false,
                                                                                            rootIsActive: self.$isActive,
                                                                                            transactionIdCallBack: self.$transactionIdCallBack),
                                                                   
                                                                   isActive: self.$isActive) {
                                                       EmptyView()
                                                  }
                                       
                                            NavigationLink(destination:CaptureDocumentPage(accessToken: accessToken,
                                                                                           identitydocumentid: typeID,
                                                                                           rootIsActive: self.$isActiveCapture, transactionIdCallBack: $transactionIdCallBack),
                                                           isActive: self.$isActiveCapture) {
                                                 EmptyView()
                                            }
                        
                                             }
                                        }
                                        .background(Color(hex: backgroundColor))
                                        .edgesIgnoringSafeArea(.all)
                                        .onTapGesture {
                                             UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                                             to: nil, from: nil, for: nil)
                                        }
                                        .onAppear(){
                                             if(self.typeID < 8){
                                                  self.isActiveCapture = true
                                             }
                                             else{
                                                  self.isActive = true
                                             }
                                        }         
                                   }
    
                         .navigationBarHidden(true)
                    }
                    .accentColor(Color.blue)
                    .preferredColorScheme(.light)
                    .navigationViewStyle(StackNavigationViewStyle())
                    .onChange(of: transactionIdCallBack) { transactionIdCallBack in
                        if(transactionIdCallBack != ""){
                              self.dismissAction(transactionIdCallBack)
                         }
                    }
                    .onChange(of: isActive) { isActive in
                         if(isActive == false && transactionIdCallBack == ""){
                              self.dismissAction(transactionIdCallBack)
                         }
                       
                    }
                    .onChange(of: isActiveCapture) { isActive in
                         if(isActive == false && transactionIdCallBack == ""){
                              self.dismissAction(transactionIdCallBack)
                         }
                       
                    }
                    
                    /*.onReceive(self.model.$loginSuccess, perform: { loginSuccess in
                         if (loginSuccess == true) {
                              self.isShowDialogLoadding = false
                              self.isActive = true
                              model.loginSuccess = false
                             
                        }
                    })*/
                    .onReceive(self.model.$messageError, perform: { NewMessageError in
                         if (NewMessageError != "") {
                              ///Show dialog error
                              self.isShowDialogError = true

                        }
                    })
                    .customPopupView(isPresented: $isShowDialogError, popupView: { showPopupError(onClick: {
   
                         self.isShowDialogError = false
                         self.isShowDialogLoadding = false

                    }, message: model.messageError) })
               } else {
                      // ios 13
                    NavigationView {
                          ZStack{
                                   ScrollView(showsIndicators: false){
                                       VStack{

                                           NavigationLink(destination: IdentityDocumentPage(accessToken: accessToken, textColor: textColor, backgroundColor: backgroundColor,
                                                                                                   sizeText: sizeText, sizeTitle: sizeTitle, isLiveDetection: false, rootIsActive: self.$isActive, transactionIdCallBack: self.$transactionIdCallBack),
                                                                   
                                                                   isActive: self.$isActive) {
                                                       EmptyView()
                                                  }
                                            NavigationLink(destination: CaptureDocumentPage(accessToken: accessToken,
                                                                                            identitydocumentid: typeID,
                                                                                            rootIsActive: self.$isActive,
                                                                                            transactionIdCallBack: $transactionIdCallBack),
                                                           isActive: self.$isActiveCapture) {
                                                 EmptyView()
                                            }
                        
                                             }
                                        }
                                        .background(Color(hex: backgroundColor))
                                        .edgesIgnoringSafeArea(.all)
                                        .onTapGesture {
                                             UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                                             to: nil, from: nil, for: nil)
                                        }
                                        .onAppear(){
                                             if(self.typeID < 8){
                                                  self.isActiveCapture = true
                                             }
                                             else{
                                                  self.isActive = true
                                             }
                                        }
                                        /*.onAppear(){
                                             if(self.userName == "" || self.passWord == ""){
                                                  return
                                             }
                                             self.isShowDialogLoadding = true
                                             
                                             model.loginWithPassWord(userName: self.userName, passWord: self.passWord)
         
                                        }
                                        
                                        if isShowDialogLoadding {
                                             GeometryReader { geometry in

                                                  ZStack {
                                                       DialogLoadding()
                                                          }
                                                       .scaledToFill()
                                                       .frame(width: geometry.size.width, height: geometry.size.height)
                                                    
                                             }
                                             .background(Color(hex: backgroundColor))
                                             .edgesIgnoringSafeArea(.all)
                                        }*/
                                        
                                   }
    
                         .navigationBarHidden(true)
                    }
                    .accentColor(Color.blue)
                    .preferredColorScheme(.light)
                    .navigationViewStyle(StackNavigationViewStyle())
                    .onReceive(Just(transactionIdCallBack)) { transactionIdCallBack in
                                                
                         if(transactionIdCallBack != ""){
                              self.dismissAction(transactionIdCallBack)
                         }
                                          
                     }
                    .onReceive(Just(isActive)) { isActive in
                                                
                         if(isActive == false && transactionIdCallBack == ""){
                              self.dismissAction(transactionIdCallBack)
                         }
                                          
                     }
                    .onReceive(Just(isActiveCapture)) { isActive in
                                                
                         if(isActive == false && transactionIdCallBack == ""){
                              self.dismissAction(transactionIdCallBack)
                         }
                                          
                     }

                    /*.onReceive(self.model.$loginSuccess, perform: { loginSuccess in
                         if (loginSuccess == true) {
                              self.isShowDialogLoadding = false
                              self.isActive = true
                              model.loginSuccess = false
                             
                        }
                    })*/
                    .onReceive(self.model.$messageError, perform: { NewMessageError in
                         if (NewMessageError != "") {
                              ///Show dialog error
                              self.isShowDialogError = true

                        }
                    })
                    .customPopupView(isPresented: $isShowDialogError, popupView: { showPopupError(onClick: {
   
                         self.isShowDialogError = false
                         self.isShowDialogLoadding = false

                    }, message: model.messageError) })
                    
               }
              
          }
          
     }
     
    }

extension View {
    /// A backwards compatible wrapper for iOS 14 `onChange`
    @ViewBuilder func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value)
            }
        }
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

struct DialogLoadding: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                     if #available(iOS 14.0, *) {
                          ProgressView()
                               .frame(width: 120, height: 120, alignment: .center)
                               .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                             
                     } else {
                          ActivityIndicator(isAnimating: true) {
                               $0.color = .black
                              $0.hidesWhenStopped = false
                               
                          }
                               .frame(width: 120, height: 120, alignment: .center)
                               .scaleEffect(x: 2, y: 2, anchor: .center)
                     }

                }
            }
        }
    }
}

 struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    fileprivate var configuration = { (indicator: UIView) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}

extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView)->Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}

struct showPopupError:View{
     
     var onClick: () -> Void
     var message: String

     public init(onClick: @escaping () -> Void, message: String) {
          self.onClick = onClick
          self.message = message
     }

     var body: some View {
                RoundedRectangle(cornerRadius: 24.0)
                    .fill(Color.white)
                    .frame(width: 343.0, height: 200.0)
                    .overlay(

                         VStack{
                              Text("Có lỗi xảy ra")
                                   .font(.system(size: 17, weight: .bold, design: .default))
                                   .foregroundColor(Color(hex: 0xEC2222))
                                   .padding(.top,16)
                              
                              Text(message)
                                   .font(.system(size: 14, design: .default))
                                   .foregroundColor(Color(hex: 0x565656))
                                   .padding(.top,30)
                              ZStack(alignment: .center) {
                                   Color.clear
                                   Text("Đóng")
                                        .font(.system(size: 14, design: .default))
                                        .foregroundColor(.white)
                              }
                              .frame(width: 311, height: 40, alignment: .center)
                              .background(Color(hex: 0x1967B2))
                              .cornerRadius(20)
                              .overlay(
                                   RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white, lineWidth: 1)
                              )
                              .onTapGesture(perform: {
                                   onClick()
                              })
                              .padding(.top, 25)
                              
                              Spacer()
                         }
                        ,
                        alignment: .top
                    )

                    .transition(AnyTransition.scale)
          }
        
}

extension View {
    func customPopupView<PopupView>(isPresented: Binding<Bool>, popupView: @escaping () -> PopupView, backgroundColor: Color = .black.opacity(0.7), animation: Animation? = .default) -> some View where PopupView: View {
        return CustomPopupView(isPresented: isPresented, content: { self }, popupView: popupView, backgroundColor: backgroundColor, animation: animation)
    }
}
struct CustomPopupView<Content, PopupView>: View where Content: View, PopupView: View {
    
    @Binding var isPresented: Bool
    @ViewBuilder let content: () -> Content
    @ViewBuilder let popupView: () -> PopupView
    let backgroundColor: Color
    let animation: Animation?
    
    var body: some View {
        
         if #available(iOS 14.0, *) {
              content()
                   .animation(nil, value: isPresented)
                   .overlay(isPresented ? backgroundColor.ignoresSafeArea() : nil)
                   .overlay(isPresented ? popupView() : nil)
                   .animation(animation, value: isPresented)
         } else {
              content()
                   .animation(nil, value: isPresented)
                  // .overlay(isPresented ? backgroundColor.ignoresSafeArea() : nil)
                   .overlay(isPresented ? popupView() : nil)
                   .animation(animation, value: isPresented)
         }
        
    }
}
