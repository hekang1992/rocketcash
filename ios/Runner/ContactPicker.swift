import Flutter
import Contacts
import ContactsUI

public class ContactHandler: NSObject, CNContactPickerDelegate {
    private let contactStore = CNContactStore()
    var singleSelectResult: FlutterResult?
    
    public func getAllContacts(result: @escaping FlutterResult) {
        requestContactAccess { [weak self] granted in
            guard granted else {
                result(FlutterError(code: "PERMISSION_DENIED",
                                    message: "PERMISSION_DENIED",
                                    details: nil))
                return
            }
            
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            var contacts = [[String: String]]()
            
            do {
                try self?.contactStore.enumerateContacts(with: request) { contact, _ in
                    let name = self?.formatName(family: contact.familyName, given: contact.givenName) ?? ""
                    
                    for phone in contact.phoneNumbers {
                        let number = phone.value.stringValue
                            .replacingOccurrences(of: "[^0-9+]", with: "", options: .regularExpression)
                        
                        if !name.isEmpty && !number.isEmpty {
                            contacts.append(["activate": name, "space": number])
                        }
                    }
                }
                result(contacts)
            } catch {
                result(FlutterError(code: "FETCH_FAILED",
                                    message: error.localizedDescription,
                                    details: nil))
            }
        }
    }
    
    
    public func pickSingleContact(result: @escaping FlutterResult) {
        requestContactAccess { [weak self] granted in
            guard granted else {
                result(FlutterError(code: "PERMISSION_DENIED",
                                    message: "PERMISSION_DENIED",
                                    details: nil))
                return
            }
            
            self?.singleSelectResult = result
            let picker = CNContactPickerViewController()
            picker.delegate = self
            picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
            
            DispatchQueue.main.async {
                if let controller = UIApplication.shared.keyWindow?.rootViewController {
                    controller.present(picker, animated: true)
                }
            }
        }
    }
    
    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = formatName(family: contact.familyName, given: contact.givenName)
        let phone = contact.phoneNumbers.first?.value.stringValue
            .replacingOccurrences(of: "[^0-9+]", with: "", options: .regularExpression) ?? ""
        
        singleSelectResult?(["activate": name, "space": phone])
        singleSelectResult = nil
    }
    
    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        singleSelectResult?(nil)
        singleSelectResult = nil
    }
    
    private func requestContactAccess(completion: @escaping (Bool) -> Void) {
        contactStore.requestAccess(for: .contacts) { granted, error in
            DispatchQueue.main.async {
                completion(granted && (error == nil))
            }
        }
    }
    
    private func formatName(family: String, given: String) -> String {
        return "\(family)\(given)".trimmingCharacters(in: .whitespaces)
    }
}
