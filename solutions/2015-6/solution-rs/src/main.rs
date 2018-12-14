extern crate regex;

use std::io::BufRead;
use regex::Regex;

fn main() {
  // coordinates were manually inspected to be <1000
  let mut grid = Grid::new();
  let mut grid_part2 = Grid::new();

  // read all instructions
  // the .lock essentially gets a mutex so that other threads don't mess around while the buffer is being read?
  // we also need to create it outside of the for loop expression so that the lifetime/ownership is right?
  let stdin = std::io::stdin();
  let stdin_locked = stdin.lock();
  for line in stdin_locked.lines() {
    let instruction = Instruction::from_line(&line.unwrap()).unwrap();
    grid.execute(&instruction);
    grid_part2.execute_part2(&instruction);
  }
  println!("{} lights are on.", grid.sum());
  println!("Part2: {} lights are on.", grid_part2.sum());
}

struct Grid {
  grid: Box<[[u32; 1000]; 1000]>,
}

impl Grid {
  fn new() -> Grid {
    Grid {
      grid: Box::new([[0; 1000]; 1000]),
    }
  }

  fn execute(&mut self, instruction: &Instruction) {
    // ranges are exclusive on the top for some godforsaken reason
    for row in instruction.start.x..instruction.end.x + 1 {
      for col in instruction.start.y..instruction.end.y + 1 {
        let grid_val = &mut self.grid[row as usize][col as usize];
        *grid_val = match instruction.action {
          InstructionAction::Toggle => 1 - *grid_val,
          InstructionAction::TurnOn => 1,
          InstructionAction::TurnOff => 0,
        }
      }
    }
  }

  fn execute_part2(&mut self, instruction: &Instruction) {
    for row in instruction.start.x..instruction.end.x + 1 {
      for col in instruction.start.y..instruction.end.y + 1 {
        let grid_val = &mut self.grid[row as usize][col as usize];
        *grid_val = match instruction.action {
          InstructionAction::Toggle => *grid_val + 2,
          InstructionAction::TurnOn => *grid_val + 1,
          InstructionAction::TurnOff => if *grid_val == 0 { 0 } else { *grid_val - 1 },
        }
      }
    }
  }

  // sum is potentially up to 1,000,000
  fn sum(&self) -> u32 {
    self.grid.iter().map(|row: &[u32; 1000]| -> u32 { row.iter().sum() }).sum()
  }
}

struct Point {
  x: u16,
  y: u16,
}

enum InstructionAction {
  TurnOn,
  TurnOff,
  Toggle,
}

struct Instruction {
  start: Point,
  end: Point,
  action: InstructionAction,
}

impl Instruction {
  fn from_line(line: &str) -> Option<Instruction> {
    // TODO: make this static. The `lazy-static` crate allows it to be defined as static lifetime and only initialized once.
    let re = Regex::new("(turn on|turn off|toggle) (\\d{1,3}),(\\d{1,3}) through (\\d{1,3}),(\\d{1,3})").unwrap();
    let caps = re.captures(line)?;

    Some(Instruction {
      // OK to use teh indexing stuff because the strings from caps[n] cannot outlive re but we parse right away
      start: Point { x: caps[2].parse()?, y: caps[3].parse()? },
      end: Point { x: caps[4].parse()?, y: caps[5].parse()? },
      // TODO: use FromStr so that we can use caps[1].parse()
      action: match &caps[1] {
        "turn on" => InstructionAction::TurnOn,
        "turn off" => InstructionAction::TurnOff,
        "toggle" => InstructionAction::Toggle,
        _ => panic!("Impossible first capture group"),
      },
    })
  }
}
