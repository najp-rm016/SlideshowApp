import SwiftUI

struct SecondView: View {
    let bgColor = Color.init(red: 0.92, green: 0.93, blue: 0.94)
    let grayColor = Color.init(white: 0.8, opacity: 1)
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var image: String
//    @Binding var Binding_playbackFlag: Bool
    
    var body: some View {
        VStack{
            Text("拡大後")
                .font(.system(size: 50, weight: .semibold, design: .rounded))
            Image(image)
                .resizable()
                .frame(width: 300, height: 300)
                .padding(.bottom, 30)
            Button(action: {
                dismiss()
//                Binding_playbackFlag = false
            }){
                Text("元の画面に戻る")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(bgColor)
                        // 上側の凸をshadowで表現
                            .shadow(color: .white, radius: 10, x: -7, y: -7)
                        // 下側の凸をshadowで表現
                            .shadow(color: grayColor, radius: 10, x: 7, y: 7)
                    )
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    @State static var displayImage: String = ""
//    @State static var playbackFlag: Bool = false
    @State static var screenTransitionFlag: Bool = false
    
    static var previews: some View {
        SecondView(image: $displayImage)
    }
}
