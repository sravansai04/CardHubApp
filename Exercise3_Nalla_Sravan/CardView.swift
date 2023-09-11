

import SwiftUI
struct CardView: View {
    var title: String
    var contents: [String]
    var body: some View{
        VStack(spacing: .zero){
            Text(" \(title)")
                .bold()
                .font(.title2)
                .frame(width: 330, height: 45) //48
                .foregroundColor(.white)
                .background(Color.customOrange)
            ScrollView{
                
                VStack(alignment: .leading) {
                    ForEach(contents, id: \.self) { content in
                        Text("☆ \(content)")
                            .padding(5)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.system(size: 18))
                        
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
                .frame(width: 330.0) //223
            }
            .frame(height: 230.0)
            .background(Color.customGrey)
            
        }
        
    }
}
