//
//  FeedView.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var authVM : AuthViewModel
    
    @State private var showNewTweetView = false
    @ObservedObject var feedViewModel : FeedViewModel
    
    @Namespace private var animation
    @State private var selectedFilter : LetitFilterViewModel = .all
    
    init(user : User) {
        self.feedViewModel = FeedViewModel(user: user)
    }
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottomTrailing) {
                VStack{
                    letitFilterBar
                    letitView
                }
                Button {
                    showNewTweetView.toggle()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 28, height: 28)
                        .padding()
                }
                .background(Color(hex: 0x8559DC))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .fullScreenCover(isPresented: $showNewTweetView) {
                    NewLetitView()
                }
            }
            .navigationTitle("LetitGo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement : .navigationBarLeading) {
                    Button {
                        authVM.signOut()
                    } label: {
                        Image(systemName: "arrow.left.square")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    private var letitFilterBar : some View {
        HStack {
            ForEach(LetitFilterViewModel.allCases, id : \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(hex: 0xDA5D81))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .padding(.top)
//        .overlay(Divider().offset(x: 0, y: 16))
    }
    
    private var letitView : some View  {
        ScrollView {
            LazyVStack {
                ForEach(feedViewModel.fetchFilteredLetits(for: self.selectedFilter)) { letit in
                    LetitRowView(letit: letit)
                }
            }
        }
    }
    
    //    private var exitButton: some View {
    //        Button {
    //            authVM.signOut()
    //        } label: {
    //            Image(systemName: "arrow.left.square")
    //                .resizable()
    //                .frame(width: 20, height: 20)
    //                .padding()
    //        }
    //            .foregroundColor(Color(.white))
    //    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
