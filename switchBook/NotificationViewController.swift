//
//  NotificationViewController.swift
//  switchBook
//
//  Created by Sarthak Turkhia on 12/10/18.
//

import UIKit
import UserNotifications
import FirebaseDatabase
import Firebase


class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotifications.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = Array(allNotifications.values)[indexPath.row]
        cell.textLabel?.textColor = UIColor(red:0.90, green:0.37, blue:0.33, alpha:1.0)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    var allNotifications : [String:String] = [:]
    var UserRef = Database.database().reference().child("users")
    var GroupRef = Database.database().reference().child("groups")
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        setUp()
    }
    
    func setUp() {
        self.allNotifications = [:]
        print("VIEW DID LOADT")
        let memberID : String = Auth.auth().currentUser?.email!.replacingOccurrences(of: ".", with: ",") ?? " "
        print("MEMBER ID \(memberID)")
        
        var groups: [String: String] = [:]
        
        
        UserRef.child(memberID).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value!)
            let value = snapshot.value as? [String:Any]
            if (value?["groups"] != nil) {
                groups = value?["groups"] as! [String: String]
                print("Group IDs: \(Array(groups.keys))")
                self.getData(groups: groups, memberID: memberID)
                if value?["notifications"] != nil {
                    self.allNotifications = value?["notifications"] as! [String:String]
                    print("no here")
                }
                self.tableView.reloadData()
            }
        }
        print("All Notifications: \(allNotifications)")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getData(groups: [String:String], memberID: String) {
        let unixTimeStamp = TimeInterval(Date().timeIntervalSince1970)
        let currentDateTime = Date(timeIntervalSince1970: unixTimeStamp)
        
        for group in Array(groups.keys){
            print(group)
            print("groupss^")
            // Dictionary [String: Boolean]
            var members : [String: Bool] = [:]
            var DateTimeStamp: TimeInterval = Date().timeIntervalSince1970
            let groupName = groups[group] as! String
            print("GroupName: \(groupName)")
            GroupRef
                .child(group)
                .observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? [String:Any]
                    print(value)
                    print("snapshot here")
                    DateTimeStamp = value?["date"] as! TimeInterval
                    members = value?["members"] as! [String: Bool]
                    var matchedMembers = value?["sendermatched"] as! [String:Bool]
                    print("MEMBERS: \(members)")
                    print("DateTimeStamp: \(DateTimeStamp)")
                    print("unixTimeStamp: \(unixTimeStamp)")
                    let gate = matchedMembers[memberID]
                    if (unixTimeStamp >= DateTimeStamp && !gate!) {
                        let membersNeeded = self.checkUpdates(members: members)
                        print("MEMBERS: \(membersNeeded)")
                        if (self.oneLeftToMatch(members: matchedMembers, currentUser: memberID)) {
                            var dateComponent = DateComponents()
                            dateComponent.day = 30
                            let convertedDateTIme = Date(timeIntervalSince1970: DateTimeStamp)
                            let futureDate = Calendar.current.date(byAdding: dateComponent, to: convertedDateTIme)
                            let futureTimestamp = futureDate!.timeIntervalSince1970
                            print("Future Timestamp: \(futureTimestamp)")
                            let ref = Database.database().reference().child("groups")
                            ref.child(group).updateChildValues(["date":futureTimestamp])
                            
                        }
                        print(membersNeeded.count)
                        if (membersNeeded.count > 1){
                            self.matchingAlgorithm(memberID: memberID, allMembers: membersNeeded, groupName: (groupName), currentDate: currentDateTime, groupID: group)
                        }
                        let ref = Database.database().reference().child("groups").child(group).child("sendermatched")
                        ref.updateChildValues([memberID:true])
                        
                    }
                    else{
                        self.sendNotification(date: Date(timeIntervalSince1970: DateTimeStamp))
                    }
                })
        }
    }
    
    
    func checkUpdates(members: [String:Bool]) -> [String:Bool]{
        var tempMembers = members
        for memberID in Array(tempMembers.keys) {
            if (!tempMembers[memberID]!){
                return members
            }
            else{
                tempMembers[memberID] = false
            }
        }
        return tempMembers
    }
    
    func oneLeftToMatch(members: [String:Bool], currentUser: String) -> Bool{
        for member in Array(members.keys) {
            if (!members[member]! && member != currentUser) {
                return false
            }
        }
        return true
    }
    
    func matchingAlgorithm(memberID: String, allMembers: [String: Bool], groupName: String, currentDate: Date, groupID: String) {
        var members : [String : Bool] = allMembers
        var isMatched = false
        var memberIDs : [String] = Array(members.keys)
        var returnString = "No matches"
        while !isMatched {
            let number = Int.random(in: 0 ..< memberIDs.count)
            print(number)
            let currentMemberID = memberIDs[number]
            print("Current Member ID: \(currentMemberID)")
            print("My member ID: \(memberID)")
            if(currentMemberID != memberID){
                if (members[currentMemberID]! == false){
                    // Make memberID's boolean true
                    members[currentMemberID] = true
                    GroupRef.child(groupID).updateChildValues(["members" : members])
                    print("MEMBERS : \(members)")
                    isMatched = true
                    UserRef.child(currentMemberID).observeSingleEvent(of: .value) { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        let address = value?["address"] as? String ?? ""
                        let name = value?["name"] as? String ?? ""
                        let zip = value?["zip"] as? String ?? ""
                        returnString = "You were matched with \(name) on \(currentDate.description) from group \(groupName). Send a book to his address at \(address), \(zip) within the next 30 days."
                        
                        self.sendNotification(date: currentDate)
                        
                            print(self.allNotifications)
                            self.allNotifications[currentDate.description] = returnString
                            self.UserRef.child(memberID).updateChildValues(["notifications":self.allNotifications])
                            self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func sendNotification(date: Date){
        let content = UNMutableNotificationContent()
        content.title = "You have been matched!"
        content.body = "Open the app to see details of the recipient."
        content.sound = UNNotificationSound.default
        
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: date)
        components.month = Calendar.current.component(.month, from: date)
        components.day = Calendar.current.component((.day), from: date)
        components.hour = Calendar.current.component(.hour, from: date)
        components.minute = Calendar.current.component(.minute, from: date) + 1
        
        
        let tigger = UNCalendarNotificationTrigger(dateMatching: components , repeats: true)
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: tigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
