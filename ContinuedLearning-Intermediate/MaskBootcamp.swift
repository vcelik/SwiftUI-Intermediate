//
//  MaskBootcamp.swift
//  ContinuedLearning-Intermediate
//
//  Created by Volkan Celik on 22/09/2023.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating:Int=3
    
    var body: some View {
        ZStack{
            starsView
                .overlay(
                    overlayView
                        .mask(starsView)
                )
        }
    }
    
    private var overlayView:some View{
        GeometryReader {geo in
            ZStack(alignment:.leading) {
                Rectangle()
                    .fill(LinearGradient(colors: [.red,.blue], startPoint: .leading, endPoint: .trailing))
                    //.foregroundColor(.yellow)
                    .frame(width:CGFloat(rating) / 5 * geo.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView:some View{
        HStack{
            ForEach(1..<6){index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    //.foregroundColor(rating >= index ? Color.yellow : .gray)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating=index
                        }
                    }
            }
        }
    }
}

#Preview {
    MaskBootcamp()
}
