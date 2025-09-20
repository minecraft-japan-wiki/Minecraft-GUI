mw.hook("wikipage.content").add(function () {
    'use strict';

    const tankElements = $(".mjwgui .mjwgui-tank");
    tankElements.each(function (i) {
        try {
            const tankElement = $(this);
            const tankInner = tankElement.find(".mjwgui-tank-inner");
            if (tankInner.length) {
                const tankHeight = tankInner.height();
                const tankWidth = tankInner.width();
                const count = Math.ceil(tankHeight / 32) * Math.ceil(tankWidth / 32);
                console.log(tankHeight, tankWidth, count);

                let spriteLink = tankElement.find(".mjwgui-tank-item > a");
                if (spriteLink.length) {
                    const cloneLink = spriteLink.clone(true, true);
                    tankInner.append(cloneLink);

                    const item = cloneLink.find("*");
                    for (let i = 0; i < (count - 1); i++) {
                        let cloneItem = item.clone(true, true);
                        cloneLink.append(cloneItem);
                    }
                    cloneLink.addClass("mjwgui-tank-item-container");
                } else {
                    let spriteItem = tankElement.find(".mjwgui-tank-item > *");
                    for (let i = 0; i < count; i++) {
                        tankInner.append(spriteItem.clone(true, true));
                    }
                    tankInner.addClass("mjwgui-tank-item-container");
                }
            }
        } catch (e) {
        }
    });
})();