import consumer from "./consumer"
 


consumer.subscriptions.create(
    { channel: "ChatChannel", room: "Best Room" },
    { 
      connect(){console.log('connect')
      chatChannel.send({sent_by: 'okokok'})
    }
    },
    { received(data){ 
        console.log('hi')
        console.log(data)
    } }
    )

   
// consumer.subscriptions.create({ channel: "ChatChannel", room: "1st Room" })
// consumer.subscriptions.create({ channel: "ChatChannel", room: "2nd Room" })