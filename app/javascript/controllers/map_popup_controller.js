import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup", "popupTitle", "popupButtons"]

  show(event) {
    event.preventDefault();
    event.stopPropagation();

    const itemElement = event.currentTarget;
    
    const profileName = itemElement.dataset.profileName;
    const interactionOptions = JSON.parse(itemElement.dataset.interactionOptions);

    this.popupTitleTarget.textContent = profileName;
    this.popupButtonsTarget.innerHTML = "";

    interactionOptions.forEach(option => {
      const link = document.createElement('a');
      link.href = option.path;
      link.className = `btn btn-sm ${option.class} mt-2 d-block`;
      link.textContent = option.text;
      this.popupButtonsTarget.appendChild(link);
    });
    
    this.popupTarget.style.left = `${event.pageX + 15}px`;
    this.popupTarget.style.top = `${event.pageY + 15}px`;
    this.popupTarget.style.display = 'block';
  }

  close() {
    this.popupTarget.style.display = 'none';
  }
}
