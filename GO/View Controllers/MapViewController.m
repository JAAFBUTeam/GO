//
//  MapViewController.m
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "MapViewController.h"
#import "MapKit/Mapkit.h"
#import "Location.h"
#import "MKPointAnnotation+Extended_Annotation.h"
#import "DetailsViewController.h"
#import "MKAnnotationView+Extended_View.h"
#import "MKPinAnnotationView+Extended_Pin.h"

@interface MapViewController () 

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSArray *locations;

@end

@implementation MapViewController

#pragma mark - View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
    
    self.mapView.delegate = self;
    
    [self setRegion];
    
    //[self fetchLocations];
    self.locations = [NSArray arrayWithObjects:[Location createLocation], nil];
    [self addLocations:self.locations];
    // [Location postLocation:nil];
    
}

#pragma mark - Networking

- (void) fetchLocations {
    PFQuery *query = [PFQuery queryWithClassName:@"Location"];
    [query whereKey:@"rating" greaterThan:@2.0];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *places, NSError *error) {
        if (places != nil) {
            // do something with the array of object returned by the call
            self.locations = places;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - Map Creation

- (void) setRegion {
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
}

- (void) addLocations:(NSArray *)locations {
    for (Location* place in locations) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(place.lat, place.lon);
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = coordinate;
        annotation.title = place.title;
        annotation.location = place;

        [self.mapView addAnnotation:annotation]; // addAnnotations can be used for multiple annotations at once
        
        NSLog(@"he l l o");
        //[self mapView:self.mapView annotationView:annotationView calloutAccessoryControlTapped: rightButton];
        
    }
}

#pragma mark - MapView delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MKPointAnnotation *)annotation {
    NSLog(@"View for annotation entered");
    MKAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    // annotationView.location = annotation.location;
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        annotationView.canShowCallout = true;
        // annotationView.image = annotation.location.pinImage;
        [annotationView setImage:[UIImage imageNamed:@"icons8-marker-64"]];
        // annotationView.image = [UIImage imageNamed:@"icons8-marker-64"];
        annotationView.calloutOffset = CGPointMake(0, 64);
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
        
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = rightButton;
        //[rightButton addTarget:self action:@selector(rightButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIImageView *imageView = (UIImageView*)annotationView.leftCalloutAccessoryView;
    imageView.image = [UIImage imageNamed:@"MOMA"];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    //id <MKAnnotation> annotation = [view annotation];
    /*if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        NSLog(@"Clicked pin");
    }*/
    NSLog(@"Clicked pin");
    
    MKPointAnnotation *annotation = view.annotation;
    Location *location = annotation.location;
    [self performSegueWithIdentifier:@"segueToDetails" sender:location];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController]
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueToDetails"]) {
//        MKPinAnnotationView *tappedPin = sender;
        
        Location *location = sender;
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.location = location;
    }
}


@end
