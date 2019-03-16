###*
 * Gridfw 
 * @copyright khalid RAFIK 2019
###
'use strict'
parseRange = require 'range-parser'
Busboy = require 'busboy'
RawBody= require 'raw-body'
Zlib = require 'zlib'
Iconv= require 'iconv-lite'
NativeFs = require 'fs'
fs		= require 'mz/fs'
Path	= require 'path'

#=include _settings.coffee
#=include _upload.coffee

REQUEST_PROTO=
	###*
	 * Parse Range header field, capping to the given `size`.
	 *
	 * Unspecified ranges such as "0-" require knowledge of your resource length. In
	 * the case of a byte range this is of course the total number of bytes. If the
	 * Range header field is not given `undefined` is returned, `-1` when unsatisfiable,
	 * and `-2` when syntactically invalid.
	 *
	 * When ranges are returned, the array has a "type" property which is the type of
	 * range that is required (most commonly, "bytes"). Each array element is an object
	 * with a "start" and "end" property for the portion of the range.
	 *
	 * The "combine" option can be set to `true` and overlapping & adjacent ranges
	 * will be combined into a single range.
	 *
	 * NOTE: remember that ranges are inclusive, so for example "Range: users=0-3"
	 * should respond with 4 users when available, not 3.
	 *
	 * @param {number} size
	 * @param {object} [options]
	 * @param {boolean} [options.combine=false]
	 * @return {number|array}
	 * @public
	 ###
	range: (size, options) ->
		range = @getHeader 'Range'
		if range
			parseRange size, range, options

	###*
	 * Upload post data
	 * @param {Object} options.limits - @see busboy limits
	 * @param {function} options.onError(error, ctx) - do what ever when got error, reject error to cancel process
	 * @return {promise}
	###
	upload: _uploadPostData


CONTEXT_PROTO=
	upload: _uploadPostData


class Uploader
	constructor: (@app)->
		@enabled = on # the plugin is enabled
	###*
	 * Reload parser
	###
	reload: (settings)->
		# Load settings
		_initSettings @app, settings
		# enable
		@enable()
		return
	###*
	 * destroy
	###
	destroy: -> @disable
	###*
	 * Disable, enable
	###
	disable: ->
		@app.removeProperties 'Uploader',
			Request: REQUEST_PROTO
			Context: CONTEXT_PROTO
		return
	enable: ->
		@app.addProperties 'Uploader',
			Request: REQUEST_PROTO
			Context: CONTEXT_PROTO
		return

module.exports = Uploader
