## Features

- Draggable second, minute, and hour clock hand.
- A classic analog clock face.
- Not tied to any state management provider. It uses `StatefulWidget` under the hood.

## Limitation

When the clock hands are dragged, the center of rotation is set to the center of the screen rather than the center of the clock. This causes dragging towards x-axis to be less accurate because the x-axis is higher than where it should be.

However, dragging towards y-axis is still accurate.
