pragma solidity ^0.5.11

contract Voting {

    mapping (bytes32 ==> uint8) public votesReceived

    bytes32 public candidateList;

    function Voting(bytes32 [] candidateNames) {
        candidateList = candidateNames;

    }

    function totalVotes(bytes32 candidate) returns (uint8) {
        return votesReceived[candidate]
    }

    function voteFor(bytes32 candidate) {
        if(validCandidate(candidate) == false)
            throw;
        
        votesReceived[candidate] += 1;
    }

    function validcandidate(bytes32 candidate) returns (bool) {
        for (uint i = 0; i<candidateList.length; i++) {
            if (candidateList[i] == candidate)
                return true;
        }
        return false;
    }
}