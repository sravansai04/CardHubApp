

import SwiftUI
struct BulletInputView: View {
    @Binding var isPresented: Bool
    @State private var bulletText: String = ""
    
    // @State private var bulletText: String = "New Bullet"
    /*
     If we uncomment above line, the default string will be New Bullet and we can edit that.
     */
    @State private var showingEmptyBulletAlert = false
    var onSave: (String) -> Void
    var title: String
    var header: String
    var inputPlaceholder :String
    var body: some View {
        VStack {
            Text("\(header)")
                .font(.title)
                .bold()
                .foregroundColor(.customOrange)
                .padding(.bottom,23)
            VStack(spacing: .zero){
                Text("\(title)")
                    .bold()
                    .font(.title2)
                    .frame(width: 330, height: 45)
                    .foregroundColor(.white)
                    .background(Color.customOrange)
                TextField("Enter \(inputPlaceholder)", text: $bulletText)
                    .frame(width: 330.0)
                    .frame(height: 58.0)
                    .background(Color.customGrey)
                
            }
            
            Button(action: {
                if bulletText.isEmpty {
                    showingEmptyBulletAlert = true
                } else {
                    onSave(bulletText)
                    isPresented = false
                }
            }
            ) {
                Text("Save")
            }.alert(isPresented: $showingEmptyBulletAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("\(inputPlaceholder) cannot be empty."),
                    dismissButton: .default(Text("Okay"))
                )
            }
            .buttonStyle(CustomButtonStyle(color:.customBrown))
            
            Button(action: {
                isPresented = false
            }) {
                Text("Cancel")
            }
            .buttonStyle(CustomButtonStyle(color: .customYellow))
            .padding(.bottom, 300)
            
        }
        .padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
