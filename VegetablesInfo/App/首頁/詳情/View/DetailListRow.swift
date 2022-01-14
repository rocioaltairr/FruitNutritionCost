//
//  DetailListRow.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/12.
//

import SwiftUI

struct DetailListRow: View {
    @State var dateString:String?
    @State var CostString:Float?
    @Binding var unitType: String
    var body: some View {
        if CostString != nil {
            HStack {
                Text(dateString ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                VStack {
                    if CostString!.isNaN == false {
                        if unitType == "平均批發價/公斤"{
                            Text(String(format: "%.1f", CostString ?? 0))
                            .font(.title2)
                            .fontWeight(.bold)
                        } else if unitType == "平均批發價/台斤"{
                            Text(String(format: "%.1f", (CostString ?? 0) * 1.66666667 ))
                            .font(.title2)
                            .fontWeight(.bold)
                        } else if unitType == "粗估零售價/公斤"{
                            Text(String(format: "%.1f", (CostString ?? 0) * 2.5))
                            .font(.title2)
                            .fontWeight(.bold)
                        } else if unitType == "粗估零售價/台斤"{
                            Text(String(format: "%.1f", (CostString ?? 0) * 1.66666667 * 2.5 ))
                            .font(.title2)
                            .fontWeight(.bold)
                        }
                        Text(unitType).font(.system(size: 11))
                    } else {
                        if unitType == "平均批發價/公斤"{
                            Text("無資料")
                            .font(.title2)
                            .fontWeight(.bold)
                        } else if unitType == "平均批發價/台斤"{
                            Text("無資料")
                            .font(.title2)
                            .fontWeight(.bold)
                        } else if unitType == "粗估零售價/公斤"{
                            Text("無資料")
                            .font(.title2)
                            .fontWeight(.bold)
                        } else if unitType == "粗估零售價/台斤"{
                            Text("無資料")
                            .font(.title2)
                            .fontWeight(.bold)
                        }
                        Text(unitType).font(.system(size: 11))
                    }

                    
                }
            }
        }
    }
}

struct DetailListRow_Previews: PreviewProvider {
    @State static var unitType: String = "平均批發價/公斤"
    static var previews: some View {
        DetailListRow(unitType: $unitType)
    }
}
