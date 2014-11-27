//
//  TeamDetailsVC.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "TeamDetailsViewController.h"
#import "Teams.h"
#import "SettingsViewController.h"


@interface TeamDetailsViewController ()

@end

@implementation TeamDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.teamsArray.count;
    //NSLog(@"%d", self.teamsArray.count);
    //NSLog(@"ready");
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamCell"];
    //forIndexPath:indexPath];
    
    NSString *teamName = (self.teamsArray)[indexPath.row];
    //NSLog(@"%@", NSStringFromClass([teamName class]));
    //NSLog(@"%@", teamName);
    cell.textLabel.text = teamName;
    cell.tag = 1000+indexPath.row;
    // Configure the cell...
    return cell;
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

- (void)editTeamNameVCDidSave:(EditTeamViewController *)controller {
    //NSLog(@"%@",controller.teamName);
    NSIndexPath *path = [NSIndexPath indexPathForRow:[controller.teamID integerValue] inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    cell.textLabel.text = controller.teamName;
    [self.teamsArray replaceObjectAtIndex:[controller.teamID integerValue]
                               withObject:controller.teamName];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UINavigationController *navVC = (UINavigationController *)[self parentViewController];
    SettingsViewController *settingsVC = (SettingsViewController *)navVC.viewControllers[1];
    //NSLog(@"%@",settingsVC.gameSettings.categoryName);
    //NSLog(@"%@", NSStringFromClass([navVC.viewControllers[1] class]));
    
    [settingsVC.gameSettings.teamDetails replaceObjectAtIndex:[controller.teamID integerValue]
                                                   withObject:controller.teamName];
    
    [GameSettings saveGame:settingsVC.gameSettings];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"editTeam"]) {
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        //NSLog(@"%@", NSStringFromClass([[segue destinationViewController] class]));
        
        EditTeamViewController *editTeamVC = (EditTeamViewController *)[navigationController visibleViewController];
        
        editTeamVC.delegate = self;
        
        //NSLog(@"%@", NSStringFromClass([self class]));
        UITableViewCell *cell = (UITableViewCell *)sender;
        //NSLog(@"%i",cell.tag-1000);
        //NSLog(@"%@",self.teamsArray[cell.tag-1000]);
        editTeamVC.teamID = [NSNumber numberWithInteger:cell.tag-1000];
        editTeamVC.teamName = self.teamsArray[cell.tag-1000];
        editTeamVC.teamNameTextField.text = editTeamVC.teamName;
    }
}

@end
