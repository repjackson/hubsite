Template.newsletter_sign_up.helpers



# Template.newsletter_sign_up.onCreated ->
#     self = @
#     self.autorun ->
#         self.subscribe 'featured_events'


Template.newsletter_sign_up.events
    'click #newsletter_sign_up': (e,t)->
        name = t.$('#name').val()
        email = t.$('#email').val()
        form_data = 
            name: name
            email: email
        # console.dir form_data
        #get the captcha data
        # captchaData = grecaptcha.getResponse()
        
        Docs.insert
            type: 'newsletter_sign_up'
            data: form_data
        , ->
            t.$('#name').val('')
            t.$('#email').val('')
            swal "Thank you, #{form_data.name}.", "You are signed up to the newsletter.", 'success'

        
        # Meteor.call 'formSubmissionMethod', form_data, captchaData, (error, result) ->
        #     # reset the captcha
        #     grecaptcha.reset()
        #     if error
        #         console.log 'There was an error: ' + error.reason
        #     else
        #         console.log 'Success!'
        #         Docs.insert
        #             type: 'submission'
        #             data: form_data
        #         , ->
        #             $('#name').val('')
        #             $('#email').val('')
        #             $('#message').val('')
        #     return
        # return
