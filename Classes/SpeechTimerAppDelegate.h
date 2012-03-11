#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SpeechTimerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow               *_window;
    UINavigationController *_navigationController;
    NSManagedObjectContext       *_managedObjectContext;
    NSManagedObjectModel         *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@property(nonatomic, retain) IBOutlet UIWindow               *window;
@property(nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property(nonatomic, retain, readonly) NSManagedObjectContext       *managedObjectContext;
@property(nonatomic, retain, readonly) NSManagedObjectModel         *managedObjectModel;
@property(nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(NSURL *)applicationDocumentsDirectory;

-(void)saveContext;

@end

