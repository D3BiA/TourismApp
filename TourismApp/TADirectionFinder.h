//
//  TADirectionFinder.h
//  TourismApp
//
//  Created by Alex De Biasi on 09/06/14.
//  Copyright (c) 2014 Alex De Biasi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TADirectionFinder : NSObject
- (void)setDirectionsQuery:(NSDictionary *)object withSelector:(SEL)selector
              withDelegate:(id)delegate;
- (void)retrieveDirections:(SEL)sel withDelegate:(id)delegate;
- (void)fetchedData:(NSData *)data withSelector:(SEL)selector
       withDelegate:(id)delegate;
@end