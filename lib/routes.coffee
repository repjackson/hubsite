signInRequired = FlowRouter.group(triggersEnter: [ AccountsTemplates.ensureSignedIn ])


FlowRouter.route '/', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        # cloud: 'cloud'
        main: 'home'

FlowRouter.route '/profile', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'profile'


FlowRouter.route '/people', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'people'

FlowRouter.route '/messages', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'messagePage'

FlowRouter.route '/conversations', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'conversation_cloud'
        main: 'conversations'


FlowRouter.route '/wins', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'wins_challenges'

# FlowRouter.route '/editConversation/:docId', action: (params) ->
#     BlazeLayout.render 'layout',
#         main: 'conversation'




# Events

FlowRouter.route '/events', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'event_cloud'
        main: 'events'

signInRequired.route '/events/edit/:event_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_event'

FlowRouter.route '/events/view/:event_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'event_page'




# Posts

FlowRouter.route '/posts', action: ->
    BlazeLayout.render 'layout', 
        cloud: 'post_cloud'
        main: 'posts'

signInRequired.route '/posts/edit/:post_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_post'

FlowRouter.route '/posts/view/:post_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'post_page'




# Pages

FlowRouter.route '/partners', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'partners'

FlowRouter.route '/academy', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'academy'

FlowRouter.route '/rent', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'rent'

FlowRouter.route '/about', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'about'
        
FlowRouter.route '/become_member', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'become_member'