use dep::std;

struct Square {
    x: Field,
    y: Field
}

impl Square {
    fn new(x: Field, y: Field) -> Square {
        Square { x, y }
    }
    fn start() -> Square {
      Square { x: 0, y: 0 }
    }
    fn equals(self, other: Square) -> bool {
      ((self.x as u8 ^ other.x as u8) | (self.y as u8 ^ other.y as u8)) == 0
    }
    fn on_board(sq: Square) -> bool {
      (sq.x as u8 & 0xF8 == 0) & (sq.y as u8 & 0xF8 == 0)
    }
}

fn is_start(square: Square) {
    assert(square.x as u8 & square.y as u8 == 0);
}

// valid move can be in one of 8 positions
unconstrained fn valid_positions(sq: Square) -> [Square; 8] {
    let x = sq.x;
    let y = sq.y;
    [Square::new(x + 3, y + 1),
        Square::new(x + 3, y - 1),
        Square::new(x - 3, y + 1),
        Square::new(x - 3, y - 1),
        Square::new(x + 1, y + 3),
        Square::new(x + 1, y - 3),
        Square::new(x - 1, y + 3),
        Square::new(x - 1, y - 3)]
}

fn abs_diff(x: u8, y: u8) -> u8 {
    let mut z: u8 = 0;
    if x < y {
        z = y - x;
    } else {
        z = x - y;
    }
    z
}

fn valid_move(from: Square, to: Square) {
    let dx = abs_diff(from.x as u8, to.x as u8);
    let dy = abs_diff(from.y as u8, to.y as u8);

    let fst = (dx == 2) & (dy == 1);
    let snd = (dx == 1) & (dy == 2);

    assert(fst | snd);
}

pub fn is_valid_path(path: [Square; 8], dagger: Square) {
    // check starting position
    is_start(path[0]);
    for i in 1..7 {
        assert(Square::on_board(path[i]));
        valid_move(path[i - 1], path[i]);
    }
    assert(Square::equals(path[7], dagger));
}

pub fn is_safe_path(
    path: [Square; 8],
    watcher_map: [[bool; 8]; 8]
) {
    // Part 2
}
