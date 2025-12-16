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

  connect() {
    this.selectedFiles = []
  }

  previewPhotos(event) {
    const incoming = Array.from(event.target.files || [])
    const merged = [...this.selectedFiles, ...incoming]

    const seen = new Set()
    const unique = []
    merged.forEach((file) => {
      const key = `${file.name}-${file.size}-${file.lastModified}`
      if (!seen.has(key)) {
        seen.add(key)
        unique.push(file)
      }
    })

    this.selectedFiles = unique.slice(0, 6)
    this.syncInputFiles()
    this.renderPreviews()
    this.photoInputTarget.value = ""
  }

  removePhoto(index) {
    this.selectedFiles.splice(index, 1)
    this.syncInputFiles()
    this.renderPreviews()
  }

  syncInputFiles() {
    const dt = new DataTransfer()
    this.selectedFiles.forEach((file) => dt.items.add(file))
    this.photoInputTarget.files = dt.files
  }

  renderPreviews() {
    this.previewContainerTarget.innerHTML = ""

    this.selectedFiles.forEach((file, index) => {
      const wrapper = document.createElement("div")
      wrapper.style.position = "relative"
      wrapper.style.display = "inline-block"

      const btn = document.createElement("button")
      btn.type = "button"
      btn.textContent = "×"
      btn.setAttribute("aria-label", "Remover foto")
      btn.style.position = "absolute"
      btn.style.top = "4px"
      btn.style.right = "4px"
      btn.style.width = "28px"
      btn.style.height = "28px"
      btn.style.borderRadius = "999px"
      btn.style.border = "0"
      btn.style.cursor = "pointer"
      btn.style.fontSize = "18px"
      btn.style.lineHeight = "28px"
      btn.style.padding = "0"
      btn.addEventListener("click", (e) => {
        e.preventDefault()
        this.removePhoto(index)
      })

      const img = document.createElement("img")
      img.classList.add("preview-thumb")

      const reader = new FileReader()
      reader.onload = (e) => {
        img.src = e.target.result
      }
      reader.readAsDataURL(file)

      wrapper.appendChild(img)
      wrapper.appendChild(btn)
      this.previewContainerTarget.appendChild(wrapper)
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
