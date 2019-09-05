const functions = require('firebase-functions');

const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

exports.sendNotification = functions.database.ref('Notifications/{post-id}')
.onWrite(
    event => {
        var request = event.data.val();
        var payload = {
            data:{
                username:"Aswin Gopinathan",
                email:"aswingopinathan1871@gmail.com"
            }
        };

        admin.messaging().sendToDevice(
            request.token , payload
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