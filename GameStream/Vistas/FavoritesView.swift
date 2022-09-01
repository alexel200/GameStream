//
//  FavoritesView.swift
//  GameStream
//
//  Created by Jhon Rueda on 24/08/22.
//

import SwiftUI
import AVKit

struct FavoritesView: View {
    @ObservedObject var allGames = ViewModel()
    
    var body: some View{
        ZStack{
            Color("fondo")
                .ignoresSafeArea()
            
            VStack{
                Text("FAVORITOS")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 9.0)
                
                ScrollView{
                    
                    ForEach(allGames.gamesInfo, id: \.self ){
                        game in
                        VStack{
                            VideoPlayer(player: AVPlayer(url: URL(string:  game.videosUrls.mobile)!))
                                .frame(height: 300)
                            Text("\(game.title)")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color("blue-gray"))
                                .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                        
                        
                        
                        
                    }
                    
                }.padding(.bottom, 8.0)
                    
            }.padding(.horizontal, 6.0)
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
