# Meteor.startup ->
#     reCAPTCHA.config
#         publickey: Meteor.settings.public.recaptcha_public

$.cloudinary.config
    cloud_name:"facet"

Template.registerHelper 'is_author', () ->  Meteor.userId() is @author_id

Template.registerHelper 'can_edit', () ->  Meteor.userId() is @author_id or Roles.userIsInRole(Meteor.userId(), 'admin')
