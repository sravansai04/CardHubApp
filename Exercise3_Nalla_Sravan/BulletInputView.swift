

import SwiftUI
struct BulletInputView: View {
    @Binding var isPresented: Bool
    @State private var bulletText: String = ""
    @State private var showingEmptyBulletAlert = false
    @State private var isEditing: Bool = false
    
    var onSave: (String) -> Void
    var title: String
    var header: String
    var paddingValue : CGFloat
    var inputPlaceholder :String
    var initialBulletText: String
    init(isPresented: Binding<Bool>, initialBulletText: String, onSave: @escaping (String) -> Void, title: String, header: String, paddingValue: CGFloat, inputPlaceholder: String) {
        self._isPresented = isPresented
        self._bulletText = State(initialValue: initialBulletText)
        self.onSave = onSave
        self.title = title
        self.header = header
        self.paddingValue = paddingValue
        self.inputPlaceholder = inputPlaceholder
        self.initialBulletText = initialBulletText
        
    }
    //    init(){
    //        self._bulletText=State(initialValue: "Hello")
    //    }
    var body: some View {
        VStack {
            
            Text("\(header)")
                .font(.title)
                .bold()
                .foregroundColor(.customOrange)
                .padding(paddingValue)
            VStack(spacing: .zero){
                Text("\(title)")
                    .bold()
                    .font(.title2)
                    .frame(width: 330, height: 45)
                    .foregroundColor(.white)
                    .background(Color.customOrange)
                TextField("Enter \(inputPlaceholder)", text: $bulletText)
                    .onTapGesture {
                        if bulletText == initialBulletText {
                            bulletText = ""
                        }
                        isEditing = true
                    }
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
            Spacer()
            
        }
        //        .padding(.top, 40)
        //        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
