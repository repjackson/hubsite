# Template.user_management.onCreated ->
#     self = @
#     self.autorun ->
#         self.subscribe 'hub_users'


Template.user_management.helpers
    hub_users: -> 
        Meteor.users.find {}

Template.add_user.events
    'click #submit_new_user': ->
        name = $('#name').val()
        email = $('#email').val()
        bio = $('#bio').val()
        