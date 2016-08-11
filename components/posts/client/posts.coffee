Template.posts.onCreated ->
    @autorun -> Meteor.subscribe('posts', selected_post_tags.array())

Template.posts.helpers
    posts: -> 
        Posts.find {}

Template.posts.events



# Single
# Template.post.onCreated ->
#     @autorun -> Meteor.subscribe('post_messages', Template.currentData()._id)
#     @autorun -> Meteor.subscribe('usernames')

Template.post.helpers
    post_tag_class: -> if @valueOf() in selected_post_tags.array() then 'red' else 'basic'

    can_edit: -> @author_id is Meteor.userId()

    post_messages: -> Messages.find post_id: @_id



Template.post.events
    'click .post_tag': ->
        if @valueOf() in selected_post_tags.array() then selected_post_tags.remove @valueOf() else selected_post_tags.push @valueOf()


    'keydown .addMessage': (e,t)->
        e.preventDefault
        if e.which is 13
            text = t.find('.addMessage').value.trim()
            if text.length > 0
                Meteor.call 'add_event_message', text, @_id, (err,res)->
                    t.find('.addMessage').value = ''

    'click .edit_post': ->
        FlowRouter.go "/posts/edit/#{@_id}"
