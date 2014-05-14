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
    [central sendKarma];
}

- (void) setReceiveKarmaDelegate: (id <KCBluetoothPeripheralDelegate>) delegate
{
    peripheral.delegate = delegate;
}

- (void) setRegisteredDevicesDelegate: (id <KCBluetoothCentralDelegate>) delegate
{
    central.delegate = delegate;
}

@end
