Meteor.methods
    add_submission: ()->
        Docs.insert
            type: 'submission'
