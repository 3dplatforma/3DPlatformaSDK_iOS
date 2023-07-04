import UIKit
import Platforma
import AVFoundation

final class ViewController: UIViewController {

    private typealias CapturingParameters = PlatformaCapturing.CapturingParameters
    private typealias CapturingMode = PlatformaCapturing.CapturingMode

    private let capturingManager = PlatformaCapturing()

    private var lastCreatedModelID: String?

    @IBOutlet private weak var viewModelButton: UIButton!

    @IBAction private func indoorTap(_ sender: Any) {
        checkCameraPermission {
            self.presentCapturingMode(.indoor)
        }
    }
    @IBAction private func carsAndVehiclesTap(_ sender: Any) {
        checkCameraPermission {
            self.presentCapturingMode(.carsAndVehicles)
        }
    }
    @IBAction private func panoramaTap(_ sender: Any) {
        checkCameraPermission {
            self.presentCapturingMode(.panorama)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelButton.isHidden = lastCreatedModelID == nil
    }

    private func presentCapturingMode(_ mode: CapturingMode) {
        switch PlatformaSDK.shared.tokenStatus {
        case .checking:
            showAlert(message: "Токен проверяется")
        case .tokenInvalid:
            showAlert(message: "Токен неправильный")
        case .tokenIsEmpty:
            showAlert(message: "Токен пустой")
        case .success:
            if capturingManager.isMemoryEnought {
                let parameters = CapturingParameters(capturingMode: mode) { [weak self] modelID in
                    self?.lastCreatedModelID = modelID
                    self?.viewModelButton.isHidden = modelID == nil
                }
                capturingManager.present(on: self, capturingParameters: parameters)
            } else {
                showAlert(message: "Недостаточно памяти на устройстве")
            }
        }
    }

    private func checkCameraPermission(completion: @escaping () -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            DispatchQueue.main.async {
                completion()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { isGranted in
                if isGranted {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        default:
            askRedirectToSettings()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ModelPlayerViewController else { return }
        destinationVC.modelID = lastCreatedModelID
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    private func askRedirectToSettings() {
        DispatchQueue.main.async {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsUrl) else {
                return
            }
            let alert = UIAlertController(title: nil, message: "Разрешите доступ к камере, пожалуйста", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "отмена", style: .cancel)
            let okAction = UIAlertAction(title: "ok", style: .default) { _ in
                UIApplication.shared.open(settingsUrl)
            }
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
