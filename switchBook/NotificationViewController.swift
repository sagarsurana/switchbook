//
//  NotificationViewController.swift
//  switchBook
//
//  Created by Sarthak Turkhia on 12/10/18.
//  Copyright © 2018 AviralSharma. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseDatabase
//import Firebase


class NotificationViewController: UIViewController {
    
    @IBOutlet weak var NotificationTable: UITableView!
    
    
    var matchID: String = ""
    var allNotifications : [NotificationData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref = Database.database().reference()
        var groupIDs = ["Family", "Friends", "Club"]
        var memberIDs : [String] = []
        var memberID : String = ""
        let unixTimeStamp = TimeInterval(Date().timeIntervalSince1970)
        var currentDateTime = Date(timeIntervalSince1970: unixTimeStamp)
        print("Current date-time: \(currentDateTime)")
        sendNotification(Date: currentDateTime)
        
        
        
        // Get list of groupIds  for user and populate groupNames array
            // For Each group create a members array inside for loop
            // for group in groupIDs{
                // get members for group
                // memberIDs = from group Members
            //}
        
        // Get Datetime from the Server and update Datetime
        // Get MemberID and store it as MemberId
        
        
        
       
        
        //if unixTimeStamp >= dateTime from Firebase{
            // sendNotification
        // matchingAlgorithm(memberID: memberID, memberIDs: )
        
            // Update dateTime on Server with +30 days
        
            // var dateComponent = DateComponents()
            // dateComponent.days = 30
            // var convertedDateTIme = Date(timeIntervalSince1970: dateTime)
            // let futureDate = Calendar.current.date(byAdding: dateComponent, to: convertedDateTime)
            // let futureTimestamp = futureDate.timeIntervalSince1970
            // SET Date-time here
        
        
        //}
        //else{
            
        //}
    }
    
    func matchingAlgorithm(memberID: String, memberIDs: [String], groupName: String, currentDate: Date) -> NotificationData{
        var isMatched = false
        var notificationObj : NotificationData?
        while !isMatched {
            let number = Int.random(in: 0 ..< memberIDs.count)
            if(memberIDs[number] != memberID){
                //Check if the memberIDs boolean is not false{
                // Make memberID's boolean false
                matchID = memberIDs[number]
                isMatched = true
                
                // get member's Address and Name
                var address: String = ""
                var name: String = ""
                
                notificationObj = NotificationData(matchname: name, date: currentDate, groupName: groupName, address: address)
                
                //}
            }
        }
        
        return notificationObj!
    }
    
    
    // Sends notifications to prompt user to open the app
    func sendNotification(Date: Date){
        let content = UNMutableNotificationContent()
        content.title = "You have been matched!"
        content.body = "Open the app to see details of the recipient reader."
        content.sound = UNNotificationSound.default
        
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: Date)
        components.month = Calendar.current.component(.month, from: Date)
        components.day = Calendar.current.component((.day), from: Date)
        components.hour = Calendar.current.component(.hour, from: Date)
        components.minute = Calendar.current.component(.minute, from: Date) + 1
        
        
        let tigger = UNCalendarNotificationTrigger(dateMatching: components , repeats: true)
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: tigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}


//TODO Use NotificationData fields with current date to populate Table View


struct NotificationData {
    var matchName: String
    var date: Date
    var groupName: String
    var address: String
    
    init(matchname: String, date: Date, groupName: String, address: String) {
        self.matchName = matchname
        self.date = date
        self.groupName = groupName
        self.address = address
    }
}

/*
 Aviral's comment: firebase isnt working on my laptop
 
 place to store notification in the string format
 var notifications : [String] = []
 
Once you recieve the notification -------------------------------------------------
Step one : convert it into a string format
Notification current = //get the notification that was triggered.
String currentNotification = "Hello! You have been matched with" + current.matchName + " on " +
                              current.date + " from the group " + current.groupName + ". Please send
                              them a book of your choosing to the address " = current.address
 
 
 //Add this string to the database for populating the table in the future
 
 notifications.append(currentNotification)
 
 //insert the current notification you got to the existing table
 
 tableView.insertRows(at: [IndexPath(row: notifications.count - 1, section: 0)], with: .automatic)
 
 //NOW YOU HAVE TO POPULATE THE EXISTING TABLE WITH EXISTING NOTIFICATIONS
 //PREFERABLY COPY THIS CODE IN viewDidLoad
 
 var notifications : [String] =  call the database to get the previous notifications, we need  a place to store them
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return notifications.count
 }
 
 //as it creates the table rows , it adds the existing notifications to the table
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = UITableViewCell()
 cell.textLabel?.text = notifications[indexPath.row]
 cell.textLabel?.textColor = UIColor(red:0.90, green:0.37, blue:0.33, alpha:1.0)
 return cell
 }
 
 
*/

