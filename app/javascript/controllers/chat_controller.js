import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "input", "response"]


  // Abre/Fecha o modal
  toggle() {
    const isHidden = this.modalTarget.style.display === "none" || this.modalTarget.style.display === ""
    this.modalTarget.style.display = isHidden ? "block" : "none"
  }

  // Envia a mensagem
  async send() {
    const message = this.inputTarget.value.trim()
    if (!message) return

    this.responseTarget.innerText = "Pensando... 🤔"

    try {
      const response = await fetch("/chats/1/message", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        },
        body: JSON.stringify({ message: message })
      })

      const data = await response.json()
      this.responseTarget.innerText = data.reply
      this.inputTarget.value = "" // Opcional: limpa o campo após enviar
    } catch (error) {
      this.responseTarget.innerText = "Erro ao conectar com o servidor."
    }
  }
}
