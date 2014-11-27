//
//  EditTeamVC.h
//  Booom
//
//  Created by Samka on 10.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

//#import <UIKit/UIKit.h>

@class EditTeamViewController;

@protocol EditTeamVCDelegate <NSObject>

- (void)editTeamNameVCDidSave:(EditTeamViewController *)controller;

@end

@interface EditTeamViewController : UITableViewController

@property (strong, nonatomic) NSString *teamName;
@property (strong, nonatomic) NSNumber *teamID;
@property (weak, nonatomic) IBOutlet UITextField *teamNameTextField;

@property (nonatomic, weak) id <EditTeamVCDelegate> delegate;

- (IBAction)save:(id)sender;
@end
