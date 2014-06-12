//
//  TAMapsViewController.m
//  TourismApp
//
//  Created by Alex De Biasi on 09/06/14.
//  Copyright (c) 2014 Alex De Biasi. All rights reserved.
//

#import "TAMapsViewController.h"
#import "TADirectionFinder.h"
#import "TASummaryPathViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface TAMapsViewController () <GMSMapViewDelegate>{
    GMSMapView *mapView_;
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
    BOOL firstLocationUpdate_;
    CLLocationCoordinate2D placePosition;
    
    NSString *duration;
    NSString *distance;
    NSMutableArray* instructions;
}
@end
@implementation TAMapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    waypoints_ = [[NSMutableArray alloc]init];
    waypointStrings_ = [[NSMutableArray alloc]init];
    
    
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.latitudine doubleValue]
                                                            longitude:[self.longitudine doubleValue]
                                                                 zoom:12];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    
    placePosition = CLLocationCoordinate2DMake([self.latitudine floatValue],
                                                                [self.longitudine floatValue]);
    GMSMarker *marker = [GMSMarker markerWithPosition:placePosition];
    marker.title = self.name;
    marker.map = mapView_;
    
    // Listen to the myLocation property of GMSMapView.
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    self.view = mapView_;
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
}

- (void)dealloc {
    [mapView_ removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        NSString *str=[[NSString alloc] initWithFormat:@" latitude:%f longitude:%f",location.coordinate.latitude,location.coordinate.longitude];
        NSLog(@"%@",str);
        
        GMSMarker *markerStart= [GMSMarker markerWithPosition:location.coordinate];
        markerStart.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
        markerStart.title = @"You are here";
        markerStart.map = mapView_;
        [waypoints_ addObject:markerStart];
        NSString *positionStringStart = [[NSString alloc] initWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
        [waypointStrings_ addObject:positionStringStart];
        
        GMSMarker *marker = [GMSMarker markerWithPosition:placePosition];
        [waypoints_ addObject:marker];
        NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",[self.latitudine floatValue],[self.longitudine floatValue]];
        [waypointStrings_ addObject:positionString];
        
        NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.it"];
        NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
        if (data){
            NSLog(@"Device is connected to the internet");
            NSString *sensor = @"true";
            NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,nil];
            NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
            NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                              forKeys:keys];
            TADirectionFinder *mds=[[TADirectionFinder alloc] init];
            SEL selector = @selector(addDirections:);
            [mds setDirectionsQuery:query
                       withSelector:selector
                       withDelegate:self];
        } else {
            NSLog(@"Device is not connected to the internet");
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"TourismApp" message:@"Please, connect to internet for search best path" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
        }
        
    }
}

- (void)addDirections:(NSDictionary *)json {
    
    NSDictionary *routes = [json objectForKey:@"routes"][0];
    
    distance = [[[[[[json objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"distance"] objectForKey:@"text"];
    duration = [[[[[[json objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"duration"] objectForKey:@"text"];
    
    instructions = [[NSMutableArray alloc] init];
    //Get Array of Instructions
    for (int n=0; n<[[[[[[json objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"steps"]count]; n++) {
        [instructions addObject:[[[[[[[json objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"steps"] objectAtIndex:n] objectForKey:@"html_instructions"]];
    }
    
    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
    NSString *overview_route = [route objectForKey:@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.map = mapView_;
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showDirectionSummary"]){
        
        TASummaryPathViewController *destViewController = segue.destinationViewController;
        destViewController.time = duration;
        destViewController.distance = distance;
        destViewController.instructions = [instructions copy];
        destViewController.title = @"Summary";
    }
}
@end
