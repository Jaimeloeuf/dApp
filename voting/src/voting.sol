pragma solidity 0.5.11;
// Experimental feature turned on for constructor to receive an Array of Strings.
pragma experimental ABIEncoderV2;

contract Voting {
    // Mapping of candidates that can be voted for.
    mapping (string => Candidate) public candidates;

    uint8 public candidateCount = 0;
    uint8 private user_id_counter = 0;
    
    function userIDGenerator() internal returns (uint8) {
        return ++user_id_counter;
    }

    // Variable to store the contract owner's address.
    address public owner;
    
    struct Candidate {
        uint8 id;
        string name;
        uint256 time_of_registration;
        uint256 votes;
        address[] voters;
    }
    
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
    
    constructor(string[] memory initial_candidates) public {
        for (uint8 i = 0; i < initial_candidates.length; i++)
            createCandidate(initial_candidates[i]);
        
        owner = msg.sender;
    }
    
    function hasCandidate(string memory candidate) public view returns (bool) {
        if (candidates[candidate].id != 0)
            return true;
    }
    
    // Function to Create and Add a new candidate to the Map.
    function createCandidate(string memory name) private returns (Candidate memory) {
        Candidate memory candidate;
        candidate.id = userIDGenerator();
        candidate.name = name;
        candidate.time_of_registration = block.timestamp;
        
        // Add the candidate into the candidates mapping directly
        candidates[name] = candidate;
        
        // Can potentially return the candidate struct too for Caller to use directly.
        // Currently not used as it costs more gas.
        // return candidate;
    }
    
    function newCandidate(string memory candidateName) public onlyOwner {
        // Make sure that the candidate is not already registered
        assert(!hasCandidate(candidateName));
        // Create and add the candidate to the Map.
        createCandidate(candidateName);
    }
    
    function removeCandidate(string memory candidateName) public onlyOwner {
        // Make sure that the candidate is already registered
        assert(hasCandidate(candidateName));
        // Remove the candidate by setting its value to false.
        delete(candidates[candidateName]);
    }

    function voteFor(string memory candidateName) public allExceptOwner {
        // Make sure the candidate is already registered
        assert(hasCandidate(candidateName));
        // Increment the vote for that candidate by 1.
        candidates[candidateName].votes += 1;
        candidates[candidateName].voters.push(msg.sender);
    }
    
    function votesOf(string memory candidateName) public view returns (uint256) {
        // Make sure the candidate is already registered
        assert(hasCandidate(candidateName));
        return candidates[candidateName].votes;
    }
    
    function votersOf(string memory candidateName) public view returns (address[] memory) {
        // Make sure the candidate is already registered
        assert(hasCandidate(candidateName));
        return candidates[candidateName].voters;
    }
}