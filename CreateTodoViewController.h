//
//  CreateTodoViewController.h
//  ToDoList2
//
//  Created by Tatsu Ikeda on 2/11/14.
//  Copyright (c) 2014 Tatsu Ikeda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateTodoViewControllerDelegate
- (void)createTodo:(NSString *)inputText withDueDate:(NSDate *)dueDate;
- (void)didCancelCreatingNewTodo;
@end


@interface CreateTodoViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) id<CreateTodoViewControllerDelegate>delegate;
@end
