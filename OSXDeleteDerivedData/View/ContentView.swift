//
//  ContentView.swift
//  OSXDeleteDerivedData
//
//  Created by Angelos Staboulis on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var helper = Helper()
    var body: some View {
        VStack {
            HStack{
                Text(helper.getHomeDirectory() + "/Library/Developer/XCode/DerivedData/").frame(width:600,alignment: .leading)
                VStack{
                    Button {
                        helper.findFiles(path: helper.getHomeDirectory() + "/Library/Developer/XCode/DerivedData/")
                    } label: {
                        Text("Show Contents of Directory Derived Data").frame(width:300,height:45,alignment: .leading)
                    }.frame(width:300,height:60,alignment: .leading)
                    Button {
                        helper.deleteFolder()
                       
                    } label: {
                        Text("Delete Contents of Directory Derived Data").frame(width:300,height:45,alignment: .leading)
                    }.frame(width:300,height:60,alignment: .leading)
                }
            }.frame(width:1200)
            List(helper.files,id:\.self){item in
                Text(item)
            }
        }
    }
   
}

#Preview {
    ContentView()
}
