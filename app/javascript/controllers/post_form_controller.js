// app/javascript/controllers/post_form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "photoInput",
    "previewContainer",
    "courseField",
    "checkInField",
    "checkInButton",
    "reviewSwitch",
    "reviewSection",
    "ratingField"
  ]

  previewPhotos(event) {
    const files = event.target.files
    this.previewContainerTarget.innerHTML = ""

    Array.from(files).forEach((file) => {
      const reader = new FileReader()
      reader.onload = (e) => {
        const img = document.createElement("img")
        img.src = e.target.result
        img.classList.add("preview-thumb") // miniatura
        this.previewContainerTarget.appendChild(img)
      }
      reader.readAsDataURL(file)
    })
  }

  selectCourse(event) {
    event.preventDefault()
    const button = event.currentTarget
    const value = button.dataset.value

    this.courseFieldTarget.value = value

    const buttons = button.parentElement.querySelectorAll(".menu-time-btn")
    buttons.forEach((b) => b.classList.remove("active"))
    button.classList.add("active")
  }

  toggleCheckIn(event) {
  event.preventDefault()
  const current = this.checkInFieldTarget.value === "true"
  const next = !current

  this.checkInFieldTarget.value = next

  // adiciona/remove apenas a classe de estado ativo
  this.checkInButtonTarget.classList.toggle("checkin-active", next)
}

  toggleReview(event) {
    const checked = event.currentTarget.checked

    if (checked) {
      this.reviewSectionTarget.classList.remove("d-none")
    } else {
      this.reviewSectionTarget.classList.add("d-none")

      // não manda 0, manda vazio (some o rating)
      this.ratingFieldTarget.value = ""

      this.element.querySelectorAll(".star-rating i").forEach((star) => {
        star.classList.remove("fas")
        star.classList.add("far")
      })
    }
  }

  rate(event) {
    event.preventDefault()
    const clickedStar = event.currentTarget
    const value = parseInt(clickedStar.dataset.value, 10)

    const group = clickedStar.closest(".star-rating")

    group.querySelectorAll("i").forEach((star) => {
      const starValue = parseInt(star.dataset.value, 10)
      if (starValue <= value) {
        star.classList.remove("far")
        star.classList.add("fas")
      } else {
        star.classList.remove("fas")
        star.classList.add("far")
      }
    })

    let total = 0
    let count = 0

    this.element.querySelectorAll(".star-rating").forEach((starGroup) => {
      let groupScore = 0

      starGroup.querySelectorAll("i").forEach((star) => {
        if (star.classList.contains("fas")) {
          groupScore = parseInt(star.dataset.value, 10)
        }
      })

      if (groupScore > 0) {
        total += groupScore
        count += 1
      }
    })

    const avg = count > 0 ? Math.round(total / count) : 0
    this.ratingFieldTarget.value = avg
  }
}
