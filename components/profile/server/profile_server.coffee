# Meteor.publish 'my_profile', ->
#     Meteor.users.find @userId,
#         fields:
#             tags: 1
#             profile: 1
#             username: 1
#             published: 1
#             image_id: 1


# Meteor.publish 'user_profile', (id)->
#     Meteor.users.find id,
#         fields:
#             tags: 1
#             profile: 1
#             username: 1
#             published: 1
#             image_id: 1


Meteor.publish 'user_profile', ->
    Meteor.users.find @userId


    
Meteor.publish 'view_profile', (user_id)->
    Meteor.users.find user_id
        # type: 'member_profile'
    
    # found_id = Docs.findOne 
    #     author_id: @userId
    #     type: 'member_profile'
        
    
    # if found_id
    #     console.log 'found_id:', found_id
    #     return Docs.find found_id
    # else
    #     profile_id = Meteor.call 'create_profile'
            
    #     console.log 'new profile id:', profile_id
    #     return Docs.find profile_id
        
        
Meteor.methods