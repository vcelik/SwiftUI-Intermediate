//
//  GeometryReaderBootcamp.swift
//  ContinuedLearning-Intermediate
//
//  Created by Volkan Celik on 22/09/2023.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    
    func getPercentage(geo:GeometryProxy)->Double{
        let maxDistance=UIScreen.main.bounds.width / 2
        let currentX=geo.frame(in: .global).midX
        return 1-Double(currentX / maxDistance)
    }
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(0..<20){index in
                    GeometryReader {geo in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geo)*40),
                                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                            )
                    }
                    .frame(width:300,height:250)
                    .padding()
                }
            }
        }
//        GeometryReader {geo in
//            HStack(spacing:0){
//                Rectangle().fill(Color.red)
//                    //.frame(width:UIScreen.main.bounds.width*0.666)
//                    .frame(width:geo.size.width*0.6666)
//                Rectangle().fill(Color.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
    
    
}

#Preview {
    GeometryReaderBootcamp()
}
