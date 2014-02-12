//
//  TITodoListViewController.m
//  ToDoList2
//
//  Created by Tatsu Ikeda on 1/28/14.
//  Copyright (c) 2014 Tatsu Ikeda. All rights reserved.
//

#import "TITodoListViewController.h"
//#import "CreateTodoViewController.h"

@interface TITodoListViewController ()
@end

@implementation TITodoListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Nav Controller Title";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapAddButton)];
        
        self.todos = [NSUserDefaults.standardUserDefaults objectForKey:@"todos"];
        
        if(!self.todos){
            self.todos = [NSMutableArray array];
        }
    }
    return self;
}
//old view didtapaddbutton
//- (void)didTapAddButton {
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New To-Do" message:@"Enter a to-do item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
//    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [alertView show];
//}
//new didtapaddbutton
//- (void)didTapAddButton {
//    CreateTodoViewController *createVC = [[CreateTodoViewController alloc] init];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createVC];
//    [self.navigationController presentViewController:navController animated:YES completion:nil];
//}
- (void)didTapAddButton {
    CreateTodoViewController *createVC = [[CreateTodoViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createVC];
    createVC.delegate = self;
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

- (void)createTodo:(NSString *)todo withDueDate:(NSDate *)dueDate {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    // save the todo
    NSDictionary *item = @{@"text": todo,
                           @"dueDate": dueDate};
    [self.todos addObject:item];
    NSLog(@"%@", self.todos);
    
    
    [[NSUserDefaults standardUserDefaults] setObject:self.todos forKey:@"todos"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    // refresh the table view
    [self.tableView reloadData];
}

- (void)didCancelCreatingNewTodo {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        NSLog(@"Alloc cell");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    } else {
        NSLog(@"Reusing cell");
    }
    
    // Configure the cell...
    
    NSDictionary *todoItem = [self.todos objectAtIndex:indexPath.row];
    NSString *todoString = [todoItem objectForKey:@"text"];
    
    [[cell textLabel] setText:todoString];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"indexPath.row = %ld",(long)indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Title!";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todos removeObjectAtIndex:indexPath.row];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.todos forKey:@"todos"];
        [userDefaults synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - UIAlertViewDelegateProtocol

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.firstOtherButtonIndex)
    {
        NSLog(@"Done button clicked");
        UITextField *tf = [alertView textFieldAtIndex:0];
        NSLog(@"%@",tf.text);
        [self.todos addObject:tf.text];
        NSLog(@"%@",self.todos);
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.todos forKey:@"todos"];
        [userDefaults synchronize];
        
        [self.tableView reloadData];
    }
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        NSLog(@"User canceled");
    }
}


@end
