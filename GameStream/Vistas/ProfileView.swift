//
//  ProfileView.swift
//  GameStream
//
//  Created by Jhon Rueda on 24/08/22.
//

import SwiftUI

struct ProfileView: View {
    @State var userName = "Lorem Ipsum"
    @State var profileImage: UIImage = UIImage(named: "perfil")!
    
    var body: some View {
        ZStack {
            Color("fondo").ignoresSafeArea().navigationBarHidden(true).navigationBarBackButtonHidden(true)
            ScrollView{
                VStack {
                    Text("PERFIL")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title)
                        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .center)
                    
                    VStack{
                        Image(uiImage: profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                        
                        Text(userName)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                    }.padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    
                    Text("Ajustes")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title3)
                        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 18)
                    
                    settingsModule()
                    Spacer()
                }
            }
            
        }.onAppear(
            perform: {
                if returnUiImage(named: "fotoperfil") != nil {
                    profileImage = returnUiImage(named: "fotoperfil")!
                }
                let userData = SaveData()
                var userInfo = userData.getData()
                if(userInfo.count > 0){
                    userName = userInfo[2]
                }
            }
            
        )
    }
    
    func returnUiImage(named:String) -> UIImage?{
      
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
}
struct settingsModule:View{
    @State var isToggleOn = true
    @State var isEditProfileViewActive = false
    
    var body: some View{
        VStack(spacing:2){
            Button(action: {}, label: {
                HStack{
                    Text("Cuenta")
                        .foregroundColor(.white)
                    Spacer()
                    Text(">").foregroundColor(.white)
                }.padding()
            }).background(Color("blue-gray"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0))
            Button(action: {}, label: {
                HStack{
                    Text("Notificaciones")
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $isToggleOn)
                }.padding()
            }).background(Color("blue-gray"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0))
            Button(action: {
                isEditProfileViewActive = true
            }, label: {
                HStack{
                    Text("Editar Perfil")
                        .foregroundColor(.white)
                    Spacer()
                    Text(">").foregroundColor(.white)
                }.padding()
            }).background(Color("blue-gray"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0))
            
            Button(action: {}, label: {
                HStack{
                    Text("Califica esta aplicación")
                        .foregroundColor(.white)
                    Spacer()
                    Text(">").foregroundColor(.white)
                }.padding()
            }).background(Color("blue-gray"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0))
            
            NavigationLink(destination: EditProfileView(), isActive: $isEditProfileViewActive, label: {
                EmptyView()
            })
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
