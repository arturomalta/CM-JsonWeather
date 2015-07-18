//
//  Parser.m
//  CM-Json
//
//  Created by Walter Gonzalez Domenzain on 11/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Parser.h"

@implementation Parser

+ (void)parseWeather:(NSDictionary *)json {
    //check for valid value
    if(json != nil){
        NSDictionary    *main = [json valueForKey: @"main"];
        mstTemp         = [[Parser kelvinToCelsius:[[main valueForKey: @"temp"] stringValue]] stringByAppendingString:@" °C"];
        mstTempMax      = [[Parser kelvinToCelsius:[[main valueForKey: @"temp_max"] stringValue]] stringByAppendingString:@" °C"];
        mstTempMin      = [[Parser kelvinToCelsius:[[main valueForKey: @"temp_min"] stringValue]] stringByAppendingString:@" °C"];
        mstHumidity     = [[main valueForKey: @"humidity"] stringValue];
        mstPressure     = [[main valueForKey: @"pressure"] stringValue];
        
        NSDictionary *weather = [json valueForKey:@"weather"];
        mstImgWeather   = [weather valueForKey:@"icon"];
    }
}

+ (NSString *)kelvinToCelsius:(NSString *)degrees {
    
    double kelvin = [degrees doubleValue];
    
    double celcius = (kelvin - 273.15);
    
    return [NSString stringWithFormat:@"%4.2f", celcius];
}

@end
