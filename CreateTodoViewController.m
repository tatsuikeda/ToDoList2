//
//  CreateTodoViewController.m
//  ToDoList2
//
//  Created by Tatsu Ikeda on 2/11/14.
//  Copyright (c) 2014 Tatsu Ikeda. All rights reserved.
//

#import "CreateTodoViewController.h"

@interface CreateTodoViewController ()
@property (strong, nonatomic) UITextField *todoInput;
@property (strong, nonatomic) UITextField *dueDateInput;
@property (strong, nonatomic) NSDate *dueDate;
@end

@implementation CreateTodoViewController

- (void)didTapDoneButton {
    [self.delegate createTodo:self.todoInput.text withDueDate:self.dueDate];
}

- (void)didTapCancelButton {
    [self.delegate didCancelCreatingNewTodo];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"New To-Do";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(didTapDoneButton)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(didTapCancelButton)];
    
    [self renderTodoText];
    [self renderDueDate];
}

- (void)renderTodoText {
    UILabel *todoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 0, 0)];
    todoLabel.text = @"To-do:";
    todoLabel.font = [UIFont boldSystemFontOfSize:UIFont.systemFontSize];
    [todoLabel sizeToFit];
    [self.view addSubview:todoLabel];
    
    self.todoInput = [[UITextField alloc] init];
    self.todoInput.borderStyle = UITextBorderStyleRoundedRect;
    self.todoInput.placeholder = @"Enter a to-do here.";
    self.todoInput.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.todoInput.delegate = self;
    self.todoInput.frame = CGRectMake(CGRectGetMinX(todoLabel.frame),
                                      CGRectGetMaxY(todoLabel.frame) + 5,
                                      CGRectGetWidth(self.view.frame) - (40),
                                      40);
    [self.view addSubview:self.todoInput];
}
- (void)didChangeDate:(id)sender {
    NSLog(@"didChangeDate");
    UIDatePicker *datePicker = sender;
    NSDate *date = datePicker.date;
    self.dueDate = date;
    NSLog(@"The date is: %@",date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    NSLog(@"The formatted date string is: %@",formattedDateString);
    self.dueDateInput.text = formattedDateString;
    //[self.dueDateInput setText:formattedDateString];
    //[[self dueDateInput] setText:formattedDateString];
}

- (void)renderDueDate {
    CGRect dueDateLabelFrame = CGRectMake(CGRectGetMinX(self.todoInput.frame), CGRectGetMaxY(self.todoInput.frame) + 30, 0, 0);
    UILabel *dueDateLabel = [[UILabel alloc] initWithFrame:dueDateLabelFrame];
    dueDateLabel.text = @"Due date:";
    dueDateLabel.font = [UIFont boldSystemFontOfSize:UIFont.systemFontSize];
    [dueDateLabel sizeToFit];
    [self.view addSubview:dueDateLabel];
    
    self.dueDateInput = [[UITextField alloc] init];
    self.dueDateInput.borderStyle = UITextBorderStyleRoundedRect;
    self.dueDateInput.placeholder = @"Due date";
    self.dueDateInput.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.dueDateInput.delegate = self;
    
    CGRect dueDateFrame = self.todoInput.frame;
    dueDateFrame.origin.y = CGRectGetMaxY(dueDateLabel.frame) + 5;
    self.dueDateInput.frame = dueDateFrame;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(didChangeDate:) forControlEvents:UIControlEventValueChanged];
    self.dueDateInput.inputView = datePicker;
    
    [self.view addSubview:self.dueDateInput];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
