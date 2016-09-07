Template.submissions.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'submissions'


Template.submissions.helpers
    submissions: -> 
        Docs.find {}
        
Template.submissions.events
    'click .remove_submission': ->
        self = @
        swal {
            title: "Remove Submission?"
            # text: 'You will not be able to recover this imaginary file!'
            type: 'warning'
            showCancelButton: true
            animation: false
            # confirmButtonColor: '#DD6B55'
            confirmButtonText: 'Remove'
            closeOnConfirm: true
        }, ->
            Docs.remove self._id
            # console.log self
            # swal "Submission Removed", "",'success'
            return
