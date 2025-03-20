//necessário ter o Firebase CLI instalado
const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");

//necessário fazer o npm install --save graphql-request
const request = require("graphql-request");

admin.initializeApp(functions.config().firebase);

const client = new request.GraphQLClient("https://excited-earwig-40.hasura.app/v1/graphql", {
    headers: {
        "content-type": "application/json",
        "x-hasura-admin-secret": "HtrkPpW1iXXZDVuphvEcyFgudA7ATUM6lzIwqvGUBGRWRoxu3DyJLNkApjyUjskG"
    }
});

// REGISTER USER WITH REQUIRED CUSTOM CLAIMS
exports.registerUser = functions.https.onCall(async (data, context) => {
    // 🔥 Remova essa verificação pois estamos criando um usuário
    // if (!context.auth) {
    //     throw new functions.https.HttpsError(
    //         "unauthenticated",
    //         "O usuário deve estar autenticado para chamar esta função."
    //     );
    // }

    const email = data.email;
    const password = data.password;
    const displayName = data.displayName;

    if (!email || !password || !displayName) {
        throw new functions.https.HttpsError(
            "invalid-argument",
            "missing information"
        );
    }

    try {
        var userRecord = await admin.auth().createUser({
            email: email,
            password: password,
            displayName: displayName,
        });

        const customClaims = {
            "https://hasura.io/jwt/claims": {
                "x-hasura-default-role": "user",
                "x-hasura-allowed-roles": ["user"],
                "x-hasura-user-id": userRecord.uid,
            },
        };

        await admin.auth().setCustomUserClaims(userRecord.uid, customClaims);
        return userRecord.toJSON();
    } catch (e) {
        throw new functions.https.HttpsError(
            "signup-failed",
            JSON.stringify(e, undefined, 2)
        );
    }
});

// SYNC WITH HASURA ON USER CREATE
exports.processSignUp = functions.auth.user().onCreate(async (user) => {
    const id = user.uid;
    const email = user.email;
    const name = user.displayName || "No Name";

    if (id == null || email == null || name == null) {
        throw new functions.https.HttpsError('sync-failed', 'missing information');
    }

    const mutation = `mutation($id: String!, $email: String, $name: String) {
        insert_user(objects: [{
            id: $id,
            email: $email,
            name: $name,
          }]) {
            affected_rows
          }
        }`;

    try {
        const data = await client.request(mutation, {
            id: id,
            email: email,
            name: name
        })

        return data;

    } catch (error) {
        console.error('Error processing sign up:', error);
        throw new functions.https.HttpsError('internal', 'Error processing sign up.');
    }

});

// SYNC WITH HASURA ON USER DELETE
exports.processDelete = functions.auth.user().onDelete(async (user) => {
    const mutation = `mutation($id: String!) {
        delete_user(where: {id: {_eq: $id}}) {
            affected_rows
        }
    }`;

    const id = user.uid;

    try {
        const data = await client.request(mutation, {
            id: id,
        });
        return data;
    } catch (e) {
        throw new functions.https.HttpsError("sync-failed");
    }
});
