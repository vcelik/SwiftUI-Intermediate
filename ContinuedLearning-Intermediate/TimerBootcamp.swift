//
//  TimerBootcamp.swift
//  ContinuedLearning-Intermediate
//
//  Created by Volkan Celik on 25/09/2023.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer=Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    @State var currentDate:Date=Date()

    
    //Current Time
    /*
    var dateFormatter:DateFormatter{
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }*/
    
    //Countdown
    /*@State var count:Int=10
    @State var finishedText:String?=nil*/
    
    //Countdown to date
    /*
    @State var timeRemaining:String=""
    let futureDate:Date=Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining(){
        let remaining=Calendar.current.dateComponents([.hour,.minute,.second], from: Date(), to: futureDate)
        let hour=remaining.hour ?? 0
        let minute=remaining.minute ?? 0
        let second=remaining.second ?? 0
        timeRemaining="\(hour):\(minute):\(second)"
    }
     */
    
    //Animation counter
    @State var count:Int=1
    
    
    
    var body: some View {
        ZStack{
            RadialGradient(
                gradient: Gradient(colors: [.purple,.blue]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .ignoresSafeArea()
            TabView(selection: $count, content: {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            })
            .frame(height:200)
            .tabViewStyle(PageTabViewStyle())
//            HStack(spacing:15){
//                Circle()
//                    .offset(y:count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y:count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y:count == 3 ? -20 : 0)
//            }
            .frame(width:200)
            .foregroundColor(.white)
//            Text(timeRemaining)
//                .font(.system(size: 100,weight: .semibold,design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
        }
        .onReceive(timer, perform: { _ in
            //updateTimeRemaining()
            withAnimation(.easeInOut(duration: 3.0)) {
                count=count == 5 ? 1 : count+1
            }
        })
    }
}

#Preview {
    TimerBootcamp()
}
