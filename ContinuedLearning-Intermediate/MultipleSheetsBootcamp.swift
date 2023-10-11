//
//  MultipleSheetsBootcamp.swift
//  ContinuedLearning-Intermediate
//
//  Created by Volkan Celik on 22/09/2023.
//

import SwiftUI

struct RandomModel:Identifiable{
    let id=UUID().uuidString
    let title:String
}

//1 - use a binding
//2 - use multiple .sheets
//3 - use $item

struct MultipleSheetsBootcamp: View {
    
//    @State var selectedModel:RandomModel=RandomModel(title: "STARTING TITLE")
    @State var selectedModel:RandomModel?=nil

//    @State var showSheet:Bool=false
//    @State var showSheet2:Bool=false

    var body: some View {
        
        ScrollView {
            VStack(spacing:20){
                ForEach(0..<50){index in
                    Button("Button \(index)") {
                        selectedModel=RandomModel(title: "\(index)")
                    }
                }

            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
        }
        }
//        VStack(spacing:20){
//            Button("Button 1") {
//                selectedModel=RandomModel(title: "ONE")
//            }
//
//            Button("Button 2") {
//                selectedModel=RandomModel(title: "TWO")
//            }
//        }
//        .sheet(item: $selectedModel) { model in
//            NextScreen(selectedModel: model)
//        }
//        .sheet(isPresented: $showSheet, content: {
//            NextScreen(selectedModel: selectedModel)
//        })
        
        
//        VStack(spacing:20){
//            Button("Button 1") {
//                //selectedModel=RandomModel(title: "ONE")
//                showSheet.toggle()
//            }
//            .sheet(isPresented: $showSheet, content: {
//                NextScreen(selectedModel: RandomModel(title: "ONE"))  //.sheet modifiers are in the same level in the view hiearchy
//            })
//            Button("Button 2") {
//                //selectedModel=RandomModel(title: "TWO")
//                showSheet2.toggle()
//            }
//            .sheet(isPresented: $showSheet2, content: {
//                NextScreen(selectedModel: RandomModel(title: "TWO"))
//            })
//        }
////        .sheet(isPresented: $showSheet, content: {
////            NextScreen(selectedModel: selectedModel)
////        })
    }
}

struct NextScreen:View{
    
    //@Binding var selectedModel:RandomModel
    let selectedModel:RandomModel
    
    var body: some View{
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsBootcamp()
}
