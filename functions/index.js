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
            request.To , payload
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