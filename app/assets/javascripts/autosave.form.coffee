# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready', ->
  element = document.querySelector('trix-editor')
  editor = element.editor

  $('.save-message').hide()

  saveForm = (event) ->
    form = $(event.target).parent('form')

    $.ajax({
      dataType: 'json',
      url: form.attr('action'),
      method: form.attr('method'),
      data: form.serialize()
    })
    .done (response) ->
      if response.action
        $('form').attr('action', response.action)
        $('form').attr('method', response.method)

      $('.save-message').show().fadeOut(1000)

  element.addEventListener 'trix-change', $.debounce(1500, saveForm)