//
//  GamesView.swift
//  GameStream
//
//  Created by Jhon Rueda on 24/08/22.
//

import SwiftUI
import Kingfisher

struct GamesView: View {
    @ObservedObject var allGames = ViewModel()
    @State var gameViewIsActive: Bool = false
    @State var url: String = ""
    @State var title: String = ""
    @State var studio:String=""
    @State var rating: String=""
    @State var publicationYear: String=""
    @State var description:String=""
    @State var tags:[String] = []
    @State var imgsUrl:[String]=[]
    
    let gridShape = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack{
            Color("tabbar").ignoresSafeArea()
            VStack{
                Spacer()
                Text("Juegos")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                Spacer()
            ScrollView{
                LazyVGrid(columns: gridShape, spacing: 8.0){
                    ForEach(allGames.gamesInfo, id: \.self){
                        game in
                        
                        Button(action: {
                            url = game.videosUrls.mobile
                            title = game.title
                            studio = game.studio
                            rating = game.contentRaiting
                            publicationYear = game.publicationYear
                            description = game.description
                            tags = game.tags
                            imgsUrl = game.galleryImages
                            
                            gameViewIsActive = true
                        }, label: {
                            
                            KFImage(URL(string: game.galleryImages[0])!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 4.0))
                                .padding(.bottom, 12)
                        })
                        
                    }
                }
            }
                Spacer()
            }.padding(.horizontal, 6.0)
            
            NavigationLink(destination: GameView(url: url, title: title, studio: studio, rating: rating, publicationYear: publicationYear, description: description, tags: tags, imgsUrl: imgsUrl), isActive: $gameViewIsActive, label:{
                EmptyView()
            })
        }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear(
                perform: {
                    
                    
                    
                }
                
            )
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}
