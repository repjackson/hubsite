Template.post_page.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'post', FlowRouter.getParam('post_id')
        # self.subscribe 'tags', selected_type_of_post_tags.array(),"post"


# Template.post_page.onRendered ->

Template.post_page.helpers
    post: ->
        # docId = FlowRouter.getParam('post_id')
        Docs.findOne FlowRouter.getParam('post_id')
