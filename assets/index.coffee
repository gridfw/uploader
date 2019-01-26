###*
 * Gridfw 
 * @copyright khalid RAFIK 2019
###
'use strict'

class Cookie
	constructor: (@app)->
		@enabled = on # the plugin is enabled
	###*
	 * Reload parser
	###
	reload: (settings)->
		# enable
		@enable()
		return
	###*
	 * destroy
	###
	destroy: ->
		return
	###*
	 * Disable, enable
	###
	disable: -> @destroy
	enable: ->
		return

module.exports = Cookie