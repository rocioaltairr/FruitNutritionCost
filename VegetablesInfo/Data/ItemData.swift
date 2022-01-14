//
//  ItemData.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/11.
//

import SwiftUI
// 熱量 // 碳水化合物  脂肪 蛋白質 礦物質
var ItemsList: [Item] = [
    Item(id: 1,image: "蘋果",description:"一日ㄧ蘋果",nutrition:["50 kcal","13.4 g","0.1 g","0.1 g","維生素A, B1, B2, B6, 菸鹼酸, 粗纖維, 膳食纖維, 粗纖維"," 磷, 鎂, 鈣, 鐵, 鋅, 鈉, 鉀"],gradientColors: [Color("ColorAppleLight"), Color("ColorAppleDark")]),
    
    Item(id: 2,image: "葡萄",description:"",nutrition:["50 kcal","17 g","0.4 g","0.6 g","維生素C, D, B6, B","鎂, 鈣, 鐵"],gradientColors: [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")]),
    
    Item(id: 3,image: "檸檬",description:"",nutrition:["28 kcal","9 g","0.3 g","1.1 g","維生素C, 維生素D, 維生素B6,維生素B","鎂, 鈣, 鐵"],gradientColors: [Color("ColorLemonLight"), Color("ColorLemonDark")]),
    
    Item(id: 4,image: "甜橙",description:"",nutrition:["46 kcal”,”11.4 g","0.1 g”,”0.8 g","維生素B, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorPomegranateLight"), Color("ColorPomegranateDark")]),
    
    Item(id: 5,image: "雜柑",description:"",nutrition:["53 kcal","13 g","0.3 g","0.8 g","維生素B, B6, C, D","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorLemonLight"), Color("ColorLemonDark")]),
    
    Item(id: 6,image: "火龍果",description:"",nutrition:["50 kcal","12.3 g","0.1 g","1.1 g","維生素B, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorAppleLight"), Color("ColorAppleDark")]),
    
    Item(id: 7,image: "百香果",description:"",nutrition:["97 kcal","23 g","0.7 g","2.2 g","維生素B, B6, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorLemonLight"), Color("ColorLemonDark")]),
    
    Item(id: 8,image: "酪梨",description:"",nutrition:["160 kcal","9 g","15 g","9 g","維生素B, B6, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorCherryLight"), Color("ColorCherryDark")]),
    
    Item(id: 9,image: "草莓",description:"",nutrition:["32 kcal","8 g","0.3 g","0.7 g","維生素B, B6, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorAppleLight"), Color("ColorAppleDark")]),
    
    Item(id: 10,image: "洋香瓜",description:"",nutrition:["239 kJ (57 kcal)","9.75 g","0.14 g","0.36 g","維生素B, B6, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorGooseberryLight"), Color("ColorGooseberryDark")]),
    
    Item(id: 11,image: "藍莓",description:"",nutrition:["239 kJ (57 kcal)","9.75 g","0.14 g","0.36 g","維生素B, B6, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")]),
    
    Item(id: 12,image: "百香果",description:"",nutrition:["239 kJ (57 kcal)","9.75 g","0.14 g","0.36 g","維生素B, B6, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorPearLight"), Color("ColorPearDark")]),
    
    Item(id: 13,image: "椰子",description:"",nutrition:["239 kJ (57 kcal)","9.75 g","0.14 g","0.36 g","維生素B, B6, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")]),
    
    Item(id: 14,image: "芒果",description:"",nutrition:["239 kJ (57 kcal)","9.75 g","0.14 g","0.36 g","維生素B, B6, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorMangoLight"), Color("ColorMangoDark")]),
    
    Item(id: 15,image: "奇異果",description:"",nutrition:["53 Kcal","12.8 g","1.6 g","0.3 g","維生素B, B6, C, D, E, 膳食纖維, 奇異酵素, 葉黃素","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorWatermelonLight"), Color("ColorWatermelonDark")]),
    
    Item(id: 16,image: "蓮霧",description:"",nutrition:["239 kJ (57 kcal)","9.75 g","0.14 g","0.36 g","維生素B, B6, C, D, E","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],gradientColors: [Color("ColorPomegranateLight"), Color("ColorPomegranateDark")]),
    
    Item(id: 17,image: "榴槤",description:"",nutrition:["136 kcal","31.6 g","1.6 g","2.6 g","維生素B, B6, C, D, E",""],gradientColors: [Color("ColorLemonLight"), Color("ColorLemonDark")]),
    Item(id: 18,image: "木瓜",description:"",nutrition:["38 kcal","9.9 g","0.1 g","0.6 g","維生素B, B6, C, D, E",""],gradientColors: [Color("ColorMangoLight"), Color("ColorMangoDark")]),
    Item(id: 19,image: "鳳梨",description:"",nutrition:["50 kcal","13.2 g","0.1 g","0.5 g","維生素B, B6, C, D, E",""],gradientColors: [Color("ColorPeanAppleLight"), Color("ColorPeanAppleDark")]),
    Item(id: 20,image: "香蕉",description:"香蕉含有維他命B2和檸檬酸，可產生協合作用，分解人體的疲勞因子。因含熱量較高，吃多易增加體重，但青蕉中含寡糖，較不易增加體重。香蕉含鉀量高，可抑制血壓上升，適合高血壓、心臟病人攝食，但腎功能代謝不良者，得遵醫囑食用；所含維他命B6有助髮黑及增強肝功能。香蕉皮內白層擦拭皮膚，具美白功能，但停留數分鐘後須清除以免感染及色素沉著反長斑痕。",nutrition:["91 kcal","23.5 g","0.2 g","1.3 g","A, B1, B2, B6, C, E, K","鐵, 鈣, 菸鹼酸, 鋅, 磷"],gradientColors: [Color("ColorMangoLight"), Color("ColorMangoDark")]),
    Item(id: 21,
         image: "小番茄",
         description:"",
         nutrition:["239 kJ (57 kcal)","9.75 g","0.14 g","0.36 g","B1, B2, B3, B5, B6, B9, C, E, K","鈉, 鉀, 鈣, 鎂, 鐵, 鋅, 磷"],
         gradientColors: [Color("ColorAppleLight"), Color("ColorAppleDark")])]


// 熱量 // 碳水化合物  脂肪 蛋白質 礦物質

//蘋果 葡萄 檸檬 甜橙 雜柑 火龍果 百香果
