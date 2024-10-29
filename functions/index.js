const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { GraphQLClient } = require('graphql-request');

// Inicializa o Firebase Admin
admin.initializeApp();

// Configuração do cliente GraphQL
const client = new GraphQLClient('https://excited-earwig-40.hasura.app/v1/graphql', {
    headers: {
        "content-type": "application/json",
        "x-hasura-admin-secret": "HtrkPpW1iXXZDVuphvEcyFgudA7ATUM6lzIwqvGUBGRWRoxu3DyJLNkApjyUjskG"
    }
});

exports.registerUser = functions.https.onCall(async (data, context) => {
    const email = data.email;
    const password = data.password;
    const displayName = data.displayName;

    if (email == null || password == null || displayName == null) {
        throw new functions.https.HttpsError('signup-failed', 'missing information');
    }

    try {
        const userRecord = await admin.auth().createUser({
            email: email,
            password: password,
            displayName: displayName
        });

        const customClaims = {
            "https://hasura.io/jwt/claims": {
                "x-hasura-default-role": "user",
                "x-hasura-allowed-roles": ["user"],
                "x-hasura-user-id": userRecord.uid
            }
        };

        await admin.auth().setCustomUserClaims(userRecord.uid, customClaims);
        return userRecord.toJSON();

    } catch (e) {
        throw new functions.https.HttpsError('signup-failed', JSON.stringify(e, undefined, 2));
    }
});

exports.processSignUp = functions.auth.user().onCreate(async (user) => {
    console.log("User created:", user);  // Adicione esta linha
    if (!user) {
        throw new functions.https.HttpsError('sync-failed', 'User data is undefined');
    }

    const id = user.uid;
    const email = user.email;
    const name = user.displayName || "No Name";

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
        });

        return data;
    } catch (e) {
        throw new functions.https.HttpsError('sync-failed', JSON.stringify(e, undefined, 2));
    }
});

exports.processDelete = functions.auth.user().onDelete(async (user) => {
    const mutation = `mutation($id: String!) {
        delete_user(where: {id: {_eq: $id}}) {
            affected_rows
        }
    }`;
    const id = user.uid;

    try {
        const data = await client.request(mutation, { id: id });
        return data;
    } catch (e) {
        throw new functions.https.HttpsError('sync-failed', JSON.stringify(e, undefined, 2));
    }
});
