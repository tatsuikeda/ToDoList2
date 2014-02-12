//
//  TITodoListViewController.h
//  ToDoList2
//
//  Created by Tatsu Ikeda on 1/28/14.
//  Copyright (c) 2014 Tatsu Ikeda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateTodoViewController.h"

//@interface TITodoListViewController : UITableViewController <UIAlertViewDelegate>

@interface TITodoListViewController : UITableViewController<UIAlertViewDelegate, CreateTodoViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *todos;
@end
