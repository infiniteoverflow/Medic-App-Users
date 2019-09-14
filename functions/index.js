const functions = require('firebase-functions');

const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

exports.sendNotification = functions.database.ref('Notifications/{post-id}')
.onWrite(
    (change,context) => {
        var request = change.after.val();
        var payload = {
            data:{
                username:"Aswin Gopinathan",
                email:"aswingopinathan1871@gmail.com"
            }
        };

        console.log("Hello",request);

        admin.messaging().sendToDevice(
            "cNgS8ui2J4A:APA91bEM9zrjlX2bW8c44BPbFlR-fNNs6AeYMmAxSUFy6MmRn1lKrvV9BN8GJF9MwMir1sqig_grZpRkwWZTudXWwrigcj0Ieib6a2VlPj8U7KBJ90xD1vt0r7WYrNmHo6HEE9ghVB9I" , payload
        )
        .then(
            function(response) {
                console.log("Successfull",response);
                return null;
            }
        )
        .catch(
            function(error) {
                console.log("Unsuccessful",error);
            }
        )
    }
);