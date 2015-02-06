# Dropzone Action Info
# Name: QuickCleanup
# Description: Cleanup a folder based on a extension
# Handles: Files
# Events: Dragged
# Creator: Michael Evans
# URL: http://sites.udel.edu/mdevans
# Version: 1.0
# RunsSandboxed: No
# UniqueID: 55
# MinDropzoneVersion: 3.0

def dragged

	require 'fileutils'

	ext = $dz.inputbox("Extension", "Please enter the file extension", "Extension")
	ext = ext.chomp
	ext = ext.tr('.','')
	count = 0
	$items.each do |dirName|

		if File.directory?(dirName)

			newDir = ext+"s"

			ext = "*."+ext

			Dir.mkdir(dirName+"/"+newDir) unless File.exists?(dirName+"/"+newDir)
			$dz.begin("moving files")
			searchPath = dirName + '/**/'+ ext
			Dir[searchPath].reject{ |f| f[dirName+'/'+newDir]}.each do |filename|
				if File.file?(filename)
					
					if (FileUtils.mv(filename, dirName+"/"+newDir) unless File.exists?(dirName+"/"+newDir+"/"+File.basename(filename)))
						count+=1
					end
				end
			end

		end

	end
	$dz.finish("moved #{count} files")
	$dz.url(false)
end
