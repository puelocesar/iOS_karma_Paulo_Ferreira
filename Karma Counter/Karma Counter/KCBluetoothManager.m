//
//  KCBluetoothManager.m
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import "KCBluetoothManager.h"

@implementation KCBluetoothManager

KCBluetoothCentral *central;
KCBluetoothPeripheral *peripheral;

-(id)init
{
    central = [[KCBluetoothCentral alloc] init];
    peripheral = [[KCBluetoothPeripheral alloc] init];
    
    return self;
}

- (void)sendKarma
{
    //must define who will receive the karma
    [central send_karma];
}

- (void) setReceiverDelegate: (id <KCBluetoothPeripheralDelegate>) delegate
{
    peripheral.delegate = delegate;
}

@end
