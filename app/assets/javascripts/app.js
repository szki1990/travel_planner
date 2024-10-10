document.addEventListener("DOMContentLoaded", () => {
    document.querySelector("#dark-mode-toggle").addEventListener("click", () => {
        if (document.body.classList.contains("dark-mode")) {
            document.body.classList.remove("dark-mode");
            localStorage.setItem("darkMode", "disabled");
        } else {
            document.body.classList.add("dark-mode");
            localStorage.setItem("darkMode", "enabled");
        }
    });
});
