//
//  ContentView.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showMenu = false
    @EnvironmentObject var vm : AuthViewModel
    
    var body: some View {
        Group {
            if vm.userSession != nil {
//                mainInterfaceView
                if let user = vm.currentUser {
                    FeedView(user: user)
                        .navigationBarHidden(showMenu)
                }
            } else {
                AuthView()
            }
            
        }
    }
}

extension ContentView {
    var mainInterfaceView : some View {
        NavigationStack {
            ZStack (alignment: .topLeading) {
                if let user = vm.currentUser {
                    FeedView(user: user)
                        .navigationBarHidden(showMenu)
                }
                
                if showMenu {
                    ZStack {
                        Color(.black)
                            .opacity(0.25)
                    }.onTapGesture {
                        withAnimation(.easeInOut) {
                            showMenu.toggle()
                        }
                    }
                    .ignoresSafeArea()
                }
                
                SideMenuView()
                    .frame(width: 300)
                    .background(showMenu ? Color.white : Color.clear)
                    .offset(x: showMenu ? 0 : -300, y : 0)
                
            }
            .navigationTitle("LetitGo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement : .navigationBarLeading) {
                    Button {
                        withAnimation(.easeInOut) {
                            showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "square")
                            .foregroundColor(.white)
                    }
                }
            }
            .onAppear() {
                showMenu = false
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
