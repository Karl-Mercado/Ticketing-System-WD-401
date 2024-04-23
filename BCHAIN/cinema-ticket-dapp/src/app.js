// Contract addresses and ABIs
const ticketContractAddress = 'YOUR_TICKET_CONTRACT_ADDRESS';
const ticketContractAbi = [ /* Paste your ticket contract ABI here */ ];

// Web3 initialization
const web3 = new Web3(window.ethereum);
const ticketContract = new web3.eth.Contract(ticketContractAbi, ticketContractAddress);

// Function to create a ticket
async function createTicket() {
    const movieName = document.getElementById('movieName').value;
    const quantity = document.getElementById('quantity').value;
    const scheduledDate = document.getElementById('scheduledDate').value;
    const ticketPrice = parseFloat(document.getElementById('price').value); // Get ticket price from dropdown menu

    if (!movieName) {
        alert('Please select a movie.');
        return;
    }

    try {
        await ticketContract.methods.createTicket(
            movieName,
            web3.utils.toWei(ticketPrice.toString(), 'ether'), // Convert ticket price to Wei
            quantity,
            web3.utils.toWei((ticketPrice * quantity).toString(), 'ether'), // Calculate total amount in Wei
            scheduledDate
        ).send({ from: await getCurrentAccount() });

        alert('Ticket created successfully!');
    } catch (error) {
        console.error('Error creating ticket:', error);
        alert('Failed to create ticket. See console for details.');
    }
}

// Function to book a ticket
async function bookTicket() {
    const ticketIndex = document.getElementById('ticketIndex').value;
    try {
        await ticketContract.methods.bookTicket(ticketIndex).send({ from: await getCurrentAccount() });
        alert('Ticket booked successfully!');
    } catch (error) {
        console.error('Error booking ticket:', error);
        alert('Failed to book ticket. See console for details.');
    }
}

// Function to get the current Ethereum account
async function getCurrentAccount() {
    const accounts = await web3.eth.getAccounts();
    return accounts[0];
}

// Enable Web3
window.ethereum.enable().then(() => {
    // Web3 is now enabled
}).catch((error) => {
    console.error('Error enabling Web3:', error);
    alert('Failed to enable Web3. Please check your MetaMask settings.');
});
