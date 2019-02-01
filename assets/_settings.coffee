### default settings ###
_initSettings = <%= initSettings %>
	timeout: # upload timeout
		default: 10 * 60 * 1000 # 10min
		check: (tmout)->
			throw "Expected >0 or Infinity" unless (tmout is Infinity) or Number.isSafeInteger(tmout) and tmout > 0
	tmpDir:
		default: require('os').tmpdir()
		check: (dir)-> throw "Expected string" unless typeof dir is 'string'
	limits:
		default:
			size: 20 * (2**20) # Max body size (20M)
			fieldNameSize: 1000 # Max field name size (in bytes)
			fieldSize: 2**20 # Max field value size (default 1M)
			fields: 1000 # Max number of non-file fields
			fileSize: 10 * (2**20) # For multipart forms, the max file size (in bytes) (default 10M)
			files: 100 # For multipart forms, the max number of file fields
			parts: 1000 # For multipart forms, the max number of parts (fields + files) 
			headerPairs: 2000 # For multipart forms, the max number of header 
		check: (limits)->
			throw new Error "Expected Object" unless limits and typeof limits is 'object'
			reqFields = []
			for field in ['fieldNameSize', 'fieldSize', 'fields', 'fileSize', 'files', 'parts', 'headerPairs']
				if field of limits
					v = limits[field]
					throw new Error "#{field} expected positive integer" unless v is Infinity or Number.isInteger(v) and v > 0
				else
					reqFields.push field
			throw new Error "Required fields: #{reqFields.join ', '}" if reqFields.length
			return
	