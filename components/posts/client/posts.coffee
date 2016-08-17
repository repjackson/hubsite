Template.posts.onCreated ->
    @autorun -> Meteor.subscribe('docs', selected_tags.array(), 'post')

Template.posts.helpers
    posts: -> Docs.find {}



Template.post.helpers
    post_tag_class: -> if @valueOf() in selected_tags.array() then 'red' else 'basic'

    can_edit: -> @author_id is Meteor.userId()

    post_messages: -> Messages.find post_id: @_id

    publish_when: -> moment(@publish_date).fromNow()

Template.post.events
    'click .post_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()


    'keydown .addMessage': (e,t)->
        e.preventDefault
        if e.which is 13
            text = t.find('.addMessage').value.trim()
            if text.length > 0
                Meteor.call 'add_event_message', text, @_id, (err,res)->
                    t.find('.addMessage').value = ''

    'click .edit_post': ->
        FlowRouter.go "/posts/edit/#{@_id}"
