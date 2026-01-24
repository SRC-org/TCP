# Lighting Module

The lighting module is for all exterior lights on your rolling stock. It includes general lights such as headlights and
taillights, as well as more specific lights like fog lights and ditch lights.

# Lights

## Headlights

For lighting up the track in front of the train and indicating direction of travel.

```
UI In
  Enable: B01

UI Out
  Front: B02
  Rear:  B10
```

The headlights will be enabled on the frontmost side of the frontmost car. If `Running Light Behavior` is set to *Use Headlights as Running Lights*, the headlights will be
enabled with a signal from `B01` or `Running Lights`, which is how TCP 1.3 responds to a 1.4 master enabling running
lights

If `Fog Light Behavior` is set to *Disable Headlights* or *Disable Running Lights*, the
headlights will be disabled if `Fog Lights` are enabled.

## Taillights

For indicating the rear of the train.

```
UI Out
  Front: B03
  Rear:  B11
```

If `Taillight Behavior` is set to *On with Running Lights*, the taillights will be enabled with `Running Lights`,
otherwise they will be enabled with a signal from `Headlights`. The taillights will only be enabled on the rearmost side
of the rearmost car.

## Running Lights

For indicating the train is active.

```
UI In
  Enable: B03
  
UI Out
  Front:  B01
  Rear:   B09
  Global: B17
```

If `Automatic Running Lights` is set to *On with Master*, running lights will be enabled while this car has master. When
running lights are enabled, they will be displayed on both the front of the frontmost car and any cars that use
global running lights. If `Running Light Behavior` is set to *Running Lights off with Headlights*, the running lights
will be disabled when the headlights are enabled. If `Running Light Behavior` is set to *Use Headlights as Running
Lights*, the running lights will never turn on and `Headlights` will be used instead.

## High Beams

For lighting up the track in front of the train for longer distances.

```
UI In
  Enable: B02
  
UI Out
  Front: B04
  Rear:  B12
```

If `Headlights` are enabled, high beams will be enabled when triggered. Otherwise, the input signal is ignored.

## Fog Lights

For lighting up the track in low-visibility scenarios and indicating the train is active to all surrounding vehicles.

```
UI In
  Enable: B04
  
UI Out
  Front:  B05
  Rear:   B13
  Global: B18
```

If fog lights are enabled and `Fog Light Behavior` is set to *Disable High Beams*, it will disable the high beams. 
Otherwise, if it's set to *Disable Headlights* it will disable both the headlights and high beams, and likewise if it's
set to *Disable Running Lights* it will disable the running lights, headlights, and high beams. If it's set to *Enable
All Lights* it won't affect any other lights.

## Ditch Lights

For lighting up the sides of the track, warning of train presence, and indicating the train is active.

```
UI In
  Enable: B05
  
UI Out
  Front: B06
  Rear:  B14
```

Ditch lights will be enabled on the frontmost side of the frontmost car. Any flashing behavior must be implemented
by the Extender.

## Work Lights

For lighting up work areas.

```
UI In
  Enable: B06
  
UI Out
  Global: B20
```

Work lights will be enabled on any cars that use global work lights.

## Warning Lights

For warning personnel and vehicles near the train.

```
UI In
  Enable: B07
  
UI Out
  Front:  B08
  Rear:   B16
  Global: B19
```

Warning lights will be enabled on the frontmost side of the frontmost car as well as any cars that use global warning
lights. Any flashing behavior must be implemented by the Extender

## Deco Lights

For any decorative or non-functional lights, such as logo lights.

```
UI In
  Enable: B08
  
UI Out
  Global: B21
```

Deco lights will be enabled on any cars that use global deco lights.

## Flashing Light Signal

For enabling the flashing of any front or rear lights, such as flashing ditch lights.

```
UI In
  Enable: B09
  
UI Out
  Global: B22
```

For use by Extender developers only. Should not be displayed to the end user directly.

## Reverse Lights & Mode

For indicating train reverse.

```
UI In
  Enable: B10
  
UI Out
  Front: B07
  Rear:  B15
```

If `Reversing Light Mode` is set to *Invert Lights*, the front and rear lights will be swapped as if the train was 
flipped or the master was inverted. If it's set to *Head and Tail Lights on Both Ends*, front and rear lights will be
displayed on both ends of the train. If it's set to *Reverse Lights*, the head and tail lights will remain the same but
the dedicated reverse lights will be displayed on the rear end of the rearmost car. If it's set to *No Change*, no
lights will be affected.

This system is intended for use in combination with a negative target speed or throttle,
if you invert the master to reverse this system will not be triggered and should not be triggered manually.

## Parking Mode

For indicating the train is parked.

```
UI In
  Enable: B11
```

If `Parking Light Mode` is set to *Taillights on Both Ends*, the front lights will be disabled and the rear lights
will be displayed on both ends of the train. If it's set to *Headlights on Both Ends*, the rear lights will be disabled 
and front lights will be displayed on both ends of the train. If it's set to *Head and Tail Lights on Both Ends*, front
and rear lights will be displayed on both ends. Otherwise if it's set to *No Change*, no lights will be affected.

## Shunting Mode

For indicating the train is shunting and may switch directions rapidly.

```
UI In
  Enable: B11
```

If `Shunting Light Mode` is set to *Headlights on Both Ends*, the rear lights will be disabled and front lights will be 
displayed on both ends of the train. If it's set to *Head and Tail Lights on Both Ends*, front and rear lights will be 
displayed on both ends. Otherwise if it's set to *No Change*, no lights will be affected.
