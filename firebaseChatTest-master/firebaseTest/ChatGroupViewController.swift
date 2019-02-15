//
//  ChatGroupViewController.swift
//  firebaseTest
//
//  Created by wonwoolee on 2018. 10. 11..
//  Copyright © 2018년 wonwoolee. All rights reserved.
//

import UIKit

class ChatGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var groups: [Group] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchChatGroupList()
    }
    
    func fetchChatGroupList() {
        if let uid = FirebaseDataService.instance.currentUserUid {
            
            FirebaseDataService.instance.usersRef.child(uid).child("name").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? Dictionary<String, String> {
                    self.groups.removeAll()
                }
            })
            
            FirebaseDataService.instance.usersRef.child(uid).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? Dictionary<String, Int> {
                    self.groups.removeAll()
                    for (key, _) in dict {
                        FirebaseDataService.instance.groupRef.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                            if let data = snapshot.value as? Dictionary<String, AnyObject> {
                                let group = Group(key: key, data: data)
                                self.groups.append(group)
                                
                                DispatchQueue.main.async(execute: { 
                                    self.tableView.reloadData()
                                })
                            }
                        })
                    }
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "chatting", sender: groups[indexPath.row].key)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        cell.textLabel?.text = groups[indexPath.row].name
        return cell
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "userList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userList" {
            let userListVC = segue.destination as! UserListViewController
            let chatGroupVC = sender as! ChatGroupViewController
            userListVC.chatGroupVC = chatGroupVC
        } else if segue.identifier == "chatting" {
            let chatVC = segue.destination as! ChatViewController
            chatVC.groupKey = sender as? String
        }
    }
}
