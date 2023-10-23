use dep::std;

fn main(inputs: [Field;1]) -> pub [Field; 2] {
    std::hash::pedersen(inputs)
}
