!function(){var e=$("#new-thread-button");$("#topic-select").on("change",function(){var o=$(this),t=o.find("option:selected").val();"choose"==t?e.addClass("disabled"):(e.removeClass("disabled"),"css"==t&&e.attr("href","/forums/forum/css-combat/#new-topic-0"),"design"==t&&e.attr("href","/forums/forum/design-den/#new-topic-0"),"js"==t&&e.attr("href","/forums/forum/javascript-jungle/#new-topic-0"),"php"==t&&e.attr("href","/forums/forum/php-problems/#new-topic-0"),"other"==t&&e.attr("href","/forums/forum/other-discussions/#new-topic-0"))})}();