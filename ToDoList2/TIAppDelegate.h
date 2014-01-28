//
//  TIAppDelegate.h
//  ToDoList2
//
//  Created by Tatsu Ikeda on 1/28/14.
//  Copyright (c) 2014 Tatsu Ikeda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
