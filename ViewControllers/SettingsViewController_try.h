//
//  SettingsVC.h
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "GameSettings.h"
#import "Teams.h"

@interface SettingsViewController : UITableViewController <UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    NSArray *_wordsNumberPickerData;
}

@property (strong, nonatomic) GameSettings *gameSettings;
@property (strong, nonatomic) NSArray *categoryArray;
@property (strong, nonatomic) NSMutableArray *numbers;

@property (strong, nonatomic) UIButton *dimView;
//@property (strong, nonatomic) UIBarButtonItem *doneButtonItem;

//@property (strong, nonatomic) UIPickerView *teamsPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *teamsPicker;
@property (strong, nonatomic) UIPickerView *wordsNumberPicker;
@property (strong, nonatomic) UIPickerView *durationPicker;

@property (weak, nonatomic) IBOutlet UILabel *numberTeams;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;

@property (weak, nonatomic) IBOutlet UILabel *wordsNumber;

@property (weak, nonatomic) IBOutlet UILabel *roundDuration;
@property (weak, nonatomic) IBOutlet UILabel *language;

-(void)showCategoryActionSheet:(id)sender;

@end
