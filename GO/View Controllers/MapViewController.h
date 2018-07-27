//
//  MapViewController.h
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/Mapkit.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, UIPageViewControllerDelegate>

- (void) addLocations:(NSMutableArray *)locations;
- (void) fetchLocations;
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation;

@end
