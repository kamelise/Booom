//
//  CellWithPickerView.h
//  Booom
//
//  Created by Alena Shilova on 1/30/15.
//  Copyright (c) 2015 kamelise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellWithPickerView : UITableViewCell

@property (strong, nonatomic) UIPickerView *pickerView;

- (void)initPickerView;
- (void)showPickerView;

- (void)hidePickerView;

@end
