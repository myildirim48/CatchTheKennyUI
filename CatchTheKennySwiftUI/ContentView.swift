//
//  ContentView.swift
//  CatchTheKennySwiftUI
//
//  Created by YILDIRIM on 13.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var score = 0
    @State var timeLeft = 10.0
    @State var chosenX = 200
    @State var chosenY = 250
    @State var showAlert = false
    
    //Position tuples
    let (x1,y1) = (200,560)
    let (x2,y2) = (70,560)
    let (x3,y3) = (250,560)
    let (x4,y4) = (200,100)
    let (x5,y5) = (70,120)
    let (x6,y6) = (330,180)
    let (x7,y7) = (200,200)
    let (x8,y8) = (70,350)
    let (x9,y9) = (250,560)
    
    var counterTimer : Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeLeft < 0.5 {
                self.showAlert = true
                
            }else{
                self.timeLeft -= 1
            }
            
        }
    }
    
    var timer : Timer {
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            
            let tupleArray = [(self.x1,self.y1),(self.x2,self.y2),(self.x3,self.y3),(self.x4,self.y4),(self.x5,self.y5),(self.x6,self.y6),(self.x7,self.y7),(self.x8,self.y8),(self.x9,self.y9)]
            
            var previousNumber : Int?
            
            func randomNumGen() -> Int {
                var randomNumber = Int(arc4random_uniform(UInt32(tupleArray.count - 1)))
               
                while previousNumber == randomNumber{
                    randomNumber = Int(arc4random_uniform(UInt32(tupleArray.count - 1)))
                }
                
                previousNumber = randomNumber
                
                return randomNumber
            }
            
            self.chosenX = tupleArray[randomNumGen()].0
            self.chosenY = tupleArray[randomNumGen()].1
        }
        
    }
    
    var body: some View {
        VStack{
            Spacer()
            Text("Catch The Kenny").font(.largeTitle)
            
            HStack{
                Text("Time Left :")
                    .font(.title)
                Text(String(timeLeft)).font(.title)
            }
            HStack{
                Text("Score :")
                    .font(.title)
                Text(String(score))
                    .font(.title)
            }
            
            Spacer()
            
            Image("kenny").resizable().frame(width: 100, height: 130)
                .position(x: CGFloat(self.chosenX), y: CGFloat(self.chosenY))
                .gesture(TapGesture(count: 1).onEnded({ (_) in
                    self.score += 1
                }))
                .onAppear {
                    _ = self.timer
                    _ = self.counterTimer
                }
           
        }.alert(isPresented: $showAlert) {
            return Alert(title: Text("Time Over"), message: Text("Want to play again ?"), primaryButton: Alert.Button.default(Text("OK"), action: {
                //OK button action
                self.score = 0
                self.timeLeft = 10.0
            }), secondaryButton: Alert.Button.cancel())
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
