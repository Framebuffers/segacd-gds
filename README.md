# The Sega CD BIOS, but in Godot

(C) 2025 Framebuffer

This is made just so I can learn GDScript *and* 2D nodes at the same time.
as well as to brush up my skills on 2D transforms.

## The brief

This project aims to recreate the BIOS of the Sega CD addon for the
MegaDrive/Genesis console from 1991.

### References

<https://www.youtube.com/watch?v=1SOFK9vg45g&list=PLKiyMny0Rz8A-ZGHVwncQL5CEO2n7_lP0>

## Definition

The Sega CD has 3 different regions, out of which there's about 30 or so variations
of the same couple transforms.

- Translate through the screen following a path.
- Jump in front of one another.
- Rotation
- Squish
- Shear
- Scaling
- Create clones of itself
- Transform using a pivot as a point of reference.
- Orbit
- Palette swap

All of these can be recreated using the same tools found in Godot's transformations.
For this, effects used will be a mix of both NTSC-U, NTSC-J and PAL; out of all
varsions released (and available to watch and learn their patterns from).

## Viewports

We want to get thet *very crunchy* look for the screen. For this:

- Everything will be rendered at a smaller scale, 320x224, like the OG console.
- The final output will be scaled to the final player screen's resolution using nearest neighbor scaling.
- Scaling will be done using only whole numbers.
- The Viewport for the animated screen will *always* keep the same position relative to the screen.
- Any cropping will be done to the black borders, obviously taking care the text is not cropped.
  
## Music

Well, this one is self explanatory. It autoplays at start and loops until start is pressed.

## File structure

This project is comprised of:

- main.gd/tscn (this file!):
  - Acts as your average singleton in Godot.
  - Contains all the common transforms.
  - Basically runs the main loop.
- logo_small.gd/tscn: Attached to the smaller logo.
  - Anything specific to that scene goes here.
- logo_large.gd/tscn: Attached to the larger logo.
  - Anything specific to that scene goes here.
- user_interface.gd/tscn: Control node for the UI overlay.
- [resources]: Any sprite, sound file or external resource goes here.

## Controls

Just the start button to continue to another thing. Everything starts on its own.

## end

well, wish me luck, i guess.
