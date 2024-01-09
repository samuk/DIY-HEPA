/* Customizable air filter for circular HEPA filters Version 1.0

   Based on talk by Timo Osterkamp and Magnus Schieder 29.12.2020 at #rc3: https://media.ccc.de/v/rc3-583039-luftfilter_bauen https://github.com/CTreffOS/air-filter
   
   In contrast to the originally proposed design, this model is just plugged onto the filter, uses standard fan screws, and has an air duct for better ventilation and finger protection.
   
   This software is licensed under the MIT license and CC BY-SA (see https://creativecommons.org/ for details).
   
   Copyright 2021 Sebastian Ritterbusch

   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
   
  Changelog:
    1.0   - 16.05.2021 - First public release
    1.1   - 19.05.2021 - Slanted filter connection walls
    1.2   - 22.05.2021 - Air-duct linear volume balancing
    1.2.1 - 18.06.2021 - Optional fan lock screw for the air guide 

*/
   

/* [Object selection] */

// Generate filter-fan adapter
topLid    = false;

// Generate bottom closing
bottomLid = false;

// Generate air duct
upperDuct = true;

// Use less material but needs support for printing 
minimal   = false;

/* [Filter specification] */

// MEDION MD19: baseDiameter: 185, innerCircleWidth: 112, outerWallHeight:  9, (filterAreaHeight: 107)
// TCL     A1F: baseDiameter: 170, innerCircleWidth: 109, outerWallHeight: 12, (filterAreaHeight: 140)
//      SY-702: baseDiameter: 103, innerCircleWidth:  68, outerWallHeight:  8, (filterAreaHeight: 82)

// Filter base diameter [mm]
baseDiameter = 103;

// Filter inner opening diameter [mm]
innerCircleWidth = 68;

// Height of outer filter edge for cover [mm]
outerWallHeight = 8;


/* [Fan specification] */

// AP18x:    fanWidth: 180, modifyScrewDistance: 165, fanLockScrew: 26
// A14-2/3k: fanWidth: 140, modifyScrewDistance: 0,   fanLockScrew: 21
// MEC0381:  fanWidth: 120, modifyScrewDistance: 0,   fanLockScrew: 34

// Outer fan enclosure width dimension (typical 200/140/120/92) [mm]
fanWidth       = 120;

// Smallest width of enclosure towards fan blade [mm]
fanBorder      = 2;

// Height below upper horizontal layer of fan, or 0 to disable the fan lock screw [mm] 
fanLockScrew   = 31;

// Minimal adapter cone height [mm]
minConeHeight     = 12.5;

// Maximal overhang degrees [°]
maxOverhangDegree = 45;


coneHeight = max(minConeHeight,
                 (baseDiameter/2-sqrt(2)/2*fanWidth)/tan(maxOverhangDegree),
                 (baseDiameter/2-fanWidth/2)/tan(maxOverhangDegree),
                 (fanWidth/2-innerCircleWidth/2)/tan(maxOverhangDegree));
                
// Additional plane bottom layer under fan [mm]
fanBoxBottom   = 1;

// Optional enclosing fan box height [mm]
fanHeight      = 0;

// Modify fan screw hole spacing (0 for default for fan size) [mm]
modifyFanScrewDistance = 0;

/// See https://en.wikipedia.org/wiki/Computer_fan#Dimensions
fanScrewDistance = ( modifyFanScrewDistance != 0 ) ? modifyFanScrewDistance :
    ( fanWidth >= 220 ) ? fanWidth * 170 / 220 :
    ( fanWidth >= 200 ) ? (fanWidth * 170 / 220) * ( fanWidth - 200 ) / (220-200)
                         + (fanWidth * 154 / 200) * ( 220 - fanWidth ) / (220-200) :
    ( fanWidth >= 140 ) ? (fanWidth * 154 / 200) * ( fanWidth - 140 ) / (200-140)
                         + (fanWidth * 124.5 / 140) * ( 200 - fanWidth ) / (200-140) :
    ( fanWidth >= 120 ) ? (fanWidth * 124.5 / 140) * ( fanWidth - 120 ) / (140-120)
                         + (fanWidth * 105 / 120) * ( 140 - fanWidth ) / (140-120) :
    ( fanWidth >= 92 )  ? (fanWidth * 105 / 120) * ( fanWidth - 105 ) / (120-105)
                         + (fanWidth * 82.5 / 92) * ( 120 - fanWidth ) / (120-105) :
    ( fanWidth >= 80 )  ? (fanWidth * 82.5 / 92) * ( fanWidth - 80 ) / (92-80)
                         + (fanWidth * 71.5 / 80) * ( 92 - fanWidth ) / (92-80) :
    ( fanWidth >= 70 )  ? (fanWidth * 71.5 / 80) * ( fanWidth - 70 ) / (80-70)
                         + (fanWidth * 60 / 70) * ( 80 - fanWidth ) / (80-70) :
    ( fanWidth >= 50 ) ? fanWidth - 10 : fanWidth * 32 / 40;

echo("Screw distance: ",fanScrewDistance);

// Fan screw hole diameter [mm]
fanScrewDiameter = 4.7;

// Fan screw hole depth [mm]
fanScrewDepth    = 5;


/* [Air duct specification] */

// Height of air duct [mm]
airDuctHeight = 80;

// Main walls height [mm]
airDuctMainWallHeight = 30;

// Minor walls height [mm]
airDuctMinorWallHeight = 1.0;

// Fan clearance [mm]
airDuctFanExtra = 0.5;

// Air duct fan cable opening width [mm]
airDuctCableOpeningWidth = 5;

// Air duct fan cable opening height [mm]
airDuctCableOpeningHeight = 10;

// Air duct fan cable opening distance from edge [mm]
airDuctCableOpeningEdgeDistance = 5;

// Air duct volume balancing
airDuctVolumeBalancing = true;

/* [Other settings] */

// General width of walls [mm]
wallWidth = 1.5;

innerWallWidth = wallWidth;

airDuctWallWidth = wallWidth;
airDuctMainWallWidth = wallWidth/2;
airDuctMinorWallWidth = wallWidth/3;

// Assumed print line width for clearance [mm]
printLineWidth = 0.2;

//Rendering smoothness
$fn=180;

// Height of optional inner filter rim [mm]
innerRimHeight = 0; // 3
// Width of optional inner filter rim [mm]
innerRimWidth =  0; // 10
// Disctacnce of optional inner filter rim to inner opening [mm]
innerRimOutDistance = 17; // 17

// Width of optional fan holding clips [mm]
holdClipWidth  = 0;
// Height of optional fan holding clips [mm] 
holdClipHeight = 0 ;
// Depth of option fan holding clips [mm]
holdClipDepth  = 0 ;



baseDiameterCleared = baseDiameter + printLineWidth/2;

bottomWidth = wallWidth*1;
outerWallWidth = wallWidth;


module lid(closed = true)
{
    translate([0,0,bottomWidth])
    union ()
    {
        difference() {
            cylinder( h = innerRimHeight , d = baseDiameterCleared - innerRimOutDistance*2 );
            translate([0,0,-0.5]) cylinder( h = innerRimHeight + 1 , d = baseDiameterCleared - innerRimOutDistance*2 - innerRimWidth*2 );
        }
        
        if(closed)
        {
            cylinder( h = innerRimHeight , d = innerCircleWidth );
        }

        difference() {
            
            translate([0,0,-bottomWidth]) cylinder( h = bottomWidth + outerWallHeight + holdClipHeight , d1 = baseDiameterCleared + outerWallWidth * 2 , d2 = baseDiameterCleared + outerWallWidth * 2+printLineWidth );

            cylinder( h = outerWallHeight + holdClipHeight + 1 , d1 = baseDiameterCleared , d2 = baseDiameterCleared+printLineWidth );
            
            if ( closed == false )
            {
                translate([0,0,-bottomWidth-1]) cylinder( h = bottomWidth+2 , d = innerCircleWidth );

            }
        }
        
        translate([0,0,outerWallHeight])
        difference () 
        {
            intersection() {
                union ()
                {
                    cube([baseDiameterCleared+outerWallWidth * 2,holdClipWidth,holdClipHeight * 2],center = true);
                    cube([holdClipWidth,baseDiameterCleared+outerWallWidth * 2,holdClipHeight * 2],center = true);
                    
                }
                cylinder( h = holdClipHeight , d = baseDiameterCleared + outerWallWidth * 2 );
            }
            translate([0,0,-0.5]) cylinder( h = holdClipHeight + 1 , d = baseDiameterCleared - holdClipDepth * 2 );
        }
        
        
        
    }
}

module cone(minimal = true)
{
    difference()
    {
        union()
        {
            difference() 
            {
                if ( minimal )
                {
                    cylinder( h = coneHeight, d1 = innerCircleWidth + innerWallWidth * 2, d2 = fanWidth );
                } else
                {
                    union() {
                        cylinder( h = coneHeight, d1 = innerCircleWidth + innerWallWidth * 2, d2 = fanWidth );

                        intersection()
                        {
                            cylinder( h = coneHeight - fanBoxBottom, d1 = baseDiameterCleared + innerWallWidth * 2 , d2 = ( fanWidth + outerWallWidth*2) * sqrt(2) );
                            translate([0,0,coneHeight/2]) cube([fanWidth+outerWallWidth*2,fanWidth+outerWallWidth*2,coneHeight],center=true);
                        }
                        cylinder ( h = coneHeight-fanBoxBottom, d1 = baseDiameterCleared + outerWallWidth * 2, d2 = fanWidth + outerWallWidth *2);

                    }
                }
                translate([0,0,-0.05]) cylinder( h = coneHeight + 0.1 , d1 = innerCircleWidth , d2 = fanWidth - fanBorder*2 );
                
                
                
            }

            difference()
            {
                translate([0,0,coneHeight - fanBoxBottom/2]) cube([fanWidth,fanWidth,fanBoxBottom],center=true);
                translate([0,0,-0.05]) cylinder( h = coneHeight + 0.1 , d1 = innerCircleWidth , d2 = fanWidth - fanBorder );

            }
            difference()
            {
                translate([0,0,coneHeight + fanHeight / 2 - fanBoxBottom / 2 + holdClipHeight/2]) cube([fanWidth + outerWallWidth*2,fanWidth + outerWallWidth * 2,fanHeight + fanBoxBottom+holdClipHeight ],center=true);
                translate([0,0,coneHeight + fanHeight / 2 - fanBoxBottom / 2 +holdClipHeight/2]) cube([fanWidth ,fanWidth ,fanHeight+fanBoxBottom+holdClipHeight+0.1],center=true);
                
                
            }
            difference() 
            {
                union ()
                {
                    translate([0,0,coneHeight + fanHeight + holdClipHeight/2]) cube([fanWidth+outerWallWidth * 2,holdClipWidth,holdClipHeight],center = true);
                    translate([0,0,coneHeight + fanHeight + holdClipHeight/2]) cube([holdClipWidth,fanWidth+outerWallWidth * 2,holdClipHeight],center = true);
                    
                }
                translate([0,0,coneHeight + fanHeight +holdClipHeight/2- 0.1]) cube([fanWidth-holdClipDepth*2,fanWidth-holdClipDepth*2,holdClipHeight+0.3], center=true);
                
                
            }
        }
                
        translate([fanScrewDistance/2,fanScrewDistance/2,coneHeight - fanScrewDepth]) cylinder( h = fanScrewDepth+0.1,d=fanScrewDiameter);
        translate([-fanScrewDistance/2,fanScrewDistance/2,coneHeight - fanScrewDepth]) cylinder( h = fanScrewDepth+0.1,d=fanScrewDiameter);
        translate([fanScrewDistance/2,-fanScrewDistance/2,coneHeight - fanScrewDepth]) cylinder( h = fanScrewDepth+0.1,d=fanScrewDiameter);
        translate([-fanScrewDistance/2,-fanScrewDistance/2,coneHeight - fanScrewDepth]) cylinder( h = fanScrewDepth+0.1,d=fanScrewDiameter);

    }

    
    
}

module airDuct()
{
    difference()
    {
        union()
        {
            translate([0,0,airDuctHeight/2]) 
                cube([fanWidth+airDuctFanExtra*2+airDuctWallWidth*2,fanWidth+airDuctFanExtra*2+airDuctWallWidth*2,airDuctHeight],center=true);

            if(fanLockScrew>0)
                union()
                {
                    translate([fanWidth/2 - airDuctCableOpeningEdgeDistance - fanScrewDiameter/2,fanWidth/2 + airDuctWallWidth,airDuctHeight - fanLockScrew + fanScrewDiameter/2])
                        rotate([90,0,0])
                            cylinder(airDuctWallWidth*5,d1 = (fanScrewDiameter+4) , d2 = (fanScrewDiameter+4) * 2 , center = true);
                    translate([-(fanWidth/2 - airDuctCableOpeningEdgeDistance - fanScrewDiameter/2),-(fanWidth/2 + airDuctWallWidth),airDuctHeight - fanLockScrew + fanScrewDiameter/2])
                        rotate([90,0,0])
                            cylinder(airDuctWallWidth*5,d1 = (fanScrewDiameter+4)*2, d2 = (fanScrewDiameter+4), center = true);
                }
        }
        translate([0,0,airDuctHeight/2+0.5]) 
            cube([fanWidth+airDuctFanExtra*2,fanWidth+airDuctFanExtra*2,airDuctHeight+2],center=true);
        translate([ fanWidth/2 + airDuctWallWidth , fanWidth/2 - airDuctCableOpeningEdgeDistance - airDuctCableOpeningWidth/2  , airDuctHeight - airDuctCableOpeningHeight / 2])
            cube([airDuctWallWidth*2 , airDuctCableOpeningWidth ,airDuctCableOpeningHeight+1],center=true);
        
        if(fanLockScrew>0)
            union()
            {
                translate([fanWidth/2 - airDuctCableOpeningEdgeDistance - fanScrewDiameter/2,fanWidth/2 + airDuctWallWidth,airDuctHeight - fanLockScrew + fanScrewDiameter/2])
                    rotate([90,0,0])
                        cylinder(airDuctWallWidth*6,d = fanScrewDiameter, center = true);
                translate([fanWidth/2 - airDuctCableOpeningEdgeDistance - fanScrewDiameter/2,fanWidth/2 + airDuctWallWidth,airDuctHeight - fanLockScrew + fanScrewDiameter/2])
                    rotate([90,0,0])
                        cylinder(airDuctWallWidth*5.1,d1 = fanScrewDiameter*1.4, d2 = 0, center = true);
                translate([-(fanWidth/2 - airDuctCableOpeningEdgeDistance - fanScrewDiameter/2),-(fanWidth/2 + airDuctWallWidth),airDuctHeight - fanLockScrew + fanScrewDiameter/2])
                    rotate([90,0,0])
                        cylinder(airDuctWallWidth*6,d = fanScrewDiameter, center = true);
                translate([-(fanWidth/2 - airDuctCableOpeningEdgeDistance - fanScrewDiameter/2),-(fanWidth/2 + airDuctWallWidth),airDuctHeight - fanLockScrew + fanScrewDiameter/2])
                    rotate([90,0,0])
                        cylinder(airDuctWallWidth*5.1,d1 = 0, d2 = fanScrewDiameter*1.4, center = true);
            }
    }
    
    
    total     = fanWidth + airDuctFanExtra * 2;
    maxOrder  = 4;
    maxWidth  = airDuctMainWallWidth;
    minWidth  = airDuctMinorWallWidth;
    maxHeight = airDuctMainWallHeight;
    
    for ( order = [1:maxOrder] )
    {
        count  = pow(2,order-1);
        step   = total / (count*2);
        width  = maxWidth - (maxWidth - minWidth) * (order - 1) / (maxOrder - 1 );
        height = maxHeight / count;
        
        if(count == 1)
        {
            translate([0,0,height/2])
                cube([total+airDuctMainWallWidth,width,height],center=true);
            translate([0,0,height/2])
                cube([width,total+airDuctMainWallWidth,height],center=true);  
        } else
        {
            for ( pos = [ -(count-1) : 2 : (count-1) ] )
            {
                low =  0.4*3/4 ; // 0.25
                high = 0.4*3/4 ; // 0.5
                a1 = airDuctVolumeBalancing ? (pos < 0 ? -low : high ) : 0;
                translate([(total+airDuctMainWallWidth)/4,step*pos,height/2])
                    multmatrix(m = [ [         1,           0, 0,  0],
                                    [         0,           1, a1, a1*height/width/4],
                                    [         0,           0, 1,  0],
                                    [         0,           0, 0,  1]
                                    ]) 
                    cube([(total+airDuctMainWallWidth)/2,width,height],center=true);
                a2 = airDuctVolumeBalancing ? (pos < 0 ? -high : low ) : 0;
                translate([-(total+airDuctMainWallWidth)/4,step*pos,height/2])
                    multmatrix(m = [ [         1,           0, 0,  0],
                                    [         0,           1, a2, a2*height/width/4],
                                    [         0,           0, 1,  0],
                                    [         0,           0, 0,  1]
                                    ]) 
                    cube([(total+airDuctMainWallWidth)/2,width,height],center=true);
                b1 = airDuctVolumeBalancing ? (pos < 0 ? -high : low) : 0; 
                translate([step*pos,(total+airDuctMainWallWidth)/4,height/2])
                    multmatrix(m = [ [         1,           0, b1,  b1*height/width/4],
                                     [         0,           1, 0,  0],
                                     [         0,           0, 1,  0],
                                     [         0,           0, 0,  1]
                                    ])
                    cube([width,(total+airDuctMainWallWidth)/2,height],center=true);  
                b2 = airDuctVolumeBalancing ? (pos < 0 ? -low : high) : 0;
                translate([step*pos,-(total+airDuctMainWallWidth)/4,height/2])
                    multmatrix(m = [ [         1,           0, b2,  b2*height/width/4],
                                     [         0,           1, 0,  0],
                                     [         0,           0, 1,  0],
                                     [         0,           0, 0,  1]
                                    ])
                    cube([width,(total+airDuctMainWallWidth)/2,height],center=true);  
                

            }
        }
    }
    
    
}

if(topLid)
{   
    translate([0,0,coneHeight+fanHeight])
    scale([1,1,-1])
    union ()
    {
        scale([1,1,-1]) lid(false);
        cone(minimal);
    }
    if(bottomLid)
        translate([max(baseDiameterCleared,fanWidth)+outerWallWidth*2+10,0,0]) lid(true);
    if(upperDuct)
        translate([-max(baseDiameterCleared,fanWidth)-outerWallWidth*2-10,0,0]) airDuct();
} else 
if(upperDuct)
{
    airDuct();
    
    if(bottomLid)
        translate([max(baseDiameterCleared,fanWidth)+outerWallWidth*2+10,0,0]) lid(true);
} else
if(bottomLid)
    lid(true);
