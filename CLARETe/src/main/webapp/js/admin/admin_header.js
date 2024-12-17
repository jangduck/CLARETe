$('.header-nav > ul > li > ul > li').hover(e=>{
    $('.header-nav > ul > li > ul > li').css({
        'color': '',
        'background-color': ''
    });

    $(e.target).css({
        'color': '#3182CE',
        'background-color': '#EBF8FF'
    })
}, e=>{
    $(e.target).css({
        'color': '',
        'background-color': ''
    })
});