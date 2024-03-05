//.modifierを使ってコード量を削減

import SwiftUI

struct ContentView: View {
    //    表示したい画像をここに追加
    @State var arrayImage = ["landscape1", "landscape2", "landscape3", "landscape4", "landscape5"]
    
    @State var count = 0
    @State var timer :Timer!
    
    @State var playbackFlag = false
    @State var screenTransitionFlag = false
    @State var displayImage: String = ""
    
    var body: some View {
        Text("スライドショー")
            .font(.system(size: 50, weight: .semibold, design: .rounded))
        
        VStack{
            
            let imageCount = ((count % arrayImage.count) + arrayImage.count) % arrayImage.count
            
            Image(arrayImage[imageCount])
                .resizable()
                .frame(width: 200, height: 200)
        }
        .onTapGesture { location in
            if location.x >= 0,
               location.x <= 200,
               location.y >= 0,
               location.y <= 200
            {
                screenTransitionFlag.toggle()
                displayImage = arrayImage[((count % arrayImage.count) + arrayImage.count) % arrayImage.count]
            }
            //            print(location)
        }
        .padding(.bottom, 20)
        .sheet(isPresented: $screenTransitionFlag, onDismiss: {playbackFlag = false}) {
            SecondView(image: $displayImage)
        }
        
        HStack {
            VStack{
                    Button(action: {
                        if playbackFlag == false{
                            self.count += 1
                        }
                    }){
                        Text("進む")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .foregroundColor(.gray)
                            .padding()
                            .modifier(TapPossibility(playbackFlag: playbackFlag))
                    }
                    .modifier(TapDisable(playbackFlag: playbackFlag))
            }
            
            .padding(8)
            
            VStack{
                    Button(action: {
                        if playbackFlag == false{
                            self.count -= 1
                        }
                    }){
                        Text("戻る")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .foregroundColor(.gray)
                            .padding()
                            .modifier(TapPossibility(playbackFlag: playbackFlag))
                    }
                    .modifier(TapDisable(playbackFlag: playbackFlag))
            }
            
            .padding(8)
            
            Button(action: {
                self.playbackFlag.toggle()
                if self.timer == nil{
                    self.timer = Timer.scheduledTimer(
                        withTimeInterval: 2.0,
                        repeats: true
                    ) { _ in
                        if playbackFlag == true && screenTransitionFlag == false{
                            count += 1
                        }
                        //停止ボタン押した、画面遷移してる時
                        else{
                            self.timer.invalidate()
                            self.timer = nil
                        }
                    }
                }
            }){
                Text(playbackFlag ? "停止":"再生")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
                    .padding()
                    .modifier(TapPossibility(playbackFlag: false))
            }
        }
    }
}

struct TapPossibility: ViewModifier {
    let playbackFlag: Bool
    
    let bgColor = Color.init(red: 0.92, green: 0.93, blue: 0.94)
    let bgColor_invalid = Color.init(red: 0.7, green: 0.7, blue: 0.7)
    let grayColor = Color.init(white: 0.8, opacity: 1)
    
    func body(content: Content) -> some View {
        if playbackFlag {
            content
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(bgColor_invalid)
                )
        } else {
            content
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(bgColor)
                        .shadow(color: .white, radius: 10, x: -7, y: -7)
                        .shadow(color: grayColor, radius: 10, x: 7, y: 7)
                )
        }
    }
}

struct TapDisable: ViewModifier {
    let playbackFlag: Bool
    
    func body(content: Content) -> some View {
        if playbackFlag {
            content
                .disabled(true)
        } else {
            content
                .disabled(false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
