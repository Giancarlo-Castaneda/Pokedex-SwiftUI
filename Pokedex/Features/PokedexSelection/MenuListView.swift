import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

extension Item {

    static var mock: [Item] {
        [
            .init(name: "globe", color: .blue),
            .init(name: "house", color: .red),
            .init(name: "pencil", color: .yellow)
        ]
    }
}

struct MenuListView: View {

    @Namespace var namespace

    var body: some View {
        NavigationStack {
            VStack {
                ForEach(Item.mock) { index in
                    NavigationLink {
                        if #available(iOS 18.0, *) {
                            Text("Detail View \(index.name)")
                                .navigationTransition(.zoom(sourceID: "icon\(index)", in: namespace))
                        } else {
                            Text("Detail View \(index.name)")
                        }
                    } label: {
                        if #available(iOS 18.0, *) {
                            Image(systemName: index.name)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(30)
                                .background(index.color)
                                .cornerRadius(30)
                                .matchedTransitionSource(id: "icon\(index.name)", in: namespace)
                        } else {
                            Image(systemName: index.name)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(30)
                                .background(index.color)
                                .cornerRadius(30)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MenuListView()
}
