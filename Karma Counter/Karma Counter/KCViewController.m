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

KCBluetoothManager* bluetoothManager;
NSMutableArray* avatars;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self get_saved_nick];
    
    if (self.nickname == nil) {
        //wait a little to show the modal input
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"nick" sender:self];
        });
    }
    
    bluetoothManager = [[KCBluetoothManager alloc] init];
    [bluetoothManager setReceiveKarmaDelegate:self];
    [bluetoothManager setRegisteredDevicesDelegate:self];
    
    avatars = [[NSMutableArray alloc] init];
}

- (void) get_saved_nick
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    self.nickname = [defaults stringForKey:@"nick"];
}

- (void) setNickname:(NSString *)nickname
{
    _nickname = nickname;
    self.nickname_label.text = nickname;
}

- (void) setKarma:(int)karma
{
    _karma = karma;
    self.karma_value.text = [NSString stringWithFormat:@"%d", karma];
}

/* navigation */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"nick"]) {
        KCChooseNickController *nickController = segue.destinationViewController;
        nickController.delegate = self;
    }
}

- (void)didSaveNick:(KCChooseNickController *)controller
{
    self.nickname = controller.nick_field.text;
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.nickname forKey:@"nick"];
    [defaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)sendKarma:(id)sender
{
    [bluetoothManager sendKarma];
}

- (void)didReceiveKarma
{
    self.karma = self.karma+1;
}

- (void)registeredNewPeripheral:(KCAvatarData *)data
{
    KCAvatarView* avatar_view = [[KCAvatarView alloc] initWithFrame:CGRectMake(135, 110, 50, 60)];
    avatar_view.data = data;
    [self.view addSubview:avatar_view];
    
    [avatars addObject:avatar_view];
}

- (void)removedPeripheral:(NSString *)did
{
    for (KCAvatarView* view in avatars) {
        if ([view.data.did isEqualToString:did])
            [view removeFromSuperview];
    }
}

@end