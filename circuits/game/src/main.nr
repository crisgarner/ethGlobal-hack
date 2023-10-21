use dep::std::hash::pedersen;
use dep::std;

fn check_valid(turns: [Field; 2]){
    for i in 0..1 {
        assert(turns[i] as u1 < 3 ); // {0,1,2} = {rock, paper, scissors}
    }
}

fn main(hash: pub Field, turns: [Field; 2]) {
    check_valid(turns);
    let computed_hash = pedersen(turns);
    assert(hash == computed_hash[0]);
}


// #[test]
// fn test_generate() {
//     let choice_hash = pedersen([1,1, 1, 0xc59975735ed4774b3Ee8479D0b5A26388B929a34]);
//     std::println( choice_hash[0]);
// }
