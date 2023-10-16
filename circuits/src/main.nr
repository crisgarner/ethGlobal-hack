use dep::std::hash::pedersen;
use dep::std;

fn main(commitment : Field, secret_number : Field, choice: Field , turn : pub Field, opponent : pub Field) {
    let choice_hash = pedersen([secret_number,choice, turn, opponent]);
    assert(commitment == choice_hash[0]);
}


// #[test]
// fn test_generate() {
//     let choice_hash = pedersen([1,1, 1, 0xc59975735ed4774b3Ee8479D0b5A26388B929a34]);
//     std::println( choice_hash[0]);
// }
