//
//  ListingView.swift
//  CardCarousal
//
//  Created by Ramkrishna Sharma on 20/08/24.
//

import SwiftUI

struct ListingView: View {
    var body: some View {
        PlayerView()
    }
}

struct PlayerView: View {

    let categoryList = [PlayerCategory(id: "1",
                                       categoryName: "Points per game",
                                       playerList: [Player(id: "1", name: "First", icon: ""),
                                                    Player(id: "2", name: "Second", icon: ""),
                                                    Player(id: "3", name: "Third", icon: "")]),
                        PlayerCategory(id: "2",
                                       categoryName: "Rebounds per game",
                                       playerList: [Player(id: "1", name: "First", icon: ""),
                                                    Player(id: "2", name: "Second", icon: "")]),
                        PlayerCategory(id: "3",
                                       categoryName: "Assists per game",
                                       playerList: [Player(id: "1", name: "First", icon: ""),
                                                    Player(id: "2", name: "Second", icon: "")]),
                        PlayerCategory(id: "4",
                                       categoryName: "Field Goal %",
                                       playerList: [Player(id: "1", name: "First", icon: ""),
                                                    Player(id: "2", name: "Second", icon: "")])
    ]

    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
            
            HStack {
                SelectionView()
                SelectionView()
            }
            .padding(.leading, 15)
            
            Text("NBA 2023-24 REGULAR SEASON")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(categoryList.enumerated()), id: \.offset) { index, item in

                        if (index+1)%2 == 0 {
                            Image("topBrush")
                                .padding(.top, 20)
                        }

                        VStack(spacing: 0) {

                            Text("\(item.categoryName)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 20).bold())
                                .foregroundStyle((index+1)%2 == 0 ? .white : .black)
                                .padding([.top, .bottom], 15)
                                .padding(.leading, 20)
                                .background((index+1)%2 == 0 ? Color(red: 11/255, green: 14/255, blue: 38/255) : .clear)

                            RowView(playerList: item.playerList, 
                                    hasColor: (index+1)%2 == 0)

                        }
                        .padding(.bottom, (index+1)%2 == 0 ? 20 : 0)
                        .background((index+1)%2 == 0 ? Color(red: 11/255, green: 14/255, blue: 38/255) : .clear)

                        if (index+1)%2 == 0 {
                            Image("bottomBrush")
                        }
                    }
                }
            }
        }
    }
}

struct RowView: View {
    let playerList: [Player]
    let hasColor: Bool

    var body: some View {
        ForEach(playerList) { item in
            VStack {
                Image("profile")
                    .background(.yellow)
            }
//            .padding(.top, 10)
            .padding(.bottom, 10)
//            .background(hasColor ? Color(red: 11/255, green: 14/255, blue: 38/255) : .clear)
        }
    }
}

struct PlayerCategory: Identifiable {
    let id: String
    let categoryName: String
    let playerList: [Player]
}

struct Player: Identifiable {
    let id: String
    let name: String
    let icon: String
}

struct SectionRows: Identifiable {
    let id: String
    let name: String
}

struct SectionHeader: Identifiable {
    let id: String
    let name: String
    let topBrush: String?
}

struct SectionFooter: Identifiable {
    let id: String
    let bottomBrush: String?
}

struct TeamLeaderListView: View {
    let sectionRows: [SectionRows]
    let sectionHeader: [SectionHeader]
    let sectionFooter: [SectionFooter]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(sectionRows) { row in
                    Text("\(row.name)")
                }
            }
        }
    }
}

struct SelectionView: View {
    @State private var hasSelected: Bool = false

    var body: some View {
        Button {
            withAnimation {
                hasSelected.toggle()
            }
        } label: {
            HStack(spacing: 0) {
                
                if hasSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.white)
                        .padding(.leading, 10)
                }

                Text("Selected")
                    .frame(alignment: .center)
                    .foregroundStyle(.white)
                    .padding(10)
            }
        }
        .background(
            Rectangle()
                .fill(Color.clear)
                .background(.black)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                .border(.gray)
        )
    }
}

#Preview {
    ListingView()
}

#Preview {
    SelectionView()
}
