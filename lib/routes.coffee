signInRequired = FlowRouter.group(triggersEnter: [ AccountsTemplates.ensureSignedIn ])


FlowRouter.route '/', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        # cloud: 'cloud'
        main: 'home'
        footer: 'footer'



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

FlowRouter.route '/host-meeting', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'host_meeting'

FlowRouter.route '/about', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'about'
        
FlowRouter.route '/join', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'join'
        
FlowRouter.route '/permanent-desk-program', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'permanent'
        
FlowRouter.route '/permanent-desk-application', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'permanent_application'
        
