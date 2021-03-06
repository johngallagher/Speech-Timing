//
//  SpeechTimerAppDelegate.m
//  SpeechTimer
//
//  Created by John Gallagher on 17/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import "SpeechTimerAppDelegate.h"
#import "JGTimerConfigurationViewController.h"
#import "JGTimerDefaults.h"
#import "JGTimerRunningViewController.h"


@interface SpeechTimerAppDelegate ()
-(void)suspendTimerRunningView;

-(void)restoreTimerRunningView;


@end

@implementation SpeechTimerAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

#pragma mark -
#pragma mark Application lifecycle

-(void)awakeFromNib {
    JGTimerConfigurationViewController *rootViewController = (JGTimerConfigurationViewController *)[_navigationController topViewController];
    rootViewController.managedObjectContext = self.managedObjectContext;
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [_window setRootViewController:_navigationController];
    [_window makeKeyAndVisible];
    return YES;
}

-(void)applicationDidBecomeActive:(UIApplication *)application {
    [self restoreTimerRunningView];
}

-(void)applicationWillResignActive:(UIApplication *)application {
    [self suspendTimerRunningView];
}

-(void)suspendTimerRunningView {
    if ([[_navigationController topViewController] isKindOfClass:[JGTimerRunningViewController class]])
        [(JGTimerRunningViewController *)[_navigationController topViewController] suspendCountdownAnimation];
}

-(void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveContext];
}

-(void)restoreTimerRunningView {
    if (![[JGTimerDefaults sharedInstance] timerIsRunning])
        return;

    BOOL timerRunningViewIsShown = [[_navigationController topViewController] isKindOfClass:[JGTimerRunningViewController class]];
    if (timerRunningViewIsShown) {
        [(JGTimerRunningViewController *)[_navigationController topViewController] continueCountdownAnimation];
    } else {
        [(JGTimerConfigurationViewController *)[_navigationController topViewController] pushRunningViewControllerWithCurrentAlert];
    }
}

-(void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

-(void)saveContext {
    NSError                *error                = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
-(NSManagedObjectContext *)managedObjectContext {

    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
-(NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"SpeechTimer" ofType:@"momd"];
    NSURL    *modelURL  = [NSURL fileURLWithPath:modelPath];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SpeechTimer.sqlite"];

    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
-(NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)dealloc {
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];

    [_navigationController release];
    [_window release];
    [super dealloc];
}

@end

