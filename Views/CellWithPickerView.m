//
//  CellWithPickerView.m
//  Booom
//
//  Created by Alena Shilova on 1/30/15.
//  Copyright (c) 2015 kamelise. All rights reserved.
//

#import "CellWithPickerView.h"

@implementation CellWithPickerView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initPickerView {
    _pickerView = [[UIPickerView alloc] init];
}

- (void)showPickerView {
    CGRect pickerViewFrame = _pickerView.frame;
    pickerViewFrame.origin.y = self.frame.size.height;
    _pickerView.frame = pickerViewFrame;
    
    [self addSubview:_pickerView];
    
    CGRect cellFrame = self.frame;
    cellFrame.size.height += pickerViewFrame.size.height;
    self.frame = cellFrame;
}

- (void)hidePickerView {
    CGRect cellFrame = self.frame;
    cellFrame.size.height -= _pickerView.frame.size.height;
    self.frame = cellFrame;
    
    [_pickerView removeFromSuperview];
}


@end
