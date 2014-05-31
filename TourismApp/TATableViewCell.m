//
//  TATableViewCell.m
//  TourismApp
//
//  Created by Alex De Biasi on 30/05/14.
//  Copyright (c) 2014 Alex De Biasi. All rights reserved.
//

#import "TATableViewCell.h"
@interface TATableViewCell()
//proprietà
@property (strong, nonatomic)IBOutlet UIView* subview; //iboutlet permette di collegare allo xib
@end
@implementation TATableViewCell


- (id) initWithCoder:(NSCoder *)aDecoder// Usato per ogni caricamento da xib o storyboard
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        //do something
        [[NSBundle mainBundle] loadNibNamed:@"myrow" owner:self options:nil];
        [self addSubview:self.subview];
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
