const btn_spinner = document.querySelector(".btn_spinner");
const close = document.querySelector(".close");
const spinner = document.querySelector("#spinner");

btn_spinner.addEventListener("click", () => {


    spinner.style.animationPlayState = "running";
  
    setTimeout(() => {
      let numeroSorteado = Math.floor(Math.random() * 150) + 1;
      document.querySelector("#number").innerHTML = numeroSorteado;
      openModal();
      spinner.style.animationPlayState = "paused";
    }, 5000);
});
  
function openModal() {
    document.querySelector("#modal").style.display = "block";
}
  
close.addEventListener("click", () => {
    document.querySelector("#modal").style.display = "none";
});