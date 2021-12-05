//
//  SqlManager.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 19/11/2021.
//

import SQLite
import UIKit

class SqlManager {
    //MARK: - Signleton
    private static let sharedInstance = SqlManager()
    static func shared() ->SqlManager{
        return SqlManager.sharedInstance
    }
    //MARK: - variables
    var database: Connection!
    let usersTable = Table("Users")
    var allSearch = Table("allSearch")
    
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    let password = Expression<String>("password")
    let address = Expression<String>("address")
    let image = Expression<Data>("image")
    
    let searchName = Expression<String>("searchName")
    let type = Expression<String>("type")
    
    //MARK: - functions
    //database functions
    func setUpConnection(){
        do{
            let doc = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = doc.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        }catch{
            print(error)
        }
    }
    func createTable(){
        let createTable = self.usersTable.create{ table in
            table.column(self.id , primaryKey: true)
            table.column(self.name)
            table.column(self.email, unique: true)
            table.column(self.password)
            table.column(self.address)
            table.column(self.image)
            
        }
        do {
            try  database.run(createTable)
            print("The table is created")
        } catch  {
            print(error)
        }
    }
    func insertUser(name: String, email: String, address: String, password: String, imageView: UIImageView){
        if !name.isEmpty ,  !email.isEmpty  , !address.isEmpty , !password.isEmpty , let image = imageView.image , let photo = image.jpegData(compressionQuality: 1) {
            let insertUser = self.usersTable.insert(self.name <- name , self.email <- email ,self.address <- address , self.password <- password , self.image <- photo)
            do {
                try self.database.run(insertUser)
                print("The user is inserted")
            } catch  {
                print("kkk\(error)")
            }
        }
    }
    func getAllUsers(){
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users{
                print("userID:\(user[self.id]), Name:\(user[self.name]), Email:\(user[self.email]) , Address:\(user[self.address]) , password:\(user[self.password]) , image:\(user[self.image])")
            }
        } catch  {
            print("kkk\(error)")
        }
    }
    func getUserFromDB(emailUser: String)-> User?{
        do {
            let query = self.usersTable.filter( self.email == emailUser)
            let users = try self.database.prepare(query)
            for user in users{
                let user = User(name: user[name], email: user[email], password: user[password], address: user[address], image: user[image])
                return user
            }
        } catch  {
            print(error)
        }
        return nil
    }
    func loginAuth(email: String , password: String)-> Bool{
        do {
            let users = try database.prepare(usersTable)
            for user in users{
                if !email.isEmpty, email == user[self.email] ,
                   !password.isEmpty, password == user[self.password] {
                    return true
                }
            }
        }catch{
            print(error)
        }
        return false
    }
    //MARK: - For recentMedia
    
    func setUpConnectionforMediaCells(){
        do{
            let doc = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = doc.appendingPathComponent("search").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        }catch{
            print(error)
        }
    }
    func createTableForCell(){
        let createTable = self.allSearch.create { table in
            table.column(self.id , primaryKey: true)
            table.column(self.searchName)
            table.column(self.type)
        }
        do {
            try database.run(createTable)
            print("table of media search created")
        } catch  {
            print(error)
        }
    }
    func lastSearch(name: String , type: String){
        
        let insertMedia = self.allSearch.insert(self.searchName <- name , self.type <- type)
        do {
            try self.database.run(insertMedia)
            print("search inseted")
        } catch  {
            print("error of inserating media search \(error)")
        }
    }
    func getLastSearch()-> (name: String , type: String){
        var name: String = ""
        var type: String = ""
        do {
            let medias = try self.database.prepare(self.allSearch)
            for media in medias{
                name = media[self.searchName]
                type = media[self.type]
            }
        } catch  {
            print("error \(error)")
        }
        return (name , type)
    }
 
    
}

