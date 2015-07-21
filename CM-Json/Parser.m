//
//  Parser.m
//  CM-Json
//
//  Created by Walter Gonzalez Domenzain on 11/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Parser.h"

#define nURLIcon     @"http://openweathermap.org/img/w/" 

@implementation Parser

+ (void)parseWeather:(NSDictionary *)json {
    //check for valid value
    if(json != nil){
        NSDictionary    *main = [json valueForKey: @"main"];
        mstTemp         = [[self kelvinToCelsius:[[main valueForKey: @"temp"] stringValue]] stringByAppendingString:@" °C"];
        mstTempMax      = [[self kelvinToCelsius:[[main valueForKey: @"temp_max"] stringValue]] stringByAppendingString:@" °C"];
        mstTempMin      = [[self kelvinToCelsius:[[main valueForKey: @"temp_min"] stringValue]] stringByAppendingString:@" °C"];
        mstHumidity     = [[[main valueForKey: @"humidity"] stringValue] stringByAppendingString:@" %"];
        mstPressure     = [[[main valueForKey: @"pressure"] stringValue] stringByAppendingString:@" atm"];

        mstImgWeather = [[[json objectForKey:@"weather"] valueForKey:@"icon"] objectAtIndex:0];
        mstImgWeather = [nURLIcon stringByAppendingString:mstImgWeather];
        mstImgWeather = [mstImgWeather stringByAppendingString:@".png"];
    }
}

+ (NSString *)kelvinToCelsius:(NSString *)degrees {
    
    double kelvin = [degrees doubleValue];
    
    double celcius = (kelvin - 273.15);
    
    return [NSString stringWithFormat:@"%4.2f", celcius];
}

@end
