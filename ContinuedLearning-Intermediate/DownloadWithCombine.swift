//
//  DownloadWithCombine.swift
//  ContinuedLearning-Intermediate
//
//  Created by Volkan Celik on 24/09/2023.
//

import SwiftUI
import Combine

struct PostModel:Identifiable,Codable{
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

class DownloadWithCombineViewModel:ObservableObject{
    
    @Published var posts:[PostModel]=[]
    var cancellables=Set<AnyCancellable>()
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        
        guard let url=URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        //Combine Discussion
        /*
        //1.sign up for monthly subscription for package to be delivered
        //2.the company would make the package behind the scene
        //3.receive the package at your front door
        //4.make sure the box isnt damaged
        //5.open and make sure that the item is correct
        //6.use the item!!!
        //7cancellable at any time
        
        //1.create the publisher
        //2.subscribe publisher on background thread
        //3.receive on main thread
        //4.tryMap ( check that data is good)
        //5.decode data into PostModels
        //6.sink (put the item into our app)
        //7.store (cancel subscription if needed)
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
//            .tryMap { (data,response)->Data in
//                guard
//                    let response=response as?HTTPURLResponse,
//                    response.statusCode >= 200 && response.statusCode < 300 else{
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            //.replaceError(with: [])
            .sink { (completion) in
                switch completion{
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("There was an error.\(error)")
                }
            } receiveValue: { [weak self] returnedPosts in
                self?.posts=returnedPosts
            }
            .store(in: &cancellables)

    }
    
    func handleOutput(output:URLSession.DataTaskPublisher.Output) throws ->Data{
        guard
            let response=output.response as?HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else{
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var vm=DownloadWithCombineViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts){post in
                VStack(alignment:.leading){
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                }

            }
        }
    }


#Preview {
    DownloadWithCombine()
}
