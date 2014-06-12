//
//  TAPlaceTableViewCell.m
//  TourismApp
//
//  Created by Andrea Bianco on 02/06/14.
//  Copyright (c) 2014 Alex De Biasi. All rights reserved.
//

#import "TAPlaceTableViewCell.h"
@interface TAPlaceTableViewCell()
@property (strong,nonatomic) IBOutlet UIView *rowView;
@end
@implementation TAPlaceTableViewCell


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [[NSBundle mainBundle] loadNibNamed:@"myCustomRow" owner:self options:nil];
        [self addSubview:self.rowView];
    }
    return self;
}

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
