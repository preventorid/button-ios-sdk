//
//  RifReaderView.swift
//  
//
//  Created by Alexander Rodriguez on 17/02/22.
//

import SwiftUI
import DocumentReader


struct RifReaderView: BaseView, RIFReaderViewControllerDelegate {
    
    @ObservedObject private(set) var store: ReduxStore<PSDKEmptyState>
    @State var showReader: Bool = false
    let controller = UIViewController()
    
    
    var contentBody: some View {
        VStack {
            Spacer()
            ZStack {
                Button("Hola") {
                    if PSDKSession.shared.getDatabaseState() == .success {
                        showReader = true
                    } else {
                        print("Database status: ", PSDKSession.shared.getDatabaseState())
                    }
                }
                if showReader {
                    RIFReaderViewController(delegate: self)
                }
            }
            Spacer()
        }
    }

    func nextAction() {
        
    }
    
    func getController() -> UIViewController {
        controller
    }
    
    func complete() {
    }
    
    func showScaner() -> Bool {
        showReader
    }
    
}

protocol RIFReaderViewControllerDelegate {
    
    func getController() -> UIViewController
    func complete()
    func showScaner() -> Bool
    
}

struct RIFReaderViewController: UIViewControllerRepresentable {
    
    var delegate: RIFReaderViewControllerDelegate
    unowned var controller: UIViewController
    let rifDelegate = Delegate()
    
    init(delegate: RIFReaderViewControllerDelegate) {
        self.delegate = delegate
        controller = delegate.getController()
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if delegate.showScaner() {
            initializeReader()
        }
    }
    
    func initializeReader() {
        do {
            guard let licensePath = Bundle.module.path(forResource: "regula.license", ofType: nil) else { return }
            let licenseData = try Data(contentsOf: URL(fileURLWithPath: licensePath))
            let config = DocReader.Config(license: licenseData)
            
            DocReader.shared.initializeReader(config: config) { (success, error) in
                if success {
                    self.openRIFReader()
                } else if let error = error {
                    // DocumentReader not initialized
                    print(error)
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    func openRIFReader() {
        DocReader.shared.rfidDelegate = rifDelegate
        DocReader.shared.startRFIDReader(fromPresenter: controller, completion: { (action, results, error) in
            switch action {
            case .complete:
                print("Completed")
                print("all: ", results)
                print("vdsncData: ", results?.vdsncData)
                print("rfidSessionData: ", results?.rfidSessionData)
                delegate.complete()
            case .cancel:
                print("Cancelled by user")
                delegate.complete()
            case .error:
                print("Error: \(error!)")
                delegate.complete()
            default:
                break;
            }
        })
        
    }
    
    class Delegate: NSObject, RGLDocReaderRFIDDelegate  {
        func didChipConnected() {
            print("Connected")
        }
        func didReceivedError(_ errorCode: RFIDErrorCodes) {
            print(errorCode.rawValue)
        }
    }
    
}
