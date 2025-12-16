import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "photoInput",
    "previewContainer",
    "checkInField",
    "checkInButton",
    "reviewSwitch",
    "reviewSection",
    "ratingField",
    "courseInputs"
  ]

  previewPhotos(event) {
    const files = event.target.files
    this.previewContainerTarget.innerHTML = ""

    Array.from(files).forEach((file) => {
      const reader = new FileReader()
      reader.onload = (e) => {
        const img = document.createElement("img")
        img.src = e.target.result
        img.classList.add("preview-thumb")
        this.previewContainerTarget.appendChild(img)
      }
      reader.readAsDataURL(file)
    })
  }

  toggleCourse(event) {
    event.preventDefault()
    const button = event.currentTarget
    const value = button.dataset.value

    button.classList.toggle("active")

    const existing = this.courseInputsTarget.querySelector(`input[data-value="${value}"]`)
    if (existing) {
      existing.remove()
      return
    }

    const input = document.createElement("input")
    input.type = "hidden"
    input.name = "post[menu_times][]"
    input.value = value
    input.dataset.value = value
    this.courseInputsTarget.appendChild(input)
  }

  toggleCheckIn(event) {
    event.preventDefault()
    const current = this.checkInFieldTarget.value === "true"
    const next = !current

    this.checkInFieldTarget.value = next
    this.checkInButtonTarget.classList.toggle("checkin-active", next)
  }

  toggleReview(event) {
    const checked = event.currentTarget.checked

    if (checked) {
      this.reviewSectionTarget.classList.remove("d-none")
    } else {
      this.reviewSectionTarget.classList.add("d-none")
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
