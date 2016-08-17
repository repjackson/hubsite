signInRequired = FlowRouter.group(triggersEnter: [ AccountsTemplates.ensureSignedIn ])


FlowRouter.route '/', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        # cloud: 'cloud'
        main: 'home'
        footer: 'footer'


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
        
