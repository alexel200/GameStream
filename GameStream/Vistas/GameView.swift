//
//  GameView.swift
//  GameStream
//
//  Created by Jhon Rueda on 24/08/22.
//

import SwiftUI
import AVKit
import Kingfisher

struct GameView: View {
    var url: String
    var title: String
    var studio:String
    var rating: String
    var publicationYear: String
    var description:String
    var tags:[String]
    var imgsUrl:[String]
    
    
    var body: some View {
        ZStack{
            Color("fondo").ignoresSafeArea()
            VStack{
                videoModule(url:url).frame(height: 300)
                ScrollView{
                    //Informacion del video
                    videoInfoModule(title:title, studio: studio, rating: rating, publicationYear: publicationYear, description:description, tags: tags)
                        .padding()
                    galleryModule(imgsUrl:imgsUrl)
                }.frame(maxWidth:.infinity)
                
            }
        }
    }
}

struct videoModule:View{
    var url:String
    
    var body: some View{
        VideoPlayer(player: AVPlayer(url: URL(string: url)! ))
            .ignoresSafeArea()
        
    }
}

struct videoInfoModule:View{
    var title: String
    var studio:String
    var rating: String
    var publicationYear: String
    var description:String
    var tags:[String]
    
    var body: some View{
        VStack(alignment: .leading){
            Text("\(title)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding(.leading)
            
            HStack{
                Text("\(studio)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5.0)
                    .padding(.leading)
                Text("\(rating)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5.0)
                Text("\(publicationYear)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5.0)
                
            }
            
            Text("\(description)")
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.top, 5.0)
                .padding(.leading)
            
            HStack{
                ForEach(tags, id:\.self){
                    tag in
                    Text("#\(tag)")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.top, 3.0)
                        .padding(.leading)
                }
            }
            
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct galleryModule:View{
    var imgsUrl:[String]
    
    let gridShape = [
        GridItem(.flexible())
    ]
    
    var body: some View{
        VStack(alignment:.leading){
            Text("GALERÍA")
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)
            
            ScrollView(.horizontal){
                LazyHGrid(rows: gridShape, spacing: 8.0){
                    ForEach(imgsUrl, id: \.self ){
                        imgUrl in
                        KFImage(URL(string: imgUrl)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                
            }.frame(height:180.0)
            
        }.frame(maxWidth:.infinity, alignment:.leading)
    }
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(url: "localhost.com", title: "sonic", studio: "SONY", rating: "E+", publicationYear: "1991", description: "Esta es una informacion de prueba", tags: ["Plataformas", "Mascotas"], imgsUrl: ["https://static.wikia.nocookie.net/sonic/images/4/47/TheFrontiersSonic.png/revision/latest/scale-to-width-down/565?cb=20220725073416", "https://sonicthehedgehog.com/wp-content/uploads/2022/04/ORIGINS_1200x1200.jpg"])
    }
}
