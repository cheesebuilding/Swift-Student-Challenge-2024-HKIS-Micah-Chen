import SwiftUI

struct Page2: View {
    @State private var isButtonPressed = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("DragonBoatPage2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 350)
                        .padding()

                    Text("The Dragon Boat Festival is one of the largest events in Hong Kong.  It takes place on the fifth day of the fifth lunar month each year, near Victoria Harbour. The most standard race in Hong Kong is a sprint event usuaully being 500m. ")
                        .font(.custom("Apple SD Gothic Neo", size: 23))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .offset(y: -20)
                        .offset(x: -8)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    NavigationLink(destination: Page3().navigationBarBackButtonHidden(true)) {
                        Text("Next")
                            .font(.custom("Apple SD Gothic Neo", size: 45))
                            .padding(.horizontal, 30)
                            .padding(.vertical, 20)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .scaleEffect(isButtonPressed ? 0.9 : 1.0)
                            .animation(.easeInOut, value: isButtonPressed)
                    }
                    .isDetailLink(false)
                    .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                        isButtonPressed = pressing
                    }, perform: {})
                    .animation(.easeInOut, value: isButtonPressed)
                    .offset(y: -50)
                }
            }
        }
    }
}

struct Page2_Previews: PreviewProvider {
    static var previews: some View {
        Page2()
    }
}
