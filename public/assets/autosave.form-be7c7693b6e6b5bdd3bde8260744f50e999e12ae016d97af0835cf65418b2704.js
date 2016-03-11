(function() {
  $(document).on('ready', function() {
    var editor, element, saveForm;
    element = document.querySelector('trix-editor');
    editor = element.editor;
    $('.save-message').hide();
    saveForm = function(event) {
      var form;
      form = $(event.target).parent('form');
      return $.ajax({
        dataType: 'json',
        url: form.attr('action'),
        method: form.attr('method'),
        data: form.serialize()
      }).done(function(response) {
        if (response.action) {
          $('form').attr('action', response.action);
          $('form').attr('method', response.method);
        }
        return $('.save-message').show().fadeOut(1000);
      });
    };
    return element.addEventListener('trix-change', $.debounce(1500, saveForm));
  });

}).call(this);
