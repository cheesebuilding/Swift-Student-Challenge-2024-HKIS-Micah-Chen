import SwiftUI

struct MainMenuView: View {
    @State private var isButtonPressed = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Dragon Boat Racing")
                        .font(.custom("Apple SD Gothic Neo", size: 40))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 50)
                        .offset(y : -20)

                    Text("A Game About Hong Kong Heritage and Culture")
                        .font(.custom("Apple SD Gothic Neo", size: 15))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        .offset(y: -40)

                    Spacer()

                    NavigationLink(destination: Page1().navigationBarBackButtonHidden(true)) {
                        Text("Start Rowing!")
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

                    Spacer()
                }
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
