//
//  TAPlaceTableViewCell.m
//  TourismApp
//
//  Created by Andrea Bianco on 02/06/14.
//  Copyright (c) 2014 Alex De Biasi. All rights reserved.
//

#import "TAPlaceTableViewCell.h"

@implementation TAPlaceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
