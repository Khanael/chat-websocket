import { Controller } from '@hotwired/stimulus'
import { createConsumer } from '@rails/actioncable'

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static values = {
    chatroomId: Number,
    currentUserId: Number,
  }
  static targets = ['messages']

  connect() {
    console.log(this.currentUserIdValue)
    this.channel = createConsumer().subscriptions.create(
      { channel: 'ChatroomChannel', id: this.chatroomIdValue },
      {
        received: (data) => {
          this.#insertMessageAndScrollDown(data.json)
        },
      }
    )

    console.log(
      `Subscribe to the chatroom with the id ${this.chatroomIdValue}.`
    )
  }

  #insertMessageAndScrollDown(json) {
    console.log(json)
    const senderUserId = json.user.id
    console.log(senderUserId)
    console.log(this.currentUserIdValue)
    let className = ''
    if (senderUserId === this.currentUserIdValue) {
      className = 'my-message'
    }
    const html = `<div class="message ${className}">
      <div>
        <p class="message--nickname"><b>${json.user.nickname}</b>
          -
          <i>${new Date(json.message.created_at).toLocaleTimeString('fr-FR', {
            hour: '2-digit',
            minute: '2-digit',
          })}</i></p>

      </div>
      <p>${json.message.content}</p>
    </div>
    `
    this.messagesTarget.insertAdjacentHTML('beforeend', html)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log('Unsubscribed from the chatroom')
    this.channel.unsubscribe()
  }
}
