function validateCode(event) {
    event.preventDefault();
    const codeInput = document.getElementById('code');
    const enteredCode = codeInput.value;

    // Here, you can compare the entered code with the one sent to the email.
    // Implement the necessary logic for validation.
    if (enteredCode === '1234') {
        alert('Code is valid. Email successfully verified!');
    } else {
        alert('Invalid code. Please try again.');
    }
}
