//
//  ViewController.m
//  CM-Json
//
//  Created by Walter Gonzalez Domenzain on 11/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Start.h"

@interface Start ()


@end

@implementation Start

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager                 = [[CLLocationManager alloc] init];
    self.locationManager.delegate        = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    mstTemp      = [[NSString alloc] init];
    mstTempMax   = [[NSString alloc] init];
    mstTempMin   = [[NSString alloc] init];
    mstPressure  = [[NSString alloc] init];
    mstHumidity  = [[NSString alloc] init];
    mstLatitude  = [[NSString alloc] init];
    mstLongitude = [[NSString alloc] init];
    
    [self initData];
    [self initController];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
    NSDictionary *jsonResponse = [Declarations getWeather:[mstLatitude floatValue] and:[mstLongitude floatValue]];
    [Parser parseWeather:jsonResponse];
    
    print(NSLog(@"msImgWeather = %@", mstImgWeather))
    print(NSLog(@"mstTemp = %@", mstTemp))
    print(NSLog(@"mstTempMax = %@", mstTempMax))
    print(NSLog(@"mstTempMin = %@", mstTempMin))
    print(NSLog(@"mstPressure = %@", mstPressure))
    print(NSLog(@"mstHumidity = %@", mstHumidity))
    
    self.lblTemp.text       = mstTemp;
    self.lblMax.text        = mstTempMax;
    self.lblMin.text        = mstTempMin;
    self.lblPressure.text   = mstPressure;
    self.lblHumidity.text   = mstHumidity;
}

- (void)initController {
}

- (IBAction)btnRefrsehPressed:(id)sender {
    NSDictionary *jsonResponse = [Declarations getWeather:[mstLatitude floatValue] and:[mstLongitude floatValue]];
    [Parser parseWeather:jsonResponse];
    
    self.lblTemp.text       = mstTemp;
    self.lblMax.text        = mstTempMax;
    self.lblMin.text        = mstTempMin;
    self.lblPressure.text   = mstPressure;
    self.lblHumidity.text   = mstHumidity;
}

#pragma mark - CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *crnLoc = [locations lastObject];
    mstLatitude = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
    mstLongitude = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
    
    self.lblLatitude.text   = mstLatitude;
    self.lblLongitude.text  = mstLongitude;
}

@end
