Template.edit_event.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'event', FlowRouter.getParam('event_id')


Template.edit_event.helpers
    event: ->
        Events.findOne FlowRouter.getParam('event_id')
    

        
        
Template.edit_event.events
    'click #save_event': ->
        # value = $('#description').val()
        # content = value.replace(/(<([^>]+)>)/ig, "")
        # console.log content
        title = $('#title').val()
        description = $('#description').val()
        simple_description = description.replace(/(<([^>]+)>)/ig, "")
        start_date = $('#start_date').val()
        location = $('#location').val()
        end_date = $('#end_date').val()
        Docs.update FlowRouter.getParam('event_id'),
            $set:
                title: title
                description: description
                start_date: start_date
                end_date: end_date
                location: location
                simple_description: simple_description
                # tagCount: @tags.length
        # selected_tags.clear()
        # for tag in @tags
        #     selected_tags.push tag
        FlowRouter.go "/event/view/#{@_id}"




Template.edit_event.onRendered ->
    Meteor.setTimeout (->
        $('#start_date').datetimepicker(
            onChangeDateTime: (dp,$input)->
                val = $input.val()

                # console.log moment(val).format("dddd, MMMM Do YYYY, h:mm:ss a")
                minute = moment(val).minute()
                hour = moment(val).format('h')
                date = moment(val).format('Do')
                ampm = moment(val).format('a')
                weekdaynum = moment(val).isoWeekday()
                weekday = moment().isoWeekday(weekdaynum).format('dddd')

                month = moment(val).format('MMMM')
                year = moment(val).format('YYYY')

                # datearray = [hour, minute, ampm, weekday, month, date, year]
                datearray = [weekday, month, date]
                datearray = _.map(datearray, (el)-> el.toString().toLowerCase())
                # datearray = _.each(datearray, (el)-> console.log(typeof el))

                event_id = FlowRouter.getParam 'event_id'

                event = Events.findOne event_id
                tagsWithoutDate = _.difference(event.tags, event.datearray)
                tagsWithNew = _.union(tagsWithoutDate, datearray)

                Events.update event_id,
                    $set:
                        tags: tagsWithNew
                        datearray: datearray
                        start_date: val
            )
            
        $('#end_date').datetimepicker()    
        ), 500