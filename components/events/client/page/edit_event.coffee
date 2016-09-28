Template.edit_event.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'doc', FlowRouter.getParam('doc_id')


Template.edit_event.helpers
    event: ->
        Docs.findOne FlowRouter.getParam('doc_id')
    

        
        
Template.edit_event.events
    'click #save_event': ->
        start_datetime = $('#start_datetime').val()
        end_datetime = $('#end_datetime').val()
        
        Docs.update FlowRouter.getParam('doc_id'),
            $set:
                start_datetime: start_datetime
                end_datetime: end_datetime
                # tagCount: @tags.length
        # selected_tags.clear()
        # for tag in @tags
        #     selected_tags.push tag
        FlowRouter.go "/event/view/#{@_id}"




Template.edit_event.onRendered ->
    # Meteor.setTimeout (->
    #     $('#start_date').datetimepicker(
    #         onChangeDateTime: (dp,$input)->
    #             val = $input.val()

    #             # console.log moment(val).format("dddd, MMMM Do YYYY, h:mm:ss a")
    #             minute = moment(val).minute()
    #             hour = moment(val).format('h')
    #             date = moment(val).format('Do')
    #             ampm = moment(val).format('a')
    #             weekdaynum = moment(val).isoWeekday()
    #             weekday = moment().isoWeekday(weekdaynum).format('dddd')

    #             month = moment(val).format('MMMM')
    #             year = moment(val).format('YYYY')

    #             # datearray = [hour, minute, ampm, weekday, month, date, year]
    #             datearray = [weekday, month, date]
    #             datearray = _.map(datearray, (el)-> el.toString().toLowerCase())
    #             # datearray = _.each(datearray, (el)-> console.log(typeof el))

    #             doc_id = FlowRouter.getParam 'doc_id'

    #             event = Docs.findOne doc_id
    #             tagsWithoutDate = _.difference(event.tags, event.datearray)
    #             tagsWithNew = _.union(tagsWithoutDate, datearray)

    #             Docs.update doc_id,
    #                 $set:
    #                     tags: tagsWithNew
    #                     datearray: datearray
    #                     start_date: val
    #         )
            
    #     $('#end_date').datetimepicker()    
    #     ), 500