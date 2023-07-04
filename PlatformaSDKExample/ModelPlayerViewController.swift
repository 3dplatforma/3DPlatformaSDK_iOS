import UIKit
import Platforma

final class ModelPlayerViewController: UIViewController {

    private let service = PlatformaViewer()

    @IBOutlet weak private var activity: UIActivityIndicatorView!
    @IBOutlet weak private var modelView: PlatformaModelView!

    var modelID: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let modelID else { return }
        activity.startAnimating()
        service.getModel(id: modelID) { [weak self] result in
            switch result {
            case .success(let model):
                self?.loadModel(model)
            case .failure(let error):
                self?.activity.stopAnimating()
                self?.showAlert(message: error.rawValue)
            }
        }
    }

    private func loadModel(_ model: PlatformaModel) {
        modelView.viewController = self
        let params = PlatformaModelViewParams(isAutoRotate: true, autoRotateDelay: 10, language: .en)
        modelView.load(model: model, parameters: params) { [weak self] result in
            self?.activity.stopAnimating()
            if case .failure(let error) = result {
                self?.showAlert(message: error.rawValue)
            }
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
