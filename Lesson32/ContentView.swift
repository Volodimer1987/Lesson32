//
//  ContentView.swift
//  Lesson32
//
//  Created by vladimir gennadievich on 26.02.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: self.show ? 20:0)
                .opacity(showCard ? 0.4:1)
                .offset( y: showCard ? -200:0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
                    //                        .speed(0.8)
                    //                        .repeatCount(5,autoreverses: false)
                )
            
            
            BackCardView()
                .frame(width: showCard ? 300:340, height: 220)
                .background(self.show ? Color(#colorLiteral(red: 1, green: 0.3842282991, blue: 0.3684385979, alpha: 1)):Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(y: self.show ? -400:-40)
                .offset(x: viewState.width, y: viewState.height)
                .offset( y: showCard ? -180:0)
                .scaleEffect(showCard ? 1:0.9)
                .rotationEffect(.degrees(self.show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(
                    .degrees(showCard ? 0:10),
                    axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration:0.5))
            
            
            BackCardView()
                .frame(width:340, height: 220)
                .background(self.show ? Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)):Color(#colorLiteral(red: 1, green: 0.3842282991, blue: 0.3684385979, alpha: 1)))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200:-20)
                .offset(x: viewState.width, y: viewState.height)
                .offset( y: showCard ? -140:0)

                .scaleEffect(showCard ? 1:0.95)
                .rotationEffect(.degrees(self.show ? 0:5))
                .rotationEffect(.degrees(showCard ? -5 : 0))

                .rotation3DEffect(
                    .degrees(showCard ? 0:5),
                    axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration:0.4))
            
            
            CardView()
                .frame(width:showCard ? 375:340,height:220)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30:20,style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset( y: showCard ? -100:0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3,
                                   dampingFraction: 0.6,
                                   blendDuration: 0))
                
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            
                            if showCard == true && viewState.height > 0 || viewState.height < 0   {
                                showCard.toggle()
                            }

                            
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded() { _ in
                            self.viewState = .zero
                            self.show = false
                        }
                )
            
            
            
            BottomCardView(show:$showCard)
                .offset(x: 0, y: showCard ? 360:1000)
                .offset( y: bottomState.height)
                .blur(radius: self.show ? 20:0)
                .animation(.timingCurve(0.2, 0.9, 0.2, 1,duration:0.8))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.bottomState = value.translation
                            
                                                        
                            if  self.showFull {
                                self.bottomState.height += -300
                            }
                            
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                        }
                        .onEnded { _ in
                            
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            
                            if (bottomState.height < -100 && !self.showFull) ||
                                (self.bottomState.height < 250 && self.show ) {
                                
                                self.bottomState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                            
                            
                        }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                VStack {
                    Text("Дизайн в SwiftUI")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Сертификат")
                        .foregroundColor(Color("Primary"))
                }
                
                Spacer()
                
                Image("Logo SwiftUI")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
            .padding(.horizontal,20)
            .padding(.top,20)
            
            Image("2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:300,height:110,alignment: .top)
        }
        
       
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Сертификаты")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Spacer()
        }
    }
}

struct  BottomCardView: View {
    @Binding var show:Bool
    
    var body: some View {
        VStack(spacing:20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            
            Text("Изучение особенностей разработки адаптивного дизайна в SwiftUI")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing:20) {
                RingView(color1: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), color2: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), width: 88, height: 88, percent: 78, show: $show)
                    .animation(Animation.easeInOut.delay(0.3))
                
                
                VStack(alignment: .leading, spacing: 8){
                    Text("Дизайн в SwiftUI")
                        .bold()
                    Text("39 из 50 уроков завершино")
                        .font(.footnote)
                        .foregroundColor(.gray)

                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                
            }
            Spacer()
        }
        .padding(.top,8)
        .padding(.horizontal,20)
        .frame(maxWidth:.infinity)
        .background(Color.init("Background 3"))
        .cornerRadius(30)
        .shadow(radius: 20)
        
    }
    
}
