" Vim syntax file
" Language:	kOS
" Maintainer:	Steven Mading (madings@gmail.com)
" Last Change:	27 April 2014

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Get rid of any preconcieved notions from leftover default syntax that may be loaded.
syn clear


" Make colons NOT parts of keywords anymore:
setlocal iskeyword=
setlocal iskeyword+=@
setlocal iskeyword+=48-57
setlocal iskeyword+=_

" KOS script is supposed to be case insensitive.  There's
" a few places where it isn't, but they're bugs not intented
" design choices:
syn case ignore

" define keywords:
syn keyword kosCondFlowWord BREAK UNTIL WAIT WHEN THEN IF ON REBOOT SHUTDOWN RUN CALL FOR skipwhite
syn keyword kosCommandWord LOCK UNLOCK SET DECLARE CLEARSCREEN STAGE ON TOGGLE COPY PARAMETER DELETE FROM TO EDIT LIST LOG PRINT AT RENAME FILE VOLUME SWITCH CLEARSCREEN ADD skipwhite
syn keyword kosTODO contained TODO

syn keyword kosBuiltInVariable ABORT AG1 AG10 AG2 AG3 AG4 AG5 AG6 AG7 AG8 AG9 BRAKES CHUTES GEAR LEGS LIGHTS PANELS RCS SAS CONFIG LOADDISTANCE WARP ALT APOAPSIS ERIAPSIS RADAR ANGULARVELOCITY COMMRANGE ENCOUNTER ETA APOAPSIS PERIAPSIS TRANSITION INCOMMRANGE MISSIONTIME NEXTNODE OBT SHIP STAGE STATUS TIME VESSELNAME TARGET HEADING VESSELNAME SESSIONTIME VERSION VOLUME NAME FACING

syn keyword BodyAtmosphereSuffix BODY EXISTS HASOXYGEN SCALE SEALEVELPRESSURE HEIGHT

syn keyword BodyTargetSuffix NAME DESCRIPTION MASS POSITION ALTITUDE APOAPSIS PERIAPSIS RADIUS MU ATM VELOCITY DISTANCE BODY

syn keyword ConfigSuffix IPU UCP STAT RT2 ARCH SAFE

syn keyword ConstantValueSuffix G E PI

syn keyword DirectionSuffix PITCH YAW ROLL VECTOR

syn keyword ElementValueSuffix NAME UID PARTCOUNT RESOURCES

syn keyword FlightControlSuffix YAW PITCH ROLL FORE STARBOARD TOP ROTATION TRANSLATION NEUTRAL MAINTHROTTLE WHEELTHROTTLE WHEELSTEER BOUND NEUTRALIZE

syn keyword GeoCoordinatesSuffix LAT LNG DISTANCE HEADING BEARING

syn keyword ListValueSuffix ADD "CONTAINS" REMOVE LENGTH CLEAR

syn keyword NodeSuffix DELTAV BURNVECTOR ETA PROGRADE RADIALOUT NORMAL ORBIT

syn keyword OrbitSuffix APOAPSIS PERIAPSIS BODY PERIOD INCLINATION ECCENTRICITY SEMIMAJORAXIS SEMIMINORAXIS TRANSITION PATCHES

syn keyword DockingPortValueSuffix STATE ORIENTATION DOCKEDVESSELNAME TARGETABLE

syn keyword EngineValueSuffix ACTIVE THRUSTLIMIT MAXTHRUST THRUST FUELFLOW ISP FLAMEOUT IGNITION ALLOWRESTART ALOWSHUTDOWN THROTTLELOCK THRUSTLIMIT

syn keyword PartValueSuffix CONTROLFROM NAME STAGE UID RESOURCES MODULES TARGETABLE

syn keyword SensorValueSuffix ACTIVE TYPE READOUT

syn keyword ResourceValueSuffix NAME AMOUNT CAPACITY

syn keyword StageValuesSuffix LIQUIDFUEL SOLIDFUEL MONOPROP ELECTRICCHARGE

syn keyword TimespanSuffix YEAR DAY HOUR MINUTE SECOND SECONDS CLOCK CALENDAR

syn keyword VectorSuffix X Y Z MAG VEC NORMALIZED SQRMAGNITUDE

syn keyword VersionInfoSuffix MAJOR MINOR

syn keyword VesselSensorsSuffix ACC PRES TEMP GRAV LIGHT

syn keyword VesselTargetSuffix PACKDISTANCE HEADING PROGRADE RETROGRADE FACING MAXTHRUST VELOCITY GEOPOSITION LATITUDE LONGITUDE UP NORTH BODY ANGULARMOMENTUM ANGULARVEL MASS VERTICALSPEED SURFACESPEED AIRSPEED VESSELNAME ALTITUDE APOAPSIS PERIAPSIS SENSOR SENSORS

syn keyword VesselVelocitySuffix ORBIT SURFACE SURFACEHEADING

syn keyword kosBuiltInFunc BUILDLIST ABS CEILING FLOOR LN LOG10 MAX MIN MOD RANDOM ROUND ROUNDNEAREST SQRT VANG VECTORANGLE VCRS VECTORCROSSPRODUCT VDOT VECTORDOTPRODUCT VXCL VECTOREXCLUDE ADD CLEARSCREEN LOGFILE PRINT PRINTAT REBOOT REMOVE RUN SHUTDOWN STAGE TOGGLEFLYBYWIRE COPY DELETE RENAME SWITCH PRINTLIST BODY BODYATMOSPHERE CONSTANT HEADING LATLNG LIST NODE Q R V VESSEL ARCCOS ARCSIN ARCTAN ARCTAN2 COS SIN TAN

syn cluster kosBuiltInSuffix contains=BodyAtmosphereSuffix,BodyTargetSuffix,ConfigSuffix,ConstantValueSuffix,DirectionSuffix,ElementValueSuffix,FlightControlSuffix,GeoCoordinatesSuffix,ListValueSuffix,NodeSuffix,OrbitSuffix,DockingPortValueSuffix,EngineValueSuffix,PartValueSuffix,SensorValueSuffix,ResourceValueSuffix,StageValuesSuffix,TimespanSuffix,VectorSuffix,VersionInfoSuffix,VesselSensorsSuffix,VesselTargetSuffix,VesselVelocitySuffix

" define regex matches;

syn match kosIdentifier '\<[A-Za-z_][A-Za-z_0-9]*\>'
syn match kosMathOp '\*'
syn match kosMathOp '\^'
syn match kosMathOp '/'
syn match kosMathOp '-'
syn match kosMathOp '+'
syn match kosMathOp '<='
syn match kosMathOp '>='
syn match kosMathOp '<>'
syn match kosMathOp '=='
syn match kosMathOp '='
syn match kosMathOp '<'
syn match kosMathOp '>'
syn match kosMathOp '\<AND\>'
syn match kosMathOp '\<OR\>'
syn match kosSpecialChar '\.'
syn match kosSpecialChar ','
syn match kosSpecialChar ':'
syn match kosDelim '{'
syn match kosDelim '}'
syn match kosDelim '\['
syn match kosDelim '\]'
syn match kosNumber '\d\d*'
syn match kosNumber '\d\d*.\d\d*'
syn match kosComment '//.*$' contains=kosTODO

" define begin/end regions:
syn region kosParenExpr start='(' end=')' fold transparent
syn region kosString start='"' end='"'
syn region kosCodeBlock start='{' end='}' fold transparent
syn region kosArrIndexBlock start='\[' end='\]' fold transparent

" Lastly, assign all those things to standard VIM color groups
" so this will work with any color theme other people make:
let b:current_syntax = "kos"
hi! def link kosCondFlowWord    Keyword
hi! def link kosCommandWord     Statement
hi! def link kosIdentifier      Identifier
hi! def link kosComment         Comment
hi! def link kosTODO            Keyword
hi! def link kosMathOp          Operator
hi! def link kosDelim           Delimiter
hi! def link kosSpecialChar     SpecialChar
hi! def link kosNumber          Number
hi! def link kosString          String
hi! def link kosBuiltInVariable Constant
hi! def link kosBuiltInFunc     Function
hi! def link kosBuiltInSuffix   Constant
hi! def link ksoRTuple          Structure
hi! def link ksoVTuple          Structure
hi! def link ksoQTuple          Structure
hi! def link ksoNODETuple       Structure
