use dep::std::hash::blake2s;
use dep::std;

// fn check_valid(turns: [Field; 6]){
//     for i in 0..5 {
//         assert(turns[i] as u1 < 3 ); // {0,1,2} = {rock, paper, scissors}
//     }
// }

fn main(hash: pub [u8; 32], turn: u8 ) {
    assert(turn as u1 < 3 ); // {0,1,2} = {rock, paper, scissors}
    ///TODO: check for win
    let computed_hash = blake2s([turn]);
    assert(hash == computed_hash);
}

// #[test]
// fn test_generate() {
//     let choice_hash = pedersen([1,1, 1, 0xc59975735ed4774b3Ee8479D0b5A26388B929a34]);
//     std::println( choice_hash[0]);
// }
