//
//  MapViewController.h
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/Mapkit.h"

@interface MapViewController : UIViewController

- (void) addLocations:(NSArray *)locations;
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation;

@end
