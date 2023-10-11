//
//  LocalNotificationBootcamp.swift
//  ContinuedLearning-Intermediate
//
//  Created by Volkan Celik on 22/09/2023.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager{
    static let instance=NotificationManager()
    
    func requestAuthorization(){
        let options:UNAuthorizationOptions=[.alert,.sound,.badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error=error{
                print("ERROR:\(error)")
            }else{
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification(){
        let content=UNMutableNotificationContent()
        content.title="This is my first notification!"
        content.subtitle="This was soooo easy"
        content.sound = .default
        content.badge=1
        
        //time
        let trigger1=UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        //calendar
        var dateComponents=DateComponents()
        dateComponents.hour=20
        dateComponents.minute=26
        dateComponents.weekday=6
        let trigger2=UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //location
        let coordinates=CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        let region=CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        
        region.notifyOnEntry=true
        region.notifyOnExit=true
        
        let trigger3=UNLocationNotificationTrigger(region:region,repeats: true)
        
        
        let request=UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger3)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()

    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing:40){
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule notification") {
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Cancel notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear(perform: {
            UIApplication.shared.applicationIconBadgeNumber=0
        })
    }
}

#Preview {
    LocalNotificationBootcamp()
}
