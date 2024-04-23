//Booking.sol
// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

import "./Ticket.sol";

contract Booking {
 Ticket public ticketContract;

constructor(Ticket _ticketContract) {
 ticketContract = _ticketContract;
 }
 
function bookTicket(uint256 _ticketIndex) public payable {
 Ticket.MovieTicket storage ticket = ticketContract.tickets(_ticketIndex);
 require(msg.value >= 1 ether, "Insufficient funds to book the ticket.");

address payable ticketOwner = payable(ticket.owner);
 ticketOwner.transfer(msg.value);
// Additional logic to handle ticket booking, e.g., updating ticket status
 }
 }