//
//  ContentView.swift
//  Slots
//
//  Created by Abhishek Rawat on 08/03/20.
//  Copyright © 2020 Abhishek Rawat. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple", "cherry", "star"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var credits = 1000
    private var betAmount = 5
    
    var body: some View {
        ZStack {
            //Background
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            
            //Foreground
            VStack {
                //Title
                Spacer()
                HStack {
                    Image(systemName : "star.fill").foregroundColor(.yellow)
                    Text("SwiftUI Slots")
                        .bold()
                        .foregroundColor(.white)
                    Image(systemName : "star.fill").foregroundColor(.yellow)
                }.scaleEffect(2)
                
                Spacer()
                //Credits
                Text("Credits : " + String(credits))
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
                //Cards
                VStack {
                    HStack {
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[0]], background: $backgrounds[0])
                        CardView(symbol: $symbols[numbers[1]], background: $backgrounds[1])
                        CardView(symbol: $symbols[numbers[2]], background: $backgrounds[2])
                        
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[3]], background: $backgrounds[3])
                        CardView(symbol: $symbols[numbers[4]], background: $backgrounds[4])
                        CardView(symbol: $symbols[numbers[5]], background: $backgrounds[5])
                        
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[6]], background: $backgrounds[6])
                        CardView(symbol: $symbols[numbers[7]], background: $backgrounds[7])
                        CardView(symbol: $symbols[numbers[8]], background: $backgrounds[8])
                        
                        Spacer()
                    }
                }
                
                Spacer()
                //Button
                Button(action: {
                    self.processResults()
                }) {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .padding([.leading, .trailing], 30)
                        .background(Color.pink)
                    .cornerRadius(20)
                }
                Spacer()
            }
        }
    }
    
    func processResults(_ isMax: Bool=false) {
        
        self.backgrounds = self.backgrounds.map({_ in
            Color.white
        })
        
        if isMax {
            self.numbers = self.numbers.map({_ in
                Int.random(in: 0...self.symbols.count - 1)
            })
        } else {
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
        }
        
        processWin(isMax)
        
    }
    
    func processWin(_ isMax: Bool=false) {
        
        var matches = 0
        
        if isMax {
            //Top Row
            if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2] {

                matches += 1
                self.backgrounds[0] = Color.green
                self.backgrounds[1] = Color.green
                self.backgrounds[2] = Color.green
            }
            
            //Middle Row
            if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5] {

                matches += 1
                self.backgrounds[3] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[5] = Color.green
            }
            
            //Bottom Row
            if self.numbers[6] == self.numbers[7] && self.numbers[7] == self.numbers[8] {

                matches += 1
                self.backgrounds[6] = Color.green
                self.backgrounds[7] = Color.green
                self.backgrounds[8] = Color.green
            }
            
            //Diagonal1
            if self.numbers[0] == self.numbers[4] && self.numbers[4] == self.numbers[8] {

                matches += 1
                self.backgrounds[0] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[8] = Color.green
            }
            
            //Diagonal2
            if self.numbers[2] == self.numbers[4] && self.numbers[4] == self.numbers[6] {

                matches += 1
                self.backgrounds[2] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[6] = Color.green
            }
            
        } else {
            if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5] {

                matches += 1
                self.backgrounds[3] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[5] = Color.green
            }
        }
        
        if matches > 0 {
            self.credits += self.betAmount * 2 * matches
        } else if !isMax {
            self.credits -= self.betAmount
        } else {
            self.credits -= self.betAmount * 5
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
