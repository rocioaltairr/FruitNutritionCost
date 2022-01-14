//
//  SearchView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/28.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    @Binding var shownSearch: Bool

        var body: some View {
        HStack {
            Text("關閉")
                .onTapGesture{
                    shownSearch = false
                    isSearching = false
                }
                .foregroundColor(Color.blue)
            TextField("search",text:$text)
                .padding(.leading, 34)
                .frame(height: 50)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Image(systemName:"magnifyingglass")
                        Spacer()
                        Image(systemName:"xmark.circle.fill")
                            .onTapGesture{
                                text = ""
                            }
                    }
                        .padding(.horizontal, 8)
                        .foregroundColor(.gray)
                )
            Text("搜尋")
                .onTapGesture{
                    isSearching = true
                }
                .foregroundColor(Color.blue)
        }
    }
}

