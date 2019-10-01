import CoreData
import SwiftUI

protocol EggStoreDelegate: AnyObject {
    func updated()
}

class EggStore: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {    
    var settings: Settings?
    weak var delegate: EggStoreDelegate?

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Settings")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var frc: NSFetchedResultsController<Settings> = {
        let fr: NSFetchRequest<Settings> = Settings.fetchRequest()
        fr.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        fr.predicate = NSPredicate(format: "createdAt != nil")
        fr.fetchLimit = 1
        return NSFetchedResultsController(fetchRequest: fr, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    }()

    override init() {
        super.init()
        
        initialize()
        fetch()
    }
    
    func initialize() {
        try? persistentContainer.viewContext.setQueryGenerationFrom(.current)
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        frc.delegate = self
    }
    
    func fetch() {
        try? frc.performFetch()
        settings = frc.fetchedObjects?.first ?? {
            let settings = Settings(context: persistentContainer.viewContext)
            settings.createdAt = Date()
            return settings
        }()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        settings = controller.fetchedObjects?.first as? Settings
        update()
    }
    
    func update() {
        delegate?.updated()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
