# Lighting Module

The lighting module is for all exterior lights on your rolling stock. It includes general lights such as headlights and
taillights, as well as more specific lights like fog lights and ditch lights.

## Features

### Headlights

For lighting up the track in front of the train and indicating direction of travel.

```
UI In
  Enable: B01

UI Out
  Front: B02
  Rear:  B10
```

The headlights will be enabled on the frontmost side of the frontmost car (to the
direction of travel). If `Running Light Behavior` is set to *Use Headlights as Running Lights*, the headlights will be
enabled with a signal from `B01` or `Running Lights`, which is how TCP 1.3 responds to a 1.4 master enabling running
lights

If `Fog Light Behavior` is set to *Disable Headlights* or *Disable Running Lights*, the
headlights will be disabled if `Fog Lights` are enabled.

### Taillights

For indicating the rear of the train.

```
UI Out
  Front: B03
  Rear:  B11
```

If `Taillight Behavior` is set to *On with Running Lights*, the taillights will be enabled with `Running Lights`,
otherwise they will be enabled with a signal from `Headlights`. The taillights will only be enabled on the rearmost side
of the rearmost car.

### Running Lights

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
