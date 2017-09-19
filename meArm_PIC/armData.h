#ifndef ARMDATA_H_INCLUDED
#define ARMDATA_H_INCLUDED

#ifndef ARM_ID
#error "ARM_ID constant must be defined before include meArm.h file. ex: #define ARM_ID 1"
#endif

#if (ARM_ID < 1 || ARM_ID > 10)
#error "ARM_ID constante must range from 1 to 10."
#endif

#if (ARM_ID == 1)
#define _sweepMinBase 180
#define _sweepMaxBase 10
#define _sweepMinShoulder 120
#define _sweepMaxShoulder 25
#define _sweepMinElbow 180
#define _sweepMaxElbow 135
#define _sweepMinGripper 80
#define _sweepMaxGripper 45
#endif

#if (ARM_ID == 2)
#define _sweepMinBase 180
#define _sweepMaxBase 0
#define _sweepMinShoulder 135
#define _sweepMaxShoulder 45
#define _sweepMinElbow 180
#define _sweepMaxElbow 145
#define _sweepMinGripper 80
#define _sweepMaxGripper 62
#endif


#if (ARM_ID == 3)
#define _sweepMinBase 180
#define _sweepMaxBase 10
#define _sweepMinShoulder 135
#define _sweepMaxShoulder 45
#define _sweepMinElbow 180
#define _sweepMaxElbow 140
#define _sweepMinGripper 110
#define _sweepMaxGripper 70
#endif

#if (ARM_ID == 4)
#define _sweepMinBase 180
#define _sweepMaxBase 10
#define _sweepMinShoulder 120
#define _sweepMaxShoulder 40
#define _sweepMinElbow 180
#define _sweepMaxElbow 145
#define _sweepMinGripper 90
#define _sweepMaxGripper 65
#endif

#if (ARM_ID == 5)
#define _sweepMinBase 180
#define _sweepMaxBase 10
#define _sweepMinShoulder 140
#define _sweepMaxShoulder 45
#define _sweepMinElbow 180
#define _sweepMaxElbow 145
#define _sweepMinGripper 75
#define _sweepMaxGripper 50
#endif

#if (ARM_ID == 6)
#define _sweepMinBase 180
#define _sweepMaxBase 8
#define _sweepMinShoulder 120
#define _sweepMaxShoulder 35
#define _sweepMinElbow 180
#define _sweepMaxElbow 140
#define _sweepMinGripper 80
#define _sweepMaxGripper 56
#endif

#if (ARM_ID == 7)
#define _sweepMinBase 180
#define _sweepMaxBase 10
#define _sweepMinShoulder 135
#define _sweepMaxShoulder 45
#define _sweepMinElbow 180
#define _sweepMaxElbow 135
#define _sweepMinGripper 80
#define _sweepMaxGripper 55
#endif

#if (ARM_ID == 8)
#define _sweepMinBase 175
#define _sweepMaxBase 1
#define _sweepMinShoulder 135
#define _sweepMaxShoulder 45
#define _sweepMinElbow 170
#define _sweepMaxElbow 135
#define _sweepMinGripper 70
#define _sweepMaxGripper 35
#endif

#if (ARM_ID == 9)
#define _sweepMinBase 180
#define _sweepMaxBase 10
#define _sweepMinShoulder 150
#define _sweepMaxShoulder 45
#define _sweepMinElbow 180
#define _sweepMaxElbow 145
#define _sweepMinGripper 130
#define _sweepMaxGripper 103
#endif

#if (ARM_ID == 10)
#define _sweepMinBase 180
#define _sweepMaxBase 15
#define _sweepMinShoulder 130
#define _sweepMaxShoulder 50
#define _sweepMinElbow 180
#define _sweepMaxElbow 140
#define _sweepMinGripper 20
#define _sweepMaxGripper 5
#endif
char armData[8]={_sweepMinBase,_sweepMaxBase,
                 _sweepMinShoulder,_sweepMaxShoulder,
                 _sweepMinElbow,_sweepMaxElbow,
                 _sweepMinGripper,_sweepMaxGripper};



#endif // ARMDATA_H_INCLUDED