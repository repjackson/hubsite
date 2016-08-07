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

FlowRouter.route '/events', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'event_cloud'
        main: 'events'

FlowRouter.route '/wins', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'wins_challenges'

# FlowRouter.route '/editConversation/:docId', action: (params) ->
#     BlazeLayout.render 'layout',
#         main: 'conversation'


# Events

signInRequired.route '/events',
    name: 'events'
    action: ->
        BlazeLayout.render 'layout', main: 'events'
        setTitle 'Events'

signInRequired.route '/events/edit/:event_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_event'

signInRequired.route '/events/view/:event_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'view_event'




# Pages

FlowRouter.route '/partners', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'partners'

FlowRouter.route '/rent', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'rent'

FlowRouter.route '/about', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'about'