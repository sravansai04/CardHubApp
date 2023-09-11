//
//  ContentView.swift
//  Exercise3_Nalla_Sravan
//
//  Created by Sravan Sai Rahul Nalla.
//

/*  References
 For Creating Viewss - https://www.hackingwithswift.com/quick-start/swiftui/how-to-present-a-new-view-using-sheets
 
 Color Extension - https://www.hackingwithswift.com/forums/100-days-of-swiftui/problems-extending-color/12064

 */

import SwiftUI

extension Color{
    static let customOrange = Color(red: 242.0 / 255.0, green: 103.0 / 255.0, blue: 28.0 / 255.0)
    
    static let customBrown = Color(red: 142.0 / 255.0, green: 66.0 / 255.0, blue: 53.0 / 255.0)
    
    static let customYellow = Color(red: 231/255, green: 193/255, blue: 76/255)
    
    static let customGrey = Color(red: 180.0 / 255.0, green: 190.0 / 255.0, blue: 200.0 / 255.0)
}

struct CustomButtonStyle: ButtonStyle {
    var color: Color
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.title2)
            .bold()
            .buttonStyle(.borderedProminent)
            .frame(width: 330.0, height: 55.0, alignment: .center)
            .buttonBorderShape(.roundedRectangle(radius: 1))
            .tint(color)
            .background(color)
    }
}


struct ContentView: View {
    @State private var showingOptions = false
    @State private var topicIdx: Int = 0
    @State private var isBulletSheetPresented: Bool = false
    @State private var isCardNameEditSheetPresented: Bool = false
    
    
    let icons: [UIImage] = [#imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "1")]
    
    @State var topics = ["UIAlertController", "UIKit", "View Controller"]
    
    @State var vc = [["configure alerts and action sheets", "intended to be used as-is", "does not support subclassing", "inherits from UIViewController", "New Bullet point should not be empty"],
                     
                     ["provides required iOS infrastructure", "window and view architecture", "event handling for multi-touch and etc", "manages interaction with system", "a lot of features incl. resource mgmnt"],
                     
                     ["defines the behavior for common VCs", "updates the content of the view", "responding to user interactions", "resizing views and layout mgmnt", "coordinating with other objects"]]
    
    var body: some View {
        VStack {
            Text("CardHub")
                .font(.title)
                .bold()
                .foregroundColor(.customOrange)
                .padding(.top,30)
            
            
            Image( uiImage: icons[topicIdx])
                .resizable()
                .frame(width: 74.0, height: 74.0) //68
            
            CardView(title: topics[topicIdx], contents: vc[topicIdx])
            
                .padding(.bottom,55)
            
            
            //            Button(action: nextCard) {
            //                Text("Next card")
            //            }.buttonStyle(CustomButtonStyle(color: .customOrange))
            //
            Button(action: nextCard) {
                HStack {
                    Spacer()
                    Text("Next card")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
            }.buttonStyle(CustomButtonStyle(color: .customOrange))
            
            Button(action: cardSelector) {
                HStack {
                    Spacer()
                    Text("Card selector")
                    Spacer()
                }
            }
            .buttonStyle(CustomButtonStyle(color: .customBrown))
            
            .confirmationDialog("Pick a topic",
                                isPresented: $showingOptions,
                                titleVisibility: .visible) {
                
                ForEach(topics, id: \.self) { topic in
                    Button(topic) {
                        topicIdx = topics.firstIndex(of: topic)!
                    }
                }
            }
            Button(action: nextBullet) {
                HStack {
                    Spacer()
                    Text("Add bullet")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .sheet(isPresented: $isBulletSheetPresented) {
                    BulletInputView(isPresented: $isBulletSheetPresented, onSave: { newBullet in
                        addBullet(newBullet)
                    }, title: topics[topicIdx],header: "ADD BULLET",inputPlaceholder: "Bullet Point")
                    
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(width: 330.0, height: 55.0, alignment: .center)
            .buttonBorderShape(.roundedRectangle(radius: 1))
            .tint(.customYellow)
            .background(Color.customYellow)
            
            
            Button(action: editCardName) {
                HStack {
                    Spacer()
                    Text("Edit card name")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .sheet(isPresented: $isCardNameEditSheetPresented) {
                    BulletInputView(isPresented: $isCardNameEditSheetPresented, onSave: { newName in
                        if !newName.isEmpty {
                            topics[topicIdx] = newName
                        }
                    }, title: topics[topicIdx],header: "EDIT TOPIC",inputPlaceholder: "Card Name")
                }
                
            }
            .buttonStyle(.borderedProminent)
            .frame(width: 330.0, height: 55.0, alignment: .center)
            .buttonBorderShape(.roundedRectangle(radius: 1))
            .tint(.customYellow)
            .background(Color.customYellow)
            
            //            Spacer()
        }
        .padding()
    }
    func addBullet(_ bullet: String) {
        if !bullet.isEmpty {
            vc[topicIdx].append(bullet)
        }
    }
    func nextBullet(){
        isBulletSheetPresented = true
    }
    func editCardName() {
        isCardNameEditSheetPresented = true
    }
    
    func nextCard() {
        topicIdx = (topicIdx+1)%topics.count
    }
    
    func cardSelector() {
        showingOptions = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
