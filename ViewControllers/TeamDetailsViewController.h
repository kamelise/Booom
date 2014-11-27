//
//  TeamDetailsVC.h
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "EditTeamViewController.h"

//@class TeamDetailsVC;

/*@protocol TeamDetailsVCDelegate <NSObject>

-(void)teamDetailsVCDidSave:(TeamDetailsVC *)controller;

@end*/

@interface TeamDetailsViewController : UITableViewController <EditTeamVCDelegate>

@property (strong, nonatomic) NSMutableArray *teamsArray;

@end
