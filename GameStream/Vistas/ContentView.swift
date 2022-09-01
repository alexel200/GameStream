//
//  ContentView.swift
//  GameStream
//
//  Created by Jhon Rueda on 21/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(red:19/255, green: 30/255, blue: 53/255, opacity: 1.0).ignoresSafeArea()
                VStack{
                    Section(header: Text("")) {
                                    Text("Test View")
                                }
                    Image("appLogo").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 250).padding(.bottom, 30)
                    inicioYRegistroView()
                }.padding()
            }.navigationBarHidden(true)
            
        }.navigationViewStyle(.stack)
    }
}

struct inicioYRegistroView: View{
    
    @State var iniciaSesion = true
    
    var body: some View{
        VStack{
            HStack {
                Spacer()
                Button("INICIO SESIÓN") {
                    iniciaSesion = true
                    print("INicio de sesion")
                }.foregroundColor(iniciaSesion ? .white : .gray)
                Spacer()
                Button("REGÍSTRATE") {
                    iniciaSesion = false
                    print("Registrate")
                }.foregroundColor(iniciaSesion ? .gray : .white)
                
                Spacer()
            }
            Spacer(minLength: 42)
            
            if(iniciaSesion == true){
                inicioSesionView()
            }else{
                registroView()
            }
        }
    }
}

struct inicioSesionView: View{
    @State var correo: String = ""
    @State var password: String = ""
    @State var isHomeActive: Bool = false
    
    
    var body: some View{
        
        ScrollView {
            VStack(alignment: .leading){
                Text("Correo Electrónico").foregroundColor( Color("dark-cian") )
                ZStack(alignment: .leading){
                    if correo.isEmpty{
                        Text(verbatim: "ejemplo@gmail.com")
                            .font(.caption).foregroundColor(.white)
                    }
                    TextField("", text: $correo)
                        .foregroundColor(.white)
                        .keyboardType(.emailAddress)
                }
                Divider().frame( height: 1).background(Color("dark-cian"))
                    .padding(.bottom)
                
                Text("Contraseña").foregroundColor( Color("dark-cian") )
                
                ZStack(alignment: .leading){
                    if password.isEmpty{
                        Text("Ingresar contraseña").font(.caption).foregroundColor(.white)
                    }
                    SecureField("", text: $password).foregroundColor(.white)
                }
                Divider().frame( height: 1).background(Color("dark-cian"))
                    .padding(.bottom)
                Text("Olvidates tu contraseña?").font(.footnote)
                    .frame(maxWidth:.infinity, alignment: .trailing).foregroundColor(Color("dark-cian"))
                    .padding(.bottom)
            }
            VStack{
                Button(action: {
                    isHomeActive = iniciarSesion(option: "iniciar", email: correo, password: password)

                }, label:{
                    Text("INICIAR SESIÓN").fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 6.0)
                            .stroke(Color("dark-cian"), lineWidth: 2.0)
                            .shadow(color: .white, radius: 6.0))
                })
                Text("Inicia sesión con redes sociales").foregroundColor(.white).padding()
                HStack{
                    Spacer()
                    Button(action: socialLogin) {
                        Text("Facebook")
                            .foregroundColor(.white)
                            .padding()
                        
                    }
                    .frame(maxWidth:.infinity)
                    .background(Color(.white)).opacity(0.5)
                    .padding(.leading, -10)
                    Spacer()
                    Button(action: socialLogin) {
                        Text("Twitter")
                        
                            .foregroundColor(.white)
                            .padding()
                        
                    }
                    .frame(maxWidth:.infinity)
                    .background(Color(.white)).opacity(0.5)
                    .padding(.trailing, -10)
                    Spacer()
                }
            }.padding(.horizontal, 30)
            
            NavigationLink(destination: Home(), isActive: $isHomeActive, label: {
                EmptyView()
            }).isDetailLink(false)
        }
        
        
    }
}

func socialLogin(){
    print("social")
}

func iniciarSesion(option: String, email:String?, password:String?)->Bool{
    
    let startSession = SaveData()
    var goHome = false
    
    if(email == nil && password == nil){
        return false
    }
    
    switch option{
        case "iniciar":
            if(startSession.validateInfo(email: email!, password: password!)){
                goHome = true
            }
        case "registro":
        goHome =  startSession.saveData(email: email!, password: password!, name: "User Default Name")
            
        default:
            print("Default")
    }
    return goHome
}

struct registroView: View{
    @State var correo:String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isHomeActive: Bool = false
    @State var isError = false
    var body: some View{
        ScrollView{
            VStack(alignment: .center){
                
                Text("Elije una foto de perfil")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Puedes cambiar o elegirla más adelante").font(.footnote)
                    .fontWeight(.light).foregroundColor(.gray).padding(.bottom)
                Button(action: tomarFoto) {
                    ZStack{
                        Image("perfil").resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                        Image(systemName: "camera").foregroundColor(.white)
                    }
                }.padding()
            }
            
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("Correo Electrónico*").foregroundColor( Color("dark-cian") )
                    ZStack(alignment: .leading){
                        if correo.isEmpty{
                            Text(verbatim:"ejemplo@gmail.com").font(.caption).foregroundColor(.white)
                        }
                        TextField("", text: $correo)
                            .foregroundColor(.white)
                            .keyboardType(.emailAddress)
                    }
                    Divider().frame( height: 1).background(Color("dark-cian"))
                        .padding(.bottom)
                    
                    Text("Contraseña").foregroundColor( Color("dark-cian") )
                    
                    ZStack(alignment: .leading){
                        if password.isEmpty{
                            Text("Ingresar contraseña").font(.caption).foregroundColor(.white)
                        }
                        SecureField("", text: $password).foregroundColor(.white)
                    }
                    Divider().frame( height: 1).background(Color("dark-cian"))
                        .padding(.bottom)
                    Text("Confirmar Contraseña*").foregroundColor( Color("dark-cian") )
                    
                    ZStack(alignment: .leading){
                        if password.isEmpty{
                            Text("Confirme su contraseña").font(.caption).foregroundColor(.white)
                        }
                        SecureField("", text: $confirmPassword).foregroundColor(.white)
                    }
                    Divider().frame( height: 1).background(Color("dark-cian"))
                        .padding(.bottom)
                }
            }
            VStack{
                Button(action:{
                    if(password == confirmPassword){
                        isHomeActive = iniciarSesion(option: "registro", email: correo, password: password)
                    }else{
                        isError = true
                        
                    }
                    
                }, label:{
                    Text("Registrate").fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 6.0)
                            .stroke(Color("dark-cian"), lineWidth: 2.0)
                            .shadow(color: .white, radius: 6.0))
                }).alert(isPresented: $isError){
                    Alert(title: Text("Error"), message: Text("Las contraseñas no coinciden"), dismissButton: .default(Text("OK")))
                }
                Text("Inicia sesión con redes sociales").foregroundColor(.white).padding()
                HStack{
                    Spacer()
                    Button(action: socialLogin) {
                        Text("Facebook")
                            .foregroundColor(.white)
                            .padding()
                        
                    }
                    .frame(maxWidth:.infinity)
                    .background(Color("blue-gray"))
                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    Spacer()
                    Button(action: socialLogin) {
                        Text("Twitter")
                        
                            .foregroundColor(.white)
                            .padding()
                        
                    }
                    .frame(maxWidth:.infinity)
                    .background(Color("blue-gray"))
                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    Spacer()
                }
            }.padding(.horizontal, 30)
        }
        
        NavigationLink(destination: Home(), isActive: $isHomeActive, label: {
            EmptyView()
        }).isDetailLink(false)
        
        
    }
}

func tomarFoto(){
    print("Tomar foto")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
