//
//  RotationGestureBootcamp.swift
//  ContinuedLearning-Intermediate
//
//  Created by Volkan Celik on 21/09/2023.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    
    @State var angle:Angle=Angle(degrees: 0)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(Color.blue.cornerRadius(10))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged{value in
                        angle = value
                    }
                    .onEnded{value in
                        withAnimation(.spring()) {
                            angle=Angle(degrees: 0)
                        }
                    }
            )
    }
}

#Preview {
    RotationGestureBootcamp()
}
