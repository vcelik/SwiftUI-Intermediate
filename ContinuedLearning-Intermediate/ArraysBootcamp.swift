//
//  ArraysBootcamp.swift
//  ContinuedLearning-Intermediate
//
//  Created by Volkan Celik on 22/09/2023.
//

import SwiftUI

struct UserModel:Identifiable{
    let id=UUID().uuidString
    let name:String?
    let point:Int
    let isVerified:Bool
    
}

class ArrayModificationViewModel:ObservableObject{
    
    @Published var dataArray:[UserModel]=[]
    @Published var filteredArray:[UserModel]=[]
    @Published var mappedArray:[String]=[]
    
    init(){
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray(){
        //sort
        /*
//        filteredArray=dataArray.sorted { user1, user2 in
//            return user1.point>user2.point
//        }
//        filteredArray=dataArray.sorted(by: {$0.point<$1.point})
         */
        
        //filter
        /*
//        filteredArray=dataArray.filter({ user in
//            return !user.isVerified
//            //return user.name.contains("i")
//        })
        filteredArray=dataArray.filter({$0.isVerified})
         */
        
        //map
        /*
//        mappedArray=dataArray.map({ user in
//            return user.name
//        })
        //mappedArray=dataArray.map({$0.name})
        
//        mappedArray=dataArray.compactMap({ user in
//            return user.name ?? "ERROR"
//        })
        mappedArray=dataArray.compactMap({$0.name})
         */
        
        mappedArray=dataArray
            .sorted(by: {$0.point>$1.point})
            .filter({$0.isVerified})
            .compactMap({$0.name})
    }
    
    func getUsers(){
        let user1=UserModel(name: "Nick", point: 5, isVerified: true)
        let user2=UserModel(name: "Chris", point: 0, isVerified: false)
        let user3=UserModel(name: nil, point: 20, isVerified: true)
        let user4=UserModel(name: "Emily", point: 50, isVerified: false)
        let user5=UserModel(name: "Samantha", point: 45, isVerified: true)
        let user6=UserModel(name: "Jason", point: 23, isVerified: false)
        let user7=UserModel(name: "Sarah", point: 76, isVerified: true)
        let user8=UserModel(name: nil, point: 45, isVerified: false)
        let user9=UserModel(name: "Steve", point: 1, isVerified: true)
        let user10=UserModel(name: "Amanda", point: 100, isVerified: false)
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])







    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm=ArrayModificationViewModel()
    
    var body: some View {
        ScrollView{
            VStack(spacing:10){
                ForEach(vm.mappedArray,id:\.self){name in
                    Text(name)
                        .font(.title)
                    
                }
//                ForEach(vm.filteredArray){user in
//                    VStack(alignment:.leading){
//                        Text(user.name)
//                            .font(.headline)
//                        HStack{
//                            Text("Points:\(user.point)")
//                            Spacer()
//                            if user.isVerified{
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    ArraysBootcamp()
}
