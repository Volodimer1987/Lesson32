//
//  MenuView.swift
//  Lesson32
//
//  Created by vladimir gennadievich on 02.03.2021.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing:16){
                Text("Ian - обучение завершино на 24% ")
                    .font(.caption)
                
                Color.white
                    .frame(width: 38, height: 6)
                    .cornerRadius(3)
                    .frame(width: 130, height: 6,alignment: .leading)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .cornerRadius(3)
                    .padding()
                    .frame(width: 150, height: 24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                
                MenuRow(title: "Личный кабинет", icon: "gear")
                MenuRow(title: "Счет", icon: "creditcard")
                MenuRow(title: "Выход", icon: "person.crop.circle")
            }
            .frame(maxWidth:.infinity)
            .frame(height:300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9425953049, green: 0.9425953049, blue: 0.9425953049, alpha: 1)),Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]),
                                       startPoint: .top,
                                       endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30,style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0.0, y: 20)
            . padding(.horizontal,30)
            .overlay(Image("avatar")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .offset( y: -150)
                     
            )

        }
        .padding(.bottom,30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    
    var title:String
    var icon:String
    
    var body: some View {
        HStack(spacing:16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light, design: .default))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(width: 120,alignment: .leading)
            
        }
    }
}
