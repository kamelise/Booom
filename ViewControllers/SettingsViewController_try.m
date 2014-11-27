//
//  SettingsVC.m
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

#import "SettingsViewController.h"
#import "TeamDetailsViewController.h"
#import "QuartzCore/QuartzCore.h"


typedef NS_ENUM(NSInteger, UIActionSheetChosen) {
    ChooseCategory      = 1,
    ChooseLanguage      = 2,
};

@interface SettingsViewController ()
@property (nonatomic) UIActionSheetChosen actionSheetChoosen;
@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gameSettings = [GameSettings getGame];
    if (!self.gameSettings) {
        self.gameSettings = [[GameSettings alloc] init];
    };
    self.categoryArray = [[NSArray alloc] initWithObjects:@"simpleWords", @"popularPersons", @"popStage", @"actors", @"writers", @"animals",nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.numberTeams.text = [self.gameSettings.numberTeams stringValue];
    self.categoryName.text = NSLocalizedString(self.gameSettings.categoryName,nil);
    self.wordsNumber.text = [self.gameSettings.wordsNumber stringValue];
    self.roundDuration.text = [self.gameSettings.roundDuration stringValue];
    self.language.text = NSLocalizedString(self.gameSettings.language, nil);
    
    self.numbers = [NSMutableArray array];
    for (int i = 0; i < 10; i++)
    {
        [self.numbers addObject:[NSString stringWithFormat:@"%d", i]];
    }
    

    //Выбор количества команд
    /*self.teamsPicker = [[UIPickerView alloc] initWithFrame:
                        CGRectMake(0,
                                   30,
                                   150,
                                   60)];
     */
    /*self.teamsPicker.layer.borderColor = [UIColor blueColor].CGColor;
    self.teamsPicker.layer.borderWidth = 1.0f;*/
    //[self.teamsPicker setDataSource:self];
    //[self.teamsPicker setDelegate:self];
    //self.teamsPicker.showsSelectionIndicator = YES;
    //[self.teamsPicker selectRow:[self.gameSettings.numberTeams intValue] - 2 inComponent:0 animated:YES];
    
    //Добавление кнопки Done в teamsPicker
    /*UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,-30,150,30)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self.parentViewController
                                                                     action:@selector(hideOtherPickers:)];
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    barButtonDone.tintColor=[UIColor blackColor];
    [self.teamsPicker addSubview:toolBar];
    */
    //Выбор количества слов в игре
    self.wordsNumberPicker = [[UIPickerView alloc] initWithFrame:
                        CGRectMake(0,
                                   30,
                                   150,
                                   60)];
    [self.wordsNumberPicker setDataSource:self];
    [self.wordsNumberPicker setDelegate:self];
    self.wordsNumberPicker.showsSelectionIndicator = YES;
    [self.wordsNumberPicker selectRow:([self.gameSettings.wordsNumber intValue] - 10)/2 inComponent:0 animated:YES];

    //Выбор длительности хода
    self.durationPicker = [[UIPickerView alloc] initWithFrame:
                              CGRectMake(0,
                                         30,
                                         150,
                                         60)];
    [self.durationPicker setDataSource:self];
    [self.durationPicker setDelegate:self];
    self.durationPicker.showsSelectionIndicator = YES;
    [self.durationPicker selectRow:([self.gameSettings.roundDuration intValue] - 10)/5 inComponent:0 animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    
    /*UIView *dimView = [[UIView alloc] initWithFrame:CGRectMake(0,
     0,
     self.view.frame.size.width,
     self.view.frame.size.height)];
     self.dimView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];*/
    
    self.dimView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dimView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    self.dimView.frame = CGRectMake(0,
                                    0,
                                    self.view.frame.size.width,
                                    self.view.frame.size.height);
    [self.dimView addTarget:self
                     action:@selector(removeDimView)
           forControlEvents:UIControlEventTouchUpInside];
    //NSLog(@"%li",(long)self.dimView.subviews.count);

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            [self showTeamsPickerView:self];
            break;
        case 1:
            
            break;
        case 2:
            [self showCategoryActionSheet:self];
            break;
        case 3:
            if (indexPath.row == 0)
                [self showWordsNumberPickerView:self];
            else if (indexPath.row ==1)
                [self showDurationPickerView:self];
            break;
        case 4:
            [self showLanguageActionSheet:self];
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int rows = 0;
     if (pickerView == self.teamsPicker) {
          rows = 9;
     } else if (pickerView == self.wordsNumberPicker) {
         rows = 46;
     } else if (pickerView == self.durationPicker) {
         rows = 59;
     }
    return rows;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    if (pickerView == self.teamsPicker) {
        label.text = [NSString stringWithFormat:@"%d", (int)row+2];
    } else if (pickerView == self.wordsNumberPicker) {
        label.text = [NSString stringWithFormat:@"%d", 10+(int)row*2];
    } else if (pickerView == self.durationPicker) {
        label.text = [NSString stringWithFormat:@"%d", 10+(int)row*5];;
    }
    
    return label;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.teamsPicker) {
    
        int numberTeams = [self.gameSettings.numberTeams intValue];
        //NSLog(@"%i",numberTeams);
        //NSLog(@"%i",(int)row+2);
        if (numberTeams > row+2)
        {
            NSRange nsrange = NSMakeRange(row+2, numberTeams - (row+2));
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:nsrange];
            [self.gameSettings.teamDetails removeObjectsAtIndexes:indexes];
        } else if (numberTeams < row+2) {
            for (int i = numberTeams; i < row +2 ; i++) {
                NSString *newTeam = [NSString stringWithFormat:NSLocalizedString(@"Team %d", nil), i+1];
                [self.gameSettings.teamDetails addObject:newTeam];
            }
        }
    
        self.numberTeams.text = [NSString stringWithFormat:@"%d", (int)row+2];
        self.gameSettings.numberTeams = [NSNumber numberWithInt:((int)row+2)];
        [GameSettings saveGame:self.gameSettings];
    
    } else if (pickerView == self.wordsNumberPicker) {
        self.wordsNumber.text = [NSString stringWithFormat:@"%d", 10+(int)row*2];
        self.gameSettings.wordsNumber = [NSNumber numberWithInt:(10+(int)row*2)];
        [GameSettings saveGame:self.gameSettings];
        
    } else if (pickerView == self.durationPicker) {
        self.roundDuration.text = [NSString stringWithFormat:@"%d", 10+(int)row*5];
        self.gameSettings.roundDuration = [NSNumber numberWithInt:(10+(int)row*5)];
        
        [GameSettings saveGame:self.gameSettings];
    }
}

//-(void)showPopOver:(id)sender: (int)xPos :(int)yPos {
UIView *showPopOver(id sender, int xPos, int yPos) {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, 150, 200)]; //<- change to where you want it to show.
    
    //Set the customView properties
    customView.alpha = 1.0;
    customView.layer.cornerRadius = 5;
    customView.layer.borderWidth = 0.2f;
    customView.layer.borderColor = [UIColor grayColor].CGColor;
    customView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    //customView.layer.masksToBounds = YES;
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    /*[saveButton addTarget:sender action:@selector(hideDimView:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton addTarget:customView action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
*/
    [saveButton addTarget:sender action:@selector(removeDimView) forControlEvents:UIControlEventTouchUpInside];

    
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    saveButton.frame = CGRectMake(105, 5, 40, 20);
    [customView addSubview:saveButton];
    //[self.view addSubview:customView];
    //NSLog(@"%@",NSStringFromClass([saveButton superview]));
    return customView;
}

- (void)showTeamsPickerView:(id)sender
{
    
    [self.view addSubview:self.dimView];
    UIView *popOver = showPopOver(self, 85, 80);
    [self.dimView addSubview:popOver];
    [popOver addSubview:self.teamsPicker];
    //NSLog(@"11%li",(long)self.dimView.subviews.count);
    
    //Display the customView with animation
    //[UIView animateWithDuration:0.4 animations:^{[customView setAlpha:1.0];} completion:^(BOOL finished) {}];
}

- (void)showWordsNumberPickerView:(id)sender {
    [self.view addSubview:self.dimView];
    UIView *popOver = showPopOver(self, 85, 250);
    [self.dimView addSubview:popOver];
    [popOver addSubview:self.wordsNumberPicker];
    //NSLog(@"22%li",(long)self.dimView.subviews.count);
    //NSLog(@"%@",self.dimView.subviews[0]);
}

- (void)showDurationPickerView:(id)sender {
    [self.view addSubview:self.dimView];
    UIView *popOver = showPopOver(self, 85, 280);
    [self.dimView addSubview:popOver];
    [popOver addSubview:self.durationPicker];
    //NSLog(@"33%li",(long)self.dimView.subviews.count);

}

-(void)hideDimView:(id)sender {

    [self.dimView removeFromSuperview];


}

-(void)removeDimView {
    
    for (UIView *view in self.dimView.subviews) [view removeFromSuperview];
    [self.dimView removeFromSuperview];
}

- (void)showCategoryActionSheet:(id)sender
{

    UIActionSheet *categoryPopup = [[UIActionSheet alloc]
                                    initWithTitle:NSLocalizedString(@"ChooseCategory", nil)
                                    delegate:sender
                                    cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                    destructiveButtonTitle:nil
                                    otherButtonTitles:
                                        NSLocalizedString(@"simpleWords", nil),
                                        NSLocalizedString(@"popularPersons", nil),
                                        NSLocalizedString(@"popStage", nil),
                                        NSLocalizedString(@"actors", nil),
                                        NSLocalizedString(@"writers", nil),
                                        NSLocalizedString(@"animals", nil),
                                        nil];
    [categoryPopup showInView:self.view];//[UIApplication sharedApplication].keyWindow];
}

- (void)showLanguageActionSheet:(id)sender
{
    
    UIActionSheet *categoryPopup = [[UIActionSheet alloc]
                                    initWithTitle:NSLocalizedString(@"ChooseLanguage", nil)
                                    delegate:sender
                                    cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                    destructiveButtonTitle:nil
                                    otherButtonTitles:
                                        NSLocalizedString(@"English", nil),
                                        NSLocalizedString(@"Russian", nil),
                                        nil];
    [categoryPopup showInView:self.view];//[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    //NSLog(@"%@",popup.title);
    if ([popup.title isEqualToString:NSLocalizedString(@"ChooseCategory", nil)])
        self.actionSheetChoosen = ChooseCategory;
    else self.actionSheetChoosen = ChooseLanguage;
    switch (self.actionSheetChoosen) {
        case ChooseCategory:
            if (buttonIndex < 6) {
                NSString *localizedString = self.categoryArray[buttonIndex];
                self.categoryName.text = NSLocalizedString(localizedString, nil);
                self.gameSettings.categoryName = self.categoryArray[buttonIndex];
                [GameSettings saveGame:self.gameSettings];
            };
            break;
        case ChooseLanguage:
            if (buttonIndex == 0) {
                NSString *language = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
                if (!([self.gameSettings.language isEqualToString:@"English"]) && !([language isEqualToString:@"en"]))
                {
                    self.language.text = NSLocalizedString(@"English", nil);
                    self.gameSettings.language = @"English";
                    [GameSettings saveGame:self.gameSettings];
                    languageChangeAlert (self);
                } else if (!([self.gameSettings.language isEqualToString:@"English"])) {
                    self.language.text = NSLocalizedString(@"English", nil);
                    self.gameSettings.language = @"English";
                    [GameSettings saveGame:self.gameSettings];
                }
                    
            } else if (buttonIndex == 1) {
                NSString *language = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
                
  //              NSLog(@"%@",language);
                if ((![self.gameSettings.language isEqualToString:@"Russian"]) && !([language isEqualToString:@"ru"]))
                {
                    self.language.text = NSLocalizedString(@"Russian", nil);
                    self.gameSettings.language = @"Russian";
                    [GameSettings saveGame:self.gameSettings];
                    languageChangeAlert(self);
                } else if (![self.gameSettings.language isEqualToString:@"Russian"]) {
                    self.language.text = NSLocalizedString(@"Russian", nil);
                    self.gameSettings.language = @"Russian";
                    [GameSettings saveGame:self.gameSettings];
                }
            }
            break;
    }

}

void languageChangeAlert(id sender) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"LanguageAlertTitle", nil)
                                                    message:NSLocalizedString(@"LanguageAlertText", nil)
                                                   delegate:sender
                                          cancelButtonTitle:NSLocalizedString(@"LanguageAlertCancelTitle", nil)
                                          otherButtonTitles:nil,
                          nil];
    [alert show];

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

/*
#pragma mark - Navigation
*/
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"editTeamNames"]) {
        //UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        //NSLog(@"%@", NSStringFromClass([[segue destinationViewController] class]));

        TeamDetailsViewController *teamDetailsVC = (TeamDetailsViewController *)segue.destinationViewController;
        teamDetailsVC.teamsArray = [[NSMutableArray alloc] init];

        [teamDetailsVC.teamsArray addObjectsFromArray:self.gameSettings.teamDetails];
    }
}



@end
