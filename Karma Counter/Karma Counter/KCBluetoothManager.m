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

- (void)sendKarmaWithPeripheral: (CBPeripheral*) peripheral
{
    [central sendKarmaWithPeripheral:peripheral];
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
