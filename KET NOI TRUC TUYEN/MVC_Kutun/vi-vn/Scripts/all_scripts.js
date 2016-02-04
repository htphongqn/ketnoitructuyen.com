//CarouFedsel
$( function(){    	
		//Nivo Slide Responsive
		//$('#slider').nivoSlider();
		
		$('#slide_viewed_P ul').carouFredSel({
					prev: '#prev_viewed',
					next: '#next_viewed',				
					auto: 5000,
					direction: 'up',
					scroll : {
						items	: 1,
			            pauseOnHover: true
        			},
					speed: 2000,
					duration: 8000,	
					items: {				
						visible: {
							min: 1,
							max: 3
						}
					}
				});
		$('#slide_liked_P ul').carouFredSel({
            prev: '#prev_liked',
            next: '#next_liked',
			auto: 5000,
            scroll: {
                items: 1,
                pauseOnHover: true
            },
            speed: 2000,
            duration: 3000,
            items: {
                visible: {
                    min: 1,
                    max: 1
                }
            }
        });
		$('#popular_products ul').carouFredSel({
            prev: '#prev_popularP',
            next: '#next_popularP',
			auto 	: { pauseDuration : 300000, duration: 1000},
            scroll: {
                items: 3,
                pauseOnHover: true
            },
            speed: 2000,
            duration: 3000,
            items: {
                visible: {
                    min: 1,
                    max: 6
                }
            }
        });
		$('#recently_viewed_products ul').carouFredSel({
            prev: '#prev_recently_view',
            next: '#next_recently_view',
			auto 	: { pauseDuration : 3000, duration: 1000},
            scroll: {
                items: 3,
                pauseOnHover: true
            },
            speed: 2000,
            duration: 3000,
            items: {
                visible: {
                    min: 1,
                    max: 6
                }
            }
        });
		$('#recently_liked_products ul').carouFredSel({
            prev: '#prev_recently_like',
            next: '#next_recently_like',
			auto 	: { pauseDuration : 3000, duration: 1000},
            scroll: {
                items: 3,
                pauseOnHover: true
            },
            speed: 2000,
            duration: 3000,
            items: {
                visible: {
                    min: 1,
                    max: 6
                }
            }
        });
		$('#buyed_products ul').carouFredSel({
            prev: '#prev_buyedP',
            next: '#next_buyedP',
			auto 	: { pauseDuration : 3000, duration: 1000},
            scroll: {
                items: 3,
                pauseOnHover: true
            },
            speed: 2000,
            duration: 3000,
            items: {
                visible: {
                    min: 1,
                    max: 6
                }
            }
        });
		$('#updated_products ul').carouFredSel({
            prev: '#prev_updatedP',
            next: '#next_updatedP',
			auto 	: { pauseDuration : 3000, duration: 1000},
            scroll: {
                items: 3,
                pauseOnHover: true
            },
            speed: 2000,
            duration: 3000,
            items: {
                visible: {
                    min: 1,
                    max: 6
                }
            }
        });
		$('#saleoff_products ul').carouFredSel({
            prev: '#prev_saleoffP',
            next: '#next_saleoffP',
			auto 	: { pauseDuration : 3000, duration: 1000},
            scroll: {
                items: 3,
                pauseOnHover: true
            },
            speed: 2000,
            duration: 3000,
            items: {
                visible: {
                    min: 1,
                    max: 6
                }
            }
        });
		$('#sl_logo_trademark ul').carouFredSel({
					prev: '#prev_trademark',
					next: '#next_trademark',					  				  				  
					auto 	: { pauseDuration : 4000, duration: 1000},
					scroll: {
						items: 1,
						pauseOnHover: true
					},
					speed: 2000,
					duration: 3000,
					items: {
						visible: {
							min: 1,
							max: 8
						}
					}
				});
		$('#sl_adsbottom ul').carouFredSel({
					prev: '#prev_adsbot',
					next: '#next_adsbot',					  				  				  
					auto 	: { pauseDuration : 5000, duration: 1000},
					scroll: {
						items: 1,
						pauseOnHover: true
					},
					speed: 2000,
					duration: 3000,
					items: {
						visible: {
							min: 1,
							max: 6
						}
					}								
				});
//		$('#sl_logobank ul').carouFredSel({									  				  				  
//					auto 	: { pauseDuration : 5000, duration: 1000},
//					scroll: {
//						items: 1,
//						pauseOnHover: true
//					},
//					speed: 2000,
//					duration: 3000,
//					items: {
//						visible: {
//							min: 1,
//							max: 9
//						}
//					}
//				});
		$('.zoom-desc ul').carouFredSel({
					prev: '#prev_dtp',
					next: '#next_dtp',					  				  				  
					auto 	: { pauseDuration : 5000, duration: 1000},
					scroll: {
						items: 1,
						pauseOnHover: true
					},
					speed: 2000,
					duration: 3000,
					items: {
						visible: {
							min: 1,
							max: 4
						}
					}
				});
		$('#thesame_products ul').carouFredSel({
            prev: '#prev_thesameP',
            next: '#next_thesameP',
			auto 	: { pauseDuration : 4000, duration: 1000},
            scroll: {
                items: 1,
                pauseOnHover: true
            },
            speed: 2000,
            duration: 3000,
            items: {
                visible: {
                    min: 1,
                    max: 4
                }
            }
        });
        $('#thesame_products_hang ul').carouFredSel({
            prev: '#prev_thesameP_hang',
            next: '#next_thesameP_hang',
            auto: { pauseDuration: 5000, duration: 1000 },
            scroll: {
                items: 1,
                pauseOnHover: true
            },
            speed: 2000,
            duration: 3000,
            items: {
                visible: {
                    min: 1,
                    max: 4
                }
            }
        });
			
});	

$(document).ready(function () {
        $(".tab_content").hide();
        $(".tab_content:first").show();

        $("ul.tabs_menu li").click(function () {
            $("ul.tabs_menu li").removeClass("active");
            $(this).addClass("active");
            $(".tab_content").hide();
            var activeTab = $(this).attr("rel");
            $("#" + activeTab).fadeIn();
        });
    }); 