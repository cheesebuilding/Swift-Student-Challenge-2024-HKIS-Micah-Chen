import SwiftUI

struct Page1: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("DragonBoat")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 350)
                        .padding()

                    Text("Dragon Boat Racing is a exciting water sport that combines teamwork, strength, and cultural heritage. The festivities also extend beyond the races, with vibrant parades, traditional music performances, and the sharing of zongzi (sticky rice dumplings) as a symbol of good luck and protection against evil spirits.")
                        .font(.custom("Apple SD Gothic Neo", size: 20))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .offset(y: -20)
                        .offset(x: -8)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    NavigationLink(destination: Page2().navigationBarBackButtonHidden(true)) {
                        Text("Next")
                            .font(.custom("Apple SD Gothic Neo", size: 45))
                            .padding(.horizontal, 30)
                            .padding(.vertical, 20)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .offset(y: -50)
                    }
                    .isDetailLink(false)
                }
            }
        }
    }
}

struct Page1_Previews: PreviewProvider {
    static var previews: some View {
        Page1()
    }
}
