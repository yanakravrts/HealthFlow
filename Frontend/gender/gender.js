let selectedGender = null;

document.addEventListener("DOMContentLoaded", function () {
    const nextButton = document.querySelector('.next');
    nextButton.style.display = 'none'; // Початково ховаємо кнопку "Next"
});

function selectGender(gender) {
    selectedGender = gender;
    showNextButton();
}

function showNextButton() {
    const nextButton = document.querySelector('.next');
    if (selectedGender) {
        nextButton.style.display = 'block';
    }
}

function goToNext() {
    // Тут можна додати код для переходу на наступну сторінку або виконання інших дій
    console.log('Next button clicked! Selected gender:', selectedGender);
}
