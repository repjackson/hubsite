# Meteor.startup ->
#     reCAPTCHA.config
#         publickey: Meteor.settings.public.recaptcha_public

$.cloudinary.config
    cloud_name:"facet"

Template.registerHelper 'is_author', () ->  Meteor.userId() is @author_id

Template.registerHelper 'can_edit', () ->  Meteor.userId() is @author_id or Roles.userIsInRole(Meteor.userId(), 'admin')

Template.registerHelper 'publish_when', () -> moment(@publish_date).fromNow()


Template.registerHelper 'is_dev', () -> Meteor.isDevelopment


# ShareIt.configure
#     sites:
#         'facebook': 'appId': null
#         'twitter': {}
#         'googleplus': {}
#         'pinterest': {}
#     classes: 'ui button'
#     iconOnly: false
#     applyColors: true
#     faSize: ''
#     faClass: ''