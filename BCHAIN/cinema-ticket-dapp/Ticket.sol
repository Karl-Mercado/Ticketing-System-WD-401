// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract Ticket {
    // Struct to represent a movie ticket
    struct MovieTicket {
        address owner;          // Address of the ticket owner
        string movieName;       // Name of the movie
        uint256 ticketPrice;    // Price of the ticket in Wei
        uint256 quantity;       // Number of available tickets
        uint256 totalAmount;    // Total amount in Wei for all tickets
        string scheduledDate;   // Scheduled date for the movie
        uint256 timestamp;      // Timestamp when the ticket was created
    }
    
    MovieTicket[] public tickets;   // Array to store all movie tickets
    string[] public availableMovies; // List of available movies

    // Event emitted when a new ticket is created
    event TicketCreated(
        address indexed owner,     
        string movieName,          
        uint256 ticketPrice,      
        uint256 quantity,         
        uint256 totalAmount,       
        string scheduledDate,      
        uint256 timestamp          
    );

    // Constructor to initialize availableMovies with some example movie names
    constructor() {
        availableMovies.push("Haikyuu!! The Dumpster Battle (2024)");
        availableMovies.push("My Hero Academia: World Heroes' Mission (2021)");
        availableMovies.push("Jujutsu Kaisen 0");
        // Add more movies as needed
    }

    // Function to create a new movie ticket
    function createTicket(
        string memory _movieName,      // Name of the movie
        uint256 _ticketPrice,          // Price of the ticket in Wei
        uint256 _quantity,             // Number of available tickets
        uint256 _totalAmount,          // Total amount in Wei for all tickets
        string memory _scheduledDate   // Scheduled date for the movie
    ) public {
        // Push the new ticket to the tickets array
        tickets.push(MovieTicket(
            msg.sender,                 // Owner of the ticket
            _movieName,                 // Name of the movie
            _ticketPrice,               // Price of the ticket
            _quantity,                  // Number of available tickets
            _totalAmount,               
            _scheduledDate,            
            block.timestamp            
        ));
        
        // Emit an event to notify the creation of a new ticket
        emit TicketCreated(
            msg.sender,                
            _movieName,               
            _ticketPrice,              
            _quantity,                  
            _totalAmount,               
            _scheduledDate,            
            block.timestamp             
        );
    }
}
