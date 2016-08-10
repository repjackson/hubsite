@Post_tags = new Meteor.Collection 'post_tags'
@Posts = new Meteor.Collection 'posts'

Posts.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    return



Meteor.methods
    add_post: ()->
        Posts.insert
            tags: []

    delete_post: (id)->
        Posts.remove id

    remove_post_tag: (tag, doc_id)->
        Posts.update doc_id,
            $pull: tag

    add_post_tag: (tag, doc_id)->
        Posts.update doc_id,
            $addToSet: tags: tag