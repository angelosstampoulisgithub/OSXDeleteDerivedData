//
//  Helper.swift
//  OSXDeleteDerivedData
//
//  Created by Angelos Staboulis on 2/4/25.
//

import Foundation
class Helper:ObservableObject{
    @Published var files:[String] = []
    func deleteFolder(){
        do{
            for file in files{
                try FileManager.default.removeItem(atPath: file)
            }
            files.removeAll()
        }catch{
            print("something went wrong!!!!")
        }
    }
    func getHomeDirectory()->String{
        let homeDirectoryForCurrentUser = FileManager.default.homeDirectoryForCurrentUser
        return "/"+homeDirectoryForCurrentUser.pathComponents[1]+"/"+homeDirectoryForCurrentUser.pathComponents[2]
    }
    func findFiles(path:String){
               do{
                   let files =  try FileManager.default.contentsOfDirectory(atPath: path+"/")
                   var attributes:[FileAttributeKey:Any] = [:]
                   for file in files{
                        attributes =  try FileManager.default.attributesOfItem(atPath: path + "/" + file)
                       let getType = String(describing:attributes[.type] as! FileAttributeType)
                       if  getType.contains("NSFileTypeDirectory"){
                           self.files.append(path +  file)
                       }
                       
                   }
                   let newSortedFilesArray = self.files.sorted { value, newValue in
                       return value < newValue
                   }
                   self.files.removeAll()
                   self.files.append(contentsOf: newSortedFilesArray)
               }catch{
                   debugPrint("something went wrong!!!"+error.localizedDescription)
           }
       }
}
