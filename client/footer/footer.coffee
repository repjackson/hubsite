Template.footer.helpers
    footer: Docs.find()



# Template.footer.onCreated ->
#     self = @
#     self.autorun ->
#         self.subscribe 'featured_events'


Template.footer.events
    'click #submit_contact_form': ->
        name = $('#name').val()
        email = $('#email').val()
        message = $('#message').val()
        form_data = 
            name: name
            email: email
            message: message
        console.dir form_data
        #get the captcha data
        captchaData = grecaptcha.getResponse()
        Meteor.call 'formSubmissionMethod', form_data, captchaData, (error, result) ->
            # reset the captcha
            grecaptcha.reset()
            if error
                console.log 'There was an error: ' + error.reason
            else
                console.log 'Success!'
                Docs.insert
                    type: 'submission'
                    data: form_data
                , ->
                    $('#name').val('')
                    $('#email').val('')
                    $('#message').val('')
            return
        return
