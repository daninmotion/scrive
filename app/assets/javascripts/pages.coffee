jQuery ->
  $("#q").autocomplete(
    source: "/pages/autocomplete",
    minLength: 2
  )