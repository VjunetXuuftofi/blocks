pragma solidity ^0.4.11;

/// @title Voting with delegation.
contract Ballot {
    // This declares a new complex type which will
    // be used for variables later.
    // It will represent a single voter.

    struct Voter {
        bool eligible; // if true, this address is authorized to vote.
        uint id;
    }


    address public chairperson;

    // This declares a state variable that
    // stores a `Voter` struct for each possible address.
    mapping(address => Voter) public voters;
    mapping(address=>mapping(uint => mapping(uint => bytes32))) public results;


    function Ballot() {
        chairperson = msg.sender;
    }

    // Give `voter` the right to vote on this ballot.
    // May only be called by `chairperson`.
    function giveRightToVote(address voter) {
        // If the argument of `require` evaluates to `false`,
        // it terminates and reverts all changes to
        // the state and to Ether balances. It is often
        // a good idea to use this if functions are
        // called incorrectly. But watch out, this
        // will currently also consume all provided gas
        // (this is planned to change in the future).
        require((msg.sender == chairperson));
        voters[voter].eligible = true;
    }

    /// Give your vote (including votes delegated to you)
    /// to proposal `proposals[proposal].name`. //
    function vote(uint choice_number, uint question_number, bytes32 candidate_hash) {
        require (voters[msg.sender].eligible);
        results[msg.sender][choice_number][question_number] = candidate_hash;
    }

    function getCombination(uint choice_number, uint question_number) constant returns (bytes32)
    {
        return results[msg.sender][choice_number][question_number];
    }



}