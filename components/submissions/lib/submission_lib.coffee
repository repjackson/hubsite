@Submissions = new Meteor.Collection 'submissions'


Submissions.helpers
    author: -> Meteor.users.findOne @author_id

Submissions.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    return


Meteor.methods
    # add_submission: ()->
    #     Submissions.insert {}

    delete_submission: (id)->
        Submissions.remove id
