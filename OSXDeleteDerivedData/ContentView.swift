//
//  ContentView.swift
//  OSXDeleteDerivedData
//
//  Created by Angelos Staboulis on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var files:[String] = []
    var body: some View {
        VStack {
            HStack{
                Text(getHomeDirectory() + "/Library/Developer/XCode/DerivedData/").frame(width:600,alignment: .leading)
                VStack{
                    Button {
                        findFiles(path: getHomeDirectory() + "/Library/Developer/XCode/DerivedData/")
                    } label: {
                        Text("Show Contents of Directory Derived Data").frame(width:300,height:45,alignment: .leading)
                    }.frame(width:300,height:60,alignment: .leading)
                    Button {
                        do{
                            for file in files{
                                try FileManager.default.removeItem(atPath: file)
                            }
                            files.removeAll()
                        }catch{
                            print("something went wrong!!!!!")
                        }
                       
                    } label: {
                        Text("Delete Contents of Directory Derived Data").frame(width:300,height:45,alignment: .leading)
                    }.frame(width:300,height:60,alignment: .leading)
                }
            }.frame(width:1200)
            List(files,id:\.self){item in
                Text(item)
            }
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

#Preview {
    ContentView()
}
