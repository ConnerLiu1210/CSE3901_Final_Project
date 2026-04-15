document.addEventListener('DOMContentLoaded', () => {
  console.log('Page loaded!')
  console.log('Hello, World!')
  const btn = document.getElementById('hello-btn')
  if (btn) {
    btn.addEventListener('click', () => {
      alert('Hello World!')
    })
  }
})
