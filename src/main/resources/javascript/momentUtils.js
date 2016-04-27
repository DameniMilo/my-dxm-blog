/**
 * This function will get all the elements with the class momentToFormat and parse, format, etc... them
 * And output the result in the element.
 * To work properly this function require some data attributes, object to parse must have :
 * - class "momentToFormat".
 * - data attribute "data-moment" which must contains the date/time in ISO-8601 format "yyyy-MM-dd'T'HH:mm:ssZ"
 * to work properly, otherwise moment will throw a message in your browser console.
 * JSP Digital Factory example : <fmt:formatDate value="${currentNode.properties['jcr:lastModified'].date.time}" pattern="yyyy-MM-dd'T'HH:mm:ssZ"/>
 * - data attribute "data-moment-display-type-type" which can be calendar, fromNow or format.
 *
 * Optional/conditional parameters :
 * - data attribute "data-moment-locale" if you want to display in a particular locale
 * - data attribute "data-moment-format" if you choose to display format this attribute will be required,
 * if not set default output will be "LLLL". This attribute will also be use for fromNow in this case the value can be true or false.
 *
 * @author  : dgaillard
 * @created : 30/04/2015
 */
function refreshMoment() {
    var elements = document.getElementsByClassName('momentToFormat');

    for (var i = 0; i < elements.length ; i++) {
        var element = elements[i];
        var elementMoment = moment(element.dataset.moment);

        if (element.dataset.momentLocale) {
            elementMoment = elementMoment.locale(element.dataset.momentLocale);
        }

        if (element.dataset.momentDisplayType === 'calendar') {
            element.innerHTML = elementMoment.calendar();
        } else if (element.dataset.momentDisplayType === 'fromNow') {
            if (element.dataset.momentFormat) {
                element.innerHTML = elementMoment.fromNow(element.dataset.momentFormat);
            } else {
                element.innerHTML = elementMoment.fromNow();
            }
        } else if (element.dataset.momentDisplayType === 'format') {
            var format = element.dataset.momentFormat?element.dataset.momentFormat:"LLLL";
            element.innerHTML = elementMoment.format(format);
        }
    }
}

/**
 * This function must be place in the document ready and will refresh moment every interval
 * @param interval  : int, time in millisecond (60000 = 1 minute)
 */
function refreshMomentEvery(interval) {
    setInterval(function() { refreshMoment() }, interval);
}
