//
//  ContentView.swift
//  access
//
//  Created by 楊仁翰 on 2020/2/24.
//  Copyright © 2020 Renhen Yang. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var networkingManager: NetworkManaged = NetworkManaged()
    var body: some View {
        List(networkingManager.userList) {
            userRowView(user: $0)
        }
    }
}
struct ImageViewWidget:View
{
    @ObservedObject var imageLoader: ImageLoader
    init(url:String)
    {
        imageLoader = ImageLoader(imageURL: url)
    }
    var body:some View
    {
        Image(uiImage: UIImage(data: imageLoader.data) ?? UIImage()).resizable().frame(width: 40, height: 40).cornerRadius(20.0)
    }
}
struct userRowView:View
{
    var user:UserEntry
    var body:some View{
        VStack{
            HStack {
                ImageViewWidget(url: user.avatar_url)
                VStack(alignment: .leading, spacing: 1){
                    Text(user.login).foregroundColor(Color.gray)
                    if user.site_admin == true {
                        Text("Admin").foregroundColor(Color.gray).fixedSize().frame(width: 50, height: 30, alignment: .center).background(Color.init(.purple)).cornerRadius(25)
                    }else{
                        Text("User").foregroundColor(Color.gray).fixedSize().frame(width: 50, height: 30, alignment: .center).background(Color.init(.green)).cornerRadius(25)

                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
