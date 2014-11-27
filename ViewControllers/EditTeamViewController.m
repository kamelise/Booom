//
//  EditTeamVC.m
//  Booom
//
//  Created by Samka on 10.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "EditTeamViewController.h"
#import "TeamDetailsViewController.h"
#import "SettingsViewController.h"

@interface EditTeamViewController ()

@end

@implementation EditTeamViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.teamNameTextField.text = self.teamName;
    [self.teamNameTextField becomeFirstResponder];
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
    return 1;
    
}

- (IBAction)save:(id)sender
{
    
    self.teamName = self.teamNameTextField.text;
    /*
    NSLog(@"%@", NSStringFromClass([[self presentingViewController] class]));
    UINavigationController *navigationVC = (UINavigationController *)self.presentingViewController;
    UIViewController *teamDetailsVC = (UIViewController *)[navigationVC parentViewController];
    SettingsVC *settingsVC = (SettingsVC *)[teamDetailsVC parentViewController];
    [settingsVC.gameSettings.teamDetails replaceObjectAtIndex:[self.teamID integerValue]
                                                   withObject:self.teamName];
    [Game saveGame:settingsVC.gameSettings];
    [self dismissViewControllerAnimated:YES completion:nil];*/
    //[teamDetailsVC.view setNeedsLayout];
    
    [self.delegate editTeamNameVCDidSave:self];
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
