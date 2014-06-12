//
//  TADetailViewController.h
//  TourismApp
//
//  Created by Andrea Bianco on 02/06/14.
//  Copyright (c) 2014 Alex De Biasi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TADetailViewController : UIViewController
@property (strong,nonatomic) NSString *placeName;
@property (strong,nonatomic) NSArray *placeImage;
@property (strong,nonatomic) NSString *placeDescription;
@property (strong,nonatomic) NSString *placeLatitudine;
@property (strong,nonatomic) NSString *placeLongitudine;
@end
