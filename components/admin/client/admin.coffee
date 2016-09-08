Template.user_management.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'hub_users'


Template.user_management.helpers
    hub_users: -> 
        Meteor.users.find {}
        
    user_is_admin: -> 
        # console.log @
        Roles.userIsInRole(@_id, 'admin')


Template.user_management.events
    'click .remove_admin': ->
        self = @
        swal {
            title: "Remove #{@profile.name} from Admins?"
            # text: 'You will not be able to recover this imaginary file!'
            type: 'warning'
            animation: false
            showCancelButton: true
            # confirmButtonColor: '#DD6B55'
            confirmButtonText: 'Remove Privilages'
            closeOnConfirm: false
        }, ->
            Roles.removeUsersFromRoles self._id, 'admin'
            swal "Removed Admin Privilages from #{self.profile.name}", "",'success'
            return


    'click .make_admin': ->
        self = @
        swal {
            title: "Make #{@profile.name} an Admin?"
            # text: 'You will not be able to recover this imaginary file!'
            type: 'warning'
            animation: false
            showCancelButton: true
            # confirmButtonColor: '#DD6B55'
            confirmButtonText: 'Make Admin'
            closeOnConfirm: false
        }, ->
            Roles.addUsersToRoles self._id, 'admin'
            swal "Made #{self.profile.name} an Admin", "",'success'
            return






Template.admin.events
    'click #add_organization': ->
        id = Docs.insert 
            type: 'organization'
        FlowRouter.go "/organization/edit/#{id}"

    'click #add_post': ->
        id = Docs.insert 
            type: 'post'
        FlowRouter.go "/post/edit/#{id}"

