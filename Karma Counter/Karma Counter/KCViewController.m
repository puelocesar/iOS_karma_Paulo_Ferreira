//
//  KCViewController.m
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 13/05/14.
//
//

#import "KCViewController.h"

@interface KCViewController ()

@end

@implementation KCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //before showing the modal input screen, check if it already has a nickname registered
    
    //wait a little to show the modal input
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"nick" sender:self];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
