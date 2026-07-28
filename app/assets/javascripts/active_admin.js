//= require active_admin/base

document.addEventListener("click", (event) => {
  const link = event.target.closest("a[data-method]")

  if (!link) return

  const method = link.dataset.method.toUpperCase()

  if (method === "GET") return

  event.preventDefault()

  if (link.dataset.confirm) {
    const confirmed = window.confirm(link.dataset.confirm)

    if (!confirmed) return
  }

  const form = document.createElement("form")
  form.method = "POST"
  form.action = link.href
  form.style.display = "none"

  const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content

  const csrfInput = document.createElement("input")
  csrfInput.type = "hidden"
  csrfInput.name = "authenticity_token"
  csrfInput.value = csrfToken

  const methodInput = document.createElement("input")
  methodInput.type = "hidden"
  methodInput.name = "_method"
  methodInput.value = method

  form.appendChild(csrfInput)
  form.appendChild(methodInput)

  document.body.appendChild(form)
  form.submit()
})