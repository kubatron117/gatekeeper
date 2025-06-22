import consumer from "channels/consumer"

function fadeOutAndRemove(element, duration = 500) {
  element.classList.remove('opacity-100');
  element.classList.add('opacity-0');
  setTimeout(() => element.remove(), duration);
}

function createToast(message) {
  const container = document.getElementById("toast-container");
  const toast = document.createElement("div");
  toast.className =
      "toast space-y-3 absolute z-100 top-0 right-0 p-4 w-full max-w-sm opacity-100 " +
      "transition-opacity duration-500 ease-out";
  toast.innerHTML = `
    <div class="max-w-xs bg-white border border-gray-200 rounded-xl shadow-lg" 
         role="alert" tabindex="-1" aria-labelledby="toast-label">
      <div class="flex p-4">
        <div class="shrink-0">
          <!-- ikona -->
        </div>
        <div class="ms-3">
          <p id="toast-label" class="text-sm text-gray-700">${message}</p>
        </div>
      </div>
    </div>
  `;
  container.appendChild(toast);

  // fade-out po 3s
  setTimeout(() => fadeOutAndRemove(toast), 3000);
}

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    console.log("NotificationsChannel connected")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("Received data:", data)
    createToast(data.message)
  }
});
