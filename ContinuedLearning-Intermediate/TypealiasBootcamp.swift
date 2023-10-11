//
//  TypealiasBootcamp.swift
//  ContinuedLearning-Intermediate
//
//  Created by Volkan Celik on 24/09/2023.
//

import SwiftUI

struct MovieModel{
    let title:String
    let director:String
    let count:Int
}

//struct TVModel{
//    let title:String
//    let director:String
//    let count:Int
//}

typealias TVModel=MovieModel

struct TypealiasBootcamp: View {
    
    //@State var item:MovieModel=MovieModel(title: "Title", director: "Joe", count: 5)
    
    @State var item:TVModel=TVModel(title: "TV Title", director: "Emmily", count: 10)

    var body: some View {
        VStack{
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasBootcamp()
}
