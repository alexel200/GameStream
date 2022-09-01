//
//  EditProfileView.swift
//  GameStream
//
//  Created by Jhon Rueda on 24/08/22.
//

import SwiftUI

struct EditProfileView: View {
    @State var profileImage: Image? = Image("perfil")
    @State var isCameraActive: Bool = false
    var body: some View {
        ZStack{
            Color("fondo").ignoresSafeArea()
            
            ScrollView{
                VStack{
                    Button(action: {
                        isCameraActive = true
                    }, label: {
                        ZStack {
                            profileImage!
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 118, height: 118, alignment: .center)
                                .clipShape(Circle())
                                .sheet(isPresented: $isCameraActive, content: {
                                    SUImagePickerView(sourceType: .photoLibrary, image: $profileImage, isPresented: $isCameraActive)
                                })
                            
                            Image(systemName: "camera")
                                .foregroundColor(.white)
                        }
                    })
                }.padding(.bottom, 18)
                
                editModule()
                
            }
        }
    }
}

struct editModule:View{
    @State var email:String=""
    @State var password:String=""
    @State var name:String=""
    
    var body: some View{
        VStack(alignment:.leading){
            
            Text("Nombre")
                .foregroundColor(Color("dark-cian"))
            ZStack(alignment:.leading){
                if name.isEmpty{
                    Text("Nombre")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                TextField("", text: $name).foregroundColor(.white)
            }
            
            Divider()
                .frame( height: 1.0 )
                .background( Color("dark-cian") ).padding(.bottom)
            Text("Correo Electrónico")
                .foregroundColor(.white)
            ZStack(alignment:.leading){
                if email.isEmpty{
                    Text(verbatim: "ejemplo@correo.com")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                TextField("", text: $email).foregroundColor(.white)
            }
            
            Divider()
                .frame( height: 1.0 )
                .background( .white ).padding(.bottom)
            
            Text("Contraseña")
                .foregroundColor(.white)
            ZStack(alignment:.leading){
                if password.isEmpty{
                    Text(verbatim: "Ingrese su contraseña")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                SecureField("", text: $password)
                    .foregroundColor(.white)
            }
            
            Divider()
                .frame( height: 1.0 )
                .background(.white ).padding(.bottom)
            
            Button(action: {
                updateProfile()
            }, label: {
                Text("ACTUALIZAR DATOS")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth:.infinity, alignment: .center)
                    .padding(EdgeInsets(top:11, leading: 18, bottom: 11, trailing: 18 ))
                    .overlay(RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("dark-cian"), lineWidth: 3)
                    .shadow(color: .white, radius: 3))
                
            }).padding()
        }.padding(.horizontal, 42.0)
            .onAppear(perform: {
                let userData = SaveData()
                var userInfo = userData.getData()
                if(userInfo.count > 0){
                    email = userInfo[0]
                    name = userInfo[2]
                }
            })
    }
    
    func updateProfile(){
       let savedData = SaveData()
       let result = savedData.saveData(email: email, password: password, name: name)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
