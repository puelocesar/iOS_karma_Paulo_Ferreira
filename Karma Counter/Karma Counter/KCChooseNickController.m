//
//  KCChooseNickController.m
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 13/05/14.
//
//

#import "KCChooseNickController.h"

@interface KCChooseNickController ()

@end

@implementation KCChooseNickController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.nick_field becomeFirstResponder];
    self.nick_field.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //verify for length of string before saving
    [self.delegate didSaveNick:self];
    return YES;
}

@end
