//
//  MovieController.m
//  MovieSearch
//
//  Created by Nick Reichard on 3/10/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

// Should have done NLRController!!

#import "MovieController.h"
#import "Movie.h"

@implementation MovieController

+ (MovieController *)shared {
    static MovieController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [MovieController new];
    });
    return shared;
}

+ (void)fetchMovieInformationFromAPIWithTitle:(NSString *)title completion:(void (^)(NSArray *movies))completion
{
    NSString *baseURLString =  @"https://api.themoviedb.org/3/search/movie";
    NSString *apiKey = @"3e6fc78d34ea9b6595d61441a091daf9";  // Is this better than p-list?
    
    NSURL *baseURL = [[NSURL alloc]initWithString:baseURLString]; // UTF-8 encoding???
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    // The way we want it to be formated. Like the datestyle in journal
    NSURLQueryItem *apiKeyItme = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    
    NSURLQueryItem *movieItem = [NSURLQueryItem queryItemWithName:@"query" value:title];
    
    urlComponents.queryItems = @[apiKeyItme, movieItem];
    
    NSURL *moviePhotoInformationEndpoint = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:moviePhotoInformationEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)  {
            NSLog(@"Error: %@", error);
            completion(nil);
            return;
        }
        if (!data)  {
            NSLog(@"Error: No data returned from data task");
            completion(nil);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *movieArray = jsonDictionary[@"results"];
        
        // creating a mutable array
        NSMutableArray *movies = [[NSMutableArray alloc]init]; // how you initailize
        
        for(NSDictionary *dict in movieArray) {
            Movie *movie = [[Movie alloc]initWithDictionary:dict];
            
            [movies addObject:movie]; // This is the array of everything you need
        }
        
        if (!jsonDictionary) {
            NSLog(@"Error: could not sterelize data");
            completion(nil);
            return;
        }
        
        // Why???
        NSString *errorString = jsonDictionary[@"error"];
        
        if (errorString) {
            NSLog(@"%@", errorString);
            completion(nil);
            return;
        }
        
        completion(movies);
    }] resume];
}

+ (void)fetchMoviePosterImageWithURL:(NSString *)urlString completion:(void (^)(UIImage *))completion
{
    // Within NSURLSession, there are things called data tasks. Data tasks are a task for retriving the contents of a URL as an NSData object
    NSURL *posterURL = [NSURL URLWithString:urlString];
    
    // // @"https://image.tmdb.org/t/p/w500/";
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:posterURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error loadingimage: %@", error);
            completion(nil);
            return;
        }
        if (!data) {
            NSLog(@"Error: Not data return from data task for image");
            completion(nil);
            return;
        }
        UIImage *posterImage = [[UIImage alloc] initWithData:data];
        
        completion(posterImage);
        
    }] resume];
}

+ (NSString *)fetchAPIKeyFromPlist
{
    
    // Get the url of the plist
    NSURL *apiKeyPlistURL = [[NSBundle mainBundle] URLForResource:@"APIKeys" withExtension:@"plist"];
    // Initialize a new object (usually a dictionary) from the contents of that url
    
    NSDictionary *apiKeys = [[NSDictionary alloc] initWithContentsOfURL:apiKeyPlistURL];
    
    NSString *apiKey = apiKeys[@"APIKeys"];
    
    return apiKey;
    
}

@end
