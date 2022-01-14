//
//  Created by Robert Petras
//  SwiftUI Masterclass ♥ Better Apps. Less Code.
//  https://swiftuimasterclass.com
//

import SwiftUI

struct SettingView: View {
  // MARK: - PROPERTIES
  
  @State private var enableNotification: Bool = true
  @State private var backgroundRefresh: Bool = false
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      // MARK: - HEADER
      VStack(alignment: .center, spacing: 5) {
        Image("蘋果")
          .resizable()
          .scaledToFit()
          .padding(.top)
          .frame(width: 100, height: 100, alignment: .center)
          .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x: 0, y: 4)
        
        Text("Avocados".uppercased())
          .font(.system(.title, design: .serif))
          .fontWeight(.bold)
          .foregroundColor(Color("ColorGreenAdaptive"))
      }
      .padding()
      
      Form {
        // MARK: - SECTION #1
      //  Section(header: Text("General Settings")) {
//          Toggle(isOn: $enableNotification) {
//            Text("Enable notifiacation")
//          }
//
//          Toggle(isOn: $backgroundRefresh) {
//            Text("Background refresh")
//          }
        
        
        // MARK: - SECTION #2
        Section(header: Text("")) {
          if enableNotification {
            HStack {
              Text("產品").foregroundColor(Color.gray)
              Spacer()
              Text("水果")
            }
//            HStack {
//              Text("Compatibility").foregroundColor(Color.gray)
//              Spacer()
//              Text("iPhone & iPad")
//            }
            HStack {
              Text("開發人員").foregroundColor(Color.gray)
              Spacer()
              Text("白白")
            }
//            HStack {
//              Text("Designer").foregroundColor(Color.gray)
//              Spacer()
//              Text("Robert Petras")
//            }
            HStack {
              Text("聯絡方式").foregroundColor(Color.gray)
              Spacer()
              Text("downtotheapp@gmail.com")
            }
            HStack {
              Text("版號").foregroundColor(Color.gray)
              Spacer()
              Text("1.0.0")
            }
          }
//            else {
//            HStack {
//              Text("Personal message").foregroundColor(Color.gray)
//              Spacer()
//              Text("👍 Happy Coding!")
//            }
//          }
        }
     // }
    }
    
    //}
   // .frame(maxWidth: 640)
  //}
}
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
      SettingView()
  }
}
