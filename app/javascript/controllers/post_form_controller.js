import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "photoInput", "previewContainer",
    "checkInButton", "checkInField",
    "courseButtons", "courseField",
    "reviewSection", "ratingsField"
  ];

  previewPhotos(event) {
    const files = Array.from(event.target.files);
    if (files.length > 6) {
      alert("Máximo 6 imagens!");
      this.photoInputTarget.value = "";
      return;
    }

    this.previewContainerTarget.innerHTML = "";
    files.forEach(file => {
      const img = document.createElement("img");
      img.src = URL.createObjectURL(file);
      img.classList.add("rounded", "shadow-sm", "object-fit-cover");
      img.style.width = "80px";
      img.style.height = "80px";
      this.previewContainerTarget.appendChild(img);
    });
  }

    toggleCheckIn() {
    const current = this.checkInFieldTarget.value === "true";
    this.checkInFieldTarget.value = (!current).toString();

    this.checkInButtonTarget.classList.toggle("btn-outline-secondary", current);
    this.checkInButtonTarget.classList.toggle("btn-danger", !current);

    if (!current) {
      this.checkInButtonTarget.style.backgroundColor = "#F83B2F";
      this.checkInButtonTarget.style.color = "#FBFBF1";
    } else {
      this.checkInButtonTarget.style.backgroundColor = "";
      this.checkInButtonTarget.style.color = "";
    }
  }

selectCourse(event) {
  const button = event.currentTarget;
  const value = button.dataset.value;
  const field = this.courseFieldTarget;

  // Alterna seleção visual
  button.classList.toggle("active");

  // Atualiza lista
  let selected = Array.from(
    this.element.querySelectorAll(".menu-time-btn.active")
  ).map(btn => btn.dataset.value);

  // Salva array no hidden field
  field.value = JSON.stringify(selected);
}

 toggleReview(event) {
  const visible = event.target.checked;

  this.reviewSectionTarget.classList.toggle("d-none", !visible);

  if (!visible) {
    this.ratingsFieldTarget.value = "";
  } else {
    // Reativa o clique das estrelas quando a seção aparece
    this.reviewSectionTarget.querySelectorAll("i").forEach(star => {
      star.addEventListener("click", (e) => this.rate(e));
    });
  }
}

  rate(event) {
  const value = parseInt(event.target.dataset.value);
  const container = event.target.closest(".rating-stars");
  const field = container.dataset.field;

  // Atualiza JSON de ratings
  let ratings = JSON.parse(this.ratingsFieldTarget.value || "{}");
  ratings[field] = value;
  this.ratingsFieldTarget.value = JSON.stringify(ratings);

  // Re-renderiza o estado visual das estrelas
  container.querySelectorAll("i").forEach(star => {
    const starValue = parseInt(star.dataset.value);
    if (starValue <= value) {
      star.classList.remove("far");
      star.classList.add("fas");
    } else {
      star.classList.remove("fas");
      star.classList.add("far");
    }
  });
}
}
