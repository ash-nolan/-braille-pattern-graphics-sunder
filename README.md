# Braille Pattern Graphics
Library for 2D graphics using characters from the [Unicode Braille Patterns
Block](https://en.wikipedia.org/wiki/Braille_Patterns). Ported from the Braille
Pattern Graphics [Python 3
library](https://github.com/ashn-dot-dev/braille-pattern-graphics) for
[Sunder](https://github.com/ashn-dot-dev/sunder) version
[2023.02.01](https://github.com/ashn-dot-dev/sunder/releases/tag/2023.02.01).

## Example Usage
```
import "std";
import "bpgfx.sunder";

func main() void {
    # Create a 40 x 30 canvas of virtual dot pixels.
    #
    # Virtual dot-pixels are mapped onto a grid of braille characters when the
    # canvas is rendered via its format member function.
    var canvas = bpgfx::canvas::init(40, 30);
    defer canvas.fini();

    # Draw a rectangle around the border of the canvas.
    for x in canvas.width() {
        canvas.set(x, 0, true);
        canvas.set(x, canvas.height() - 1, true);
    }
    for y in canvas.height() {
        canvas.set(0, y, true);
        canvas.set(canvas.width() - 1, y, true);
    }

    # Add some stars in the background.
    for x in 2:canvas.width()-2 {
        if x % 2 == 0 {
            continue;
        }
        var y = ((x * 23) / 7) % canvas.height();
        canvas.set(x, y, true);
    }

    # Draw a spaceship!
    #
    # The spaceship type implements the "drawable" interface with the "draw"
    # member function:
    #
    #   func draw(self: *spaceship, canvas: *bpgfx::canvas) void {
    #       # code to draw the spaceship...
    #   }
    var ship = spaceship::init(16, 12);
    canvas.draw(bpgfx::drawable::init[[spaceship]](&ship));

    # Write the rendered contents of the canvas to STDOUT.
    std::print_format(std::out(), "{}", (:[]std::formatter)[std::formatter::init[[bpgfx::canvas]](&canvas)]);
}

struct spaceship {
    var x: usize;
    var y: usize;

    func init(x: usize, y: usize) spaceship {
        return (:spaceship){
            .x = x,
            .y = y
        };
    }

    func draw(self: *spaceship, canvas: *bpgfx::canvas) void {
        canvas.*.set(self.*.x + 0, self.*.y + 0, true);
        canvas.*.set(self.*.x + 4, self.*.y + 0, true);
        for i in self.*.x:(self.*.x + 6) {
            canvas.*.set(i, self.*.y + 1, true);
            canvas.*.set(i, self.*.y + 2, true);
        }
        canvas.*.set(self.*.x + 4, self.*.y + 3, true);
        canvas.*.set(self.*.x + 0, self.*.y + 3, true);
    }
}
```
```sh
$ sunder-run example.sunder
⡏⠉⠉⠉⠉⠉⠉⠉⠉⠩⠉⠉⠉⠉⠉⠉⠉⠉⠙⢹
⡇⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⢸
⡇⠐⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⢀⠀⠀⠀⢸
⡇⠀⠀⠀⠀⠀⠈⠀⡷⠶⡷⢀⠀⠀⠀⠀⠀⠀⠀⢸
⡇⠀⠈⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⢸
⡇⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⢸
⡇⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⢸
⠓⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠚⠒⠒⠒⠒⠒⠚
```

## License
All content in this repository is licensed under the Zero-Clause BSD license.

See LICENSE for more information.
