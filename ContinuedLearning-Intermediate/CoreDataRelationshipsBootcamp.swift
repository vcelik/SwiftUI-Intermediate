//
//  CoreDataRelationshipsBootcamp.swift
//  ContinuedLearning-Intermediate
//
//  Created by Volkan Celik on 23/09/2023.
//

import SwiftUI
import CoreData

class CoreDataManager{
    static let instance=CoreDataManager() //Singleton
    let container:NSPersistentContainer
    let context:NSManagedObjectContext
    
    init(){
        container=NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error=error{
                print("Error loading core data.\(error)")
            }
        }
        context=container.viewContext
    }
    
    func save(){
        do{
           try context.save()
            print("Saved successfully")
        }catch let error{
            print("Error saving.\(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipsViewModel:ObservableObject{
    
    let manager=CoreDataManager.instance
    
    @Published var businesses:[BusinessEntity]=[]
    @Published var departments:[DepartmentEntity]=[]
    @Published var employees:[EmployeeEntity]=[]


    
    init(){
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses(){
        let request=NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        let sort=NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors=[sort]
        
        //let filter=NSPredicate(format: "name == %@", "Apple")
        //request.predicate=filter
        
        do{
            businesses=try manager.context.fetch(request)
        }catch let error{
            print("Error fetching.\(error.localizedDescription)")
        }
    }
    
    func getDepartments(){
        let request=NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do{
            departments=try manager.context.fetch(request)
        }catch let error{
            print("Error fetching.\(error.localizedDescription)")
        }
    }
    
    func getEmployees(){
        let request=NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do{
            employees=try manager.context.fetch(request)
        }catch let error{
            print("Error fetching.\(error.localizedDescription)")
        }
    }
    
    func getEmployees(forBusiness business:BusinessEntity){
        let request=NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        let filter=NSPredicate(format: "business == %@", business)
        
        request.predicate=filter
        do{
            employees=try manager.context.fetch(request)
        }catch let error{
            print("Error fetching.\(error.localizedDescription)")
        }
    }
    
    func updateBusiness(){
        let existingBusiness=businesses[2]
        existingBusiness.addToDepartments(departments[1])
        save()
    }
    
    func addBusiness(){
        let newBusiness=BusinessEntity(context: manager.context)
        newBusiness.name="Facebook"
        //add existingDepartments to business
        //newBusiness.departments=[departments[0],departments[1]]
        
        //add existingEmployees to business
        //newBusiness.employees=[employees[1]]
        
        //add newBusiness to existingDepartment
        
        //add newBusiness to existingEmployee


        save()
    }
    
    func addDepartment(){
        let newDepartment=DepartmentEntity(context: manager.context)
        newDepartment.name="Finance"
        newDepartment.businesses=[businesses[0],businesses[1],businesses[2]]
        newDepartment.addToEmployees(employees[1])
        //newDepartment.employees=[employees[1]]
        //newDepartment.addToEmployees(employees[1])
        save()
    }
    
    func addEmployee(){
        let newEmployee=EmployeeEntity(context: manager.context)
        newEmployee.name="John"
        newEmployee.age=21
        newEmployee.dateJoined=Date()
        newEmployee.business=businesses[2]
        newEmployee.department=departments[1]
        save()
    }
    
    func deleteDepartment(){
        manager.context.delete(departments[2])
        save()
    }
    
    func save(){
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
    
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm=CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing:20){
                    Button {
                        vm.getEmployees(forBusiness: vm.businesses[0])
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                    }
                    
                    ScrollView(.horizontal,showsIndicators: true){
                        HStack(alignment:.top){
                            ForEach(vm.businesses){business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal,showsIndicators: true){
                        HStack(alignment:.top){
                            ForEach(vm.departments){department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal,showsIndicators: true){
                        HStack(alignment:.top){
                            ForEach(vm.employees){employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }

                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}

struct BusinessView:View{
    
    let entity:BusinessEntity
    
    var body: some View{
        VStack(alignment:.leading,spacing:20){
            Text("Name: \(entity.name ?? "")")
                .bold()
            if let departments=entity.departments?.allObjects as? [DepartmentEntity]{
                Text("Departments:")
                    .bold()
                ForEach(departments){department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees=entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees:")
                    .bold()
                ForEach(employees){employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth:300,alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView:View{
    
    let entity:DepartmentEntity
    
    var body: some View{
        VStack(alignment:.leading,spacing:20){
            Text("Name: \(entity.name ?? "")")
                .bold()
            if let businesses=entity.businesses?.allObjects as? [BusinessEntity]{
                Text("Businesses:")
                    .bold()
                ForEach(businesses){business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees=entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees:")
                    .bold()
                ForEach(employees){employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth:300,alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView:View{
    
    let entity:EmployeeEntity
    
    var body: some View{
        VStack(alignment:.leading,spacing:20){
            Text("Name: \(entity.name ?? "")")
                .bold()
            Text("Age: \(entity.age)")
            Text("Date joined: \(entity.dateJoined ?? Date())")
            Text("Business:")
                .bold()
            
            Text(entity.business?.name ?? "")
            
            Text("Department:")
                .bold()
            
            Text(entity.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth:300,alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
