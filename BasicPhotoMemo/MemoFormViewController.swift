//
//  MemoFormViewController.swift
//  BasicPhotoMemo
//
//  Created by Fenta on 2020/11/05.
//

import UIKit

class MemoFormViewController: UIViewController {

    var subject: String!
    
    @IBOutlet weak var contents: UITextView!
    
    @IBOutlet weak var preview: UIImageView!
    
    @IBAction func save(_ sender: Any) {
        guard contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력하세요", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            
            present(alert, animated: true)
            
            return
        }
        
        let data = MemoData()
        
        data.title = subject
        data.contents = contents.text
        data.image = preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memoList.append(data)
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contents.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MemoFormViewController: UINavigationControllerDelegate {
    
}

extension MemoFormViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = contents.length > 15 ? 15 : contents.length
        subject = contents.substring(with: NSRange(location: 0, length: length))
        
        navigationItem.title = subject
    }
}

extension MemoFormViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        preview.image = info[.editedImage] as? UIImage
        
        picker.dismiss(animated: true)
    }
}
