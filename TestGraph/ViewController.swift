//
//  ViewController.swift
//  TestGraph
//
//  Created by Rene Mojica on 2016-08-08.
//  Copyright © 2016 Rene Mojica. All rights reserved.
//

import UIKit
import Graph

class ViewController: UIViewController {

    
    var contactList : [NSMutableDictionary] = []
    
    let graph = Graph()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if getUserCount() == 0 {
        
            testCreateUser()
            
        } else {
        
        
        print("\nContact List = ", contactList)
        addNewPropertyForUser("Robert Ludlum", withKey: "Github", andValue: "https://github.com/adamdahan")
       
        print("\nContact List = ", contactList)
        getSpecificUser("Jane Doe")
       
        print("\nContact List = ", contactList)
        updateValueWithString("Jane Doe", forKey: "name", withValue: "Marie Kreutz")
        
        print("\nContact List = ", contactList)
        deleteUserWithName("Jason Bourne")
        
        print("\nContact List = ", contactList)
            
//        createUserWithName("Justin Trudeau",email:nil,phone:nil)
       
        }
    }
    
    // MARK: Create
    
    func testCreateUser() {
    
        let user: Entity = Entity(type: "User")
        user["name"] = "Jason Bourne"
        user["email"] = "jbourne@gmail.com"
        user["phone"] = "666-555-5555"
        user["Title"] = "Mobile Developer"
        user["Github"] = "https://github.com/CosmicMind/Algorithm"
        
        let user1: Entity = Entity(type: "User")
        user1["name"] = "Jane Doe"
        user1["email"] = "janedoe@gmail.com"
        user1["phone"] = "666-444-8888"
        user1["Title"] = "iOS Developer"
        user1["Github"] = "https://github.com/CosmicMind/Material"
        user1["LinkedIn"] = "https://www.linkedin.com/in/williamhgates"
        
        let user2: Entity = Entity(type: "User")
        user2["name"] = "David Webb"
        user2["email"] = "davidw@gmail.com"
        user2["phone"] = "444-111-1111"
        user2["Title"] = "Web Developer"
        user2["Github"] = "https://github.com/CosmicMind/Graph"
        
        let user3: Entity = Entity(type: "User")
        user3["name"] = "Robert Ludlum"
        user3["email"] = "ludlumr@gmail.com"
        user3["phone"] = "333-333-3333"
        user3["Title"] = "Front End Developer"
        
        save()
        
    }
 
    func createUserWithName(name:String, email:String?, phone:String?) {
    
        let user: Entity = Entity(type: "User")
        user["name"] = name
        user["email"] = email
        user["phone"] = phone
        
        save()
    
    }
    
    // MARK: Read
    
    func getUserCount() -> Int {
        
        let users = graph.searchForEntity(types: ["User"])
        
        print("\n*****************",#function, "*****************")
        print (users.count)
        
        return users.count

    }
    
    func printUsers() {
    
        let users = graph.searchForEntity(types: ["User"])
        
        for aUser in users {
            
            let dict = aUser.properties as NSDictionary
            let keys = dict.allKeys
            
            for key in keys {
                
                print(key, ": ", dict[key as! String])
                
            }
            
            print("\n")
            
        }
    
    }
    
    
    func getSpecificUser(aUser:String) {
        
        let user: Array<Entity> = graph.searchForEntity(properties: [(key: "name", value: aUser)])
        
        if !user.isEmpty {
        
        let thisUser = user.first
        
        print("\n*****************",#function, "*****************")
        print("\n",thisUser!.id)
        print ("\n", thisUser?.properties["name"])
        print ("\n", thisUser?.properties["email"])
            
        } else {
        
        print("User does not exist")
        
        }
    }
    

    // MARK: Update
    
    func addNewPropertyForUser(aUser:String, withKey:String, andValue:String) {
        
        print("\n*****************",#function, "*****************")
        
        let users: Array<Entity> = graph.searchForEntity(properties: [(key: "name", value: aUser)])
        
        if !users.isEmpty {
        
        let user = users.first!
        
        user[withKey] = andValue
        
        save()
            
        } else {
            
            print("User does not exist")
            
        }
    
    }
    
    func updateValueWithString(aUser: String, forKey:String, withValue:String) {
        
        print("\n*****************",#function, "*****************")
        
        let users: Array<Entity> = graph.searchForEntity(properties: [(key: "name", value: aUser)])
        
        if !users.isEmpty {
        
        let user = users.first!
        
        user[forKey] = withValue
        
        save()
            
        } else {
            
            print("User does not exist")
            
        }

    }
    
    func updatePhotoForUser(aUser:String, withData:NSData) {
    
        print("\n*****************",#function, "*****************")
        
        let users: Array<Entity> = graph.searchForEntity(properties: [(key: "name", value: aUser)])
        
        if !users.isEmpty {
            
            let user = users.first!
            
            user["photo"] = UIImage(data: withData)
            
            save()
            
        } else {
            
            print("User does not exist")
            
        }
    
    }
    
    
    func updateContactList() {
        
        contactList.removeAll()
        
        let users = graph.searchForEntity(types: ["User"])
        
        print("\n*****************",#function, "*****************")
        
        for user in users {
            
            let dict = user.properties as NSDictionary
            
            contactList.append(dict.mutableCopy() as! NSMutableDictionary)
            
        }
        
        print("\nContactList: ", contactList)
        
    }
    
    
    func save() {
        
        graph.async { (success: Bool, error: NSError?) in
            
            print("\n*****************",#function, "*****************")
            if success {
                
                print("Success: \(success)")
                
            } else {
                
                print("Error: \(error)")
                
            }
            
        }
        
        updateContactList()
        
    }
    
    
    // MARK: Delete
    
    
    func deleteUserWithName(userName:String) {
    
        print("\n*****************",#function, "*****************")
        
        let users: Array<Entity> = graph.searchForEntity(properties: [(key: "name", value: userName)])
        
        if !users.isEmpty {
        
        let user = users.first
        
        user?.delete()
        
        save()
            
        } else {
            
            print("User does not exist")
            
        }
        
    }
    
    func deletePropertyForUser(aUser:String, withKey:String) {
    
        print("\n*****************",#function, "*****************")
        
        let users: Array<Entity> = graph.searchForEntity(properties: [(key: "name", value: aUser)])
        
        if !users.isEmpty {
            
            let user = users.first!
            
            user[withKey] = nil
            
            save()
            
        } else {
            
            print("User does not exist")
            
        }
    
    }
    
}


