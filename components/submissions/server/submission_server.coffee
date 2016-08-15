Meteor.publish 'submissions', ->
    Docs.find type: 'submission'