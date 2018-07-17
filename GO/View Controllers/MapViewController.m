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
    
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    
    //[self fetchLocations];
    self.locations = [NSArray arrayWithObjects:[Location createLocation], nil];
    [self addLocations:self.locations];
    // [Location postLocation:nil];
    
}

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

#pragma mark - Action (unused)

- (void)rightButtonTapped
{
    NSLog(@"HELLO");
}

#pragma mark - MapView delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    NSLog(@"View for annotation entered");
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        annotationView.canShowCallout = true;
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
        
        // MKAnnotationView *annotationView = [self mapView:self.mapView viewForAnnotation:annotation];
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
    
    [self performSegueWithIdentifier:@"segueToDetails" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController]
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueToDetails"]) {
        MKPointAnnotation *tappedPin = sender;
        
        Location *location = tappedPin.location;
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        
        detailsViewController.location = location;
    }
}


@end
