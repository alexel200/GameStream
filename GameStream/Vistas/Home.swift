//
//  Home.swift
//  GameStream
//
//  Created by Jhon Rueda on 23/08/22.
//

import SwiftUI
import AVKit

struct Home: View {
    @State var tabSeleccionado:Int = 2
    var body: some View {
        TabView(selection: $tabSeleccionado){
            ProfileView()
            .tabItem{
                Image(systemName: "person")
                Text("Perfil")
            }.tag(0)
            GamesView()
            .tabItem{
                Image(systemName: "gamecontroller")
                Text("Juegos")
            }.tag(1)
            
            PantallaHome().tabItem{
                Image(systemName: "house")
                Text("inicio")
            }.tag(2)
            
            FavoritesView()
            .tabItem{
                Image(systemName: "heart")
                Text("Favoritos")
                
            }.tag(3)
            
            
        }.accentColor(.white)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
    }
    init(){
        UITabBar.appearance().backgroundColor = UIColor(Color("tabbar"))
        UITabBar.appearance().barTintColor = UIColor(Color("tabbar"))
        UITabBar.appearance().isTranslucent = true
    }
}
struct PantallaHome:View{
    var body: some View{
        ZStack{
            Color("fondo").ignoresSafeArea()
            VStack{
                Image("appLogo").resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 250).padding(.horizontal, 11.0)
                
                
            
                ScrollView(showsIndicators: false){
                    SubModuloHome()
                }
            }.padding(.horizontal, 18)
                .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct SubModuloHome:View{
    
    @State var isPlayerActive = false
    @State var textoBusqueda:String = ""
    @State var isGameInfoEmpty = false
    
    @ObservedObject var findedGame = SearchGame()
    @State var isGameViewActive = false
    
    @State var url: String = ""
    @State var title: String = ""
    @State var studio:String=""
    @State var rating: String=""
    @State var publicationYear: String=""
    @State var description:String=""
    @State var tags:[String] = []
    @State var imgsUrl:[String]=[]
    
    var body: some View{
        VStack{
            HStack{
                Button(action:{
                    watchGame(name:textoBusqueda)
                    
                }, label: {
                    Image(systemName: "magnifyingglass").foregroundColor(textoBusqueda.isEmpty ? Color(.yellow) : Color("dark-cian"))
                }).alert(isPresented: $isGameInfoEmpty){
                    Alert(title: Text("Error"), message: Text("No se encontro el juego"), dismissButton: .default(Text("OK") ))
                }
                
                ZStack(alignment: .leading){
                    if textoBusqueda.isEmpty{
                        Text("Buscar un video").foregroundColor(Color( red: 174/255, green: 177/255, blue: 185/255, opacity: 1.0))
                    }
                    TextField("", text: $textoBusqueda).foregroundColor(.white).padding()
                }

            }.background(Color("blue-gray"))
             .clipShape(Capsule())
             .padding(.top)
            
            Text("LOS MÁS POPULARES")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0,  maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            ZStack{
                Button(action: {
                 watchGame(name: "The Witcher 3")
                }, label: {
                    VStack{
                        Image("thewitcher3")
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment:.center)
                        Text("The Witcher 3")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .background(Color("blue-gray"))
                    }
                    
                })
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
            }.frame(minWidth: 0,  maxWidth: .infinity, alignment: .center)
                .padding(.vertical)
            
            Text("CATEGORÍAS SUGERIDAS PARA TI")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0,  maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    Button(action: {}, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color("blue-gray"))
                                .frame(width: 160, height: 90)
                            
                            Image("FPS")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42 )
                        }
                    })
                    Button(action: {}, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color("blue-gray"))
                                .frame(width: 160, height: 90)
                            
                            Image("RPG")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42 )
                        }
                    })
                    Button(action: {}, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color("blue-gray"))
                                .frame(width: 160, height: 90)
                            
                            Image("OpenWorld")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42 )
                        }
                    })
                }
            }
            
            Text("RECOMENDADOS PARA TI")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0,  maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    Button(action: {
                        watchGame(name: "Abzu")
                    }, label: {
                        Image("Abzu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    })
                    
                    Button(action: {
                        watchGame(name: "Crash Bandicoot")
                    }, label: {
                        Image("Crash Bandicoot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    })
                    
                    Button(action: {
                        watchGame(name: "DEATH STRANDING")
                    }, label: {
                        Image("DEATH STRANDING")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    })
                }
            }
            
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
        NavigationLink(destination: GameView(url: url, title: title, studio: studio, rating: rating, publicationYear: publicationYear, description: description, tags: tags, imgsUrl: imgsUrl), isActive: $isGameViewActive, label: {
            EmptyView()
        })
    }
    
    func watchGame(name: String){
        findedGame.search(gameName: name)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            print("Cantidad E:\(findedGame.gameInfo.count)")
            if findedGame.gameInfo.count == 0{
                isGameInfoEmpty = true
            }else{
                url = findedGame.gameInfo[0].videosUrls.mobile
                title = findedGame.gameInfo[0].title
                studio = findedGame.gameInfo[0].studio
                rating = findedGame.gameInfo[0].contentRaiting
                publicationYear = findedGame.gameInfo[0].publicationYear
                description = findedGame.gameInfo[0].description
                tags = findedGame.gameInfo[0].tags
                imgsUrl = findedGame.gameInfo[0].galleryImages
                
                isGameViewActive = true
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
