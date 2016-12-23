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
    found_id = Docs.findOne 
        author_id: @userId
        type: 'member_profile'
        
    
    if found_id
        # console.log 'found_id:', found_id
        return Docs.find found_id
    else
        profile_id = Meteor.call 'create_profile'
            
        # console.log 'new profile id:', profile_id
        return Docs.find profile_id
        
        
Meteor.methods
    'create_profile': (author_id)->
        created_profile_id = Docs.insert
            type: 'member_profile'
            
        # console.log 'created profile id', created_profile_id
        
        Docs.update created_profile_id,
            $set:
                author_id: Meteor.userId()
            
        updated_profile_doc = Docs.findOne created_profile_id
        
        # console.log 'updated profile doc', updated_profile_doc
        
        return created_profile_id