import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "defaultContent", "guildContent", "name", "tag", "members", "createButton", "joinButton" ]

  connect() {
    console.log("Guilds Preview controller connected!")
  }

  show(event) {
    this.defaultContentTarget.style.display = 'none';
    this.guildContentTarget.style.display = 'block';

    this.joinButtonTarget.style.display = 'block';

    const guildName = event.currentTarget.dataset.guildName;
    const guildTag = event.currentTarget.dataset.guildTag;
    const guildMembers = event.currentTarget.dataset.guildMembers;
    const guildId = event.currentTarget.dataset.guildId;

    this.nameTarget.textContent = guildName;
    this.tagTarget.textContent = guildTag;
    this.membersTarget.textContent = guildMembers;

    const joinPath = `/guilds/${guildId}/join`;
    this.joinButtonTarget.formAction = joinPath;
  }
}
