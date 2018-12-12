extern crate regex;

use std::io::BufRead;
use regex::Regex;

fn main() {
  // coordinates were manually inspected to be <1000
  let mut grid = Grid::new();

  // read all instructions
  // the .lock essentially gets a mutex so that other threads don't mess around while the buffer is being read?
  // we also need to create it outside of the for loop expression so that the lifetime/ownership is right?
  let stdin = std::io::stdin();
  let stdin_locked = stdin.lock();
  for line in stdin_locked.lines() {
    let instruction = Instruction::from_line(&line.unwrap());
    grid.execute(&instruction);
  }
  println!("{} lights are on.", grid.sum());
}

struct Grid {
  grid: [[bool; 1000]; 1000],
}

impl Grid {
  fn new() -> Grid {
    Grid {
      grid: [[false; 1000]; 1000],
    }
  }

  fn execute(&mut self, instruction: &Instruction) {
    for row in instruction.start.x..instruction.end.x {
      for col in instruction.start.y..instruction.end.y {
        self.grid[row as usize][col as usize] = match instruction.action {
          InstructionAction::Toggle => !self.grid[row as usize][col as usize],
          InstructionAction::Set(b) => b,
        }
      }
    }
  }

  // sum is potentially up to 1,000,000
  fn sum(&self) -> u32 {
    self.grid.iter().map(|row: &[bool; 1000]| -> u32 { row.iter().map(|x: &bool| -> u32 { (*x) as u32 }).sum() }).sum()
  }
}

struct Point {
  x: u16,
  y: u16,
}

enum InstructionAction {
  Set(bool),
  Toggle,
}

struct Instruction {
  start: Point,
  end: Point,
  action: InstructionAction,
}

impl Instruction {
  fn from_line(line: &str) -> Instruction {
    // TODO: make this static. The `lazy-static` crate allows it to be defined as static lifetime and only initialized once.
    let re = Regex::new("(turn on|turn off|toggle) (\\d{1,3}),(\\d{1,3}) through (\\d{1,3}),(\\d{1,3})").unwrap();
    let caps = re.captures(line).unwrap();

    Instruction {
      // OK to use teh indexing stuff because the strings from caps[n] cannot outlive re but we parse right away
      // TODO: nice errors if they don't parse
      start: Point { x: caps[2].parse().unwrap(), y: caps[3].parse().unwrap() },
      end: Point { x: caps[4].parse().unwrap(), y: caps[5].parse().unwrap() },
      // TODO: use FromStr so that we can use caps[1].parse()
      action: match &caps[1] {
        "turn on" => InstructionAction::Set(true),
        "turn off" => InstructionAction::Set(false),
        "toggle" => InstructionAction::Toggle,
        _ => panic!("Impossible first capture group"),
      },
    }
  }
}
