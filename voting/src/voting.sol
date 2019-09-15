pragma solidity 0.5.11;

contract Voting {
    // Mapping of candidates that can be voted for.
    mapping (string => bool) public candidates;
    // Mapping of candidates and the number of votes each of them has.
    mapping (string => uint8) private votes;
    // Variable to store the contract owner's address.
    address public owner;
    
    // Modifier that only allows owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    // Modifier that blocks owner of the contract
    modifier allExceptOwner() {
        require(msg.sender != owner);
        _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    function hasCandidate(string memory candidate) public view returns (bool) {
        return candidates[candidate];
    }
    
    function newCandidate(string memory candidate) public onlyOwner {
        // Make sure that the candidate is not already registered
        assert(!hasCandidate(candidate));
        // Register the candidate by adding it to the Map.
        candidates[candidate] = true;
    }
    
    function removeCandidate(string memory candidate) public onlyOwner {
        // Make sure that the candidate is already registered
        assert(hasCandidate(candidate));
        // Remove the candidate by setting its value to false.
        candidates[candidate] = false;
    }

    function voteFor(string memory candidate) public allExceptOwner {
        // Make sure the candidate is already registered
        assert(candidates[candidate]);
        // Increment the vote for that candidate by 1.
        votes[candidate] += 1;
    }
    
    function votesOf(string memory candidate) public view returns (uint8) {
        // Make sure the candidate is already registered
        assert(candidates[candidate]);
        return votes[candidate];
    }
}