import SwiftUI
import SafariServices

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    
    var url: URL
    var onDismiss: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> UIViewController {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = context.coordinator
        return safariViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        // No update needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        var parent: SFSafariViewWrapper

        init(_ parent: SFSafariViewWrapper) {
            self.parent = parent
        }

        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            parent.onDismiss()
        }
    }
}

// MARK: - Previews

private struct SFSafariViewWrapperPreviewContainer: View {
    @State var isShowing = false
    
    var body: some View {
        Button("Show Safari View") {
            isShowing = true
        }
        .sheet(isPresented: $isShowing) {
            SFSafariViewWrapper(url: URL(string: "https://heyy.lol")!) {
                isShowing = false
            }
        }
    }
}

#Preview {
    SFSafariViewWrapperPreviewContainer()
}
