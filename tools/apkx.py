#!/usr/bin/python
#
# apkx -- A Python wrapper for popular dex converters and Java decompilers.
# Because nobody likes messing with Java classpaths & jar command lines.
# v0.9.2
#
# Author: Bernhard Mueller
# This file is part of the OWASP Mobile Testing Guide (https://github.com/OWASP/owasp-mstg)
#
# See also:
#
# Dex2jar - https://github.com/pxb1988/dex2jar
# CFR - http://www.benf.org/other/cfr/
# 
# This program is free software: you can redistribute it and/or modify  
# it under the terms of the GNU General Public License as published by  
# the Free Software Foundation, version 3.

import os
import sys
import subprocess
import zipfile
import re
import argparse

cwd = os.path.dirname(os.path.realpath(__file__))
FNULL = open(os.devnull, 'w')

def convert(converter, lib_path, ext_path, infile, outfile):

	if (converter == 'dex2jar'):
		subprocess.call(['java', '-Xms512m', '-Xmx1024m', '-cp', lib_path, 'com.googlecode.dex2jar.tools.Dex2jarCmd', ext_path + '/' + infile, '-o', ext_path + '/' + outfile, '-f'])
	elif (converter == 'enjarify'):
		subprocess.call([cwd + '/enjarify.pex', ext_path + '/' + infile, '-o', ext_path + '/' + outfile, '--force'])

def decompile(decompiler, lib_path, ext_path, jar_filename):

	if (decompiler == 'cfr'):
		subprocess.call(['java','-Xms512m', '-Xmx1024m', '-cp', lib_path, 'org.benf.cfr.reader.Main', ext_path + '/' + jar_filename, '--outputdir', src_path, '--caseinsensitivefs', 'true', '--silent', 'true'], stdout=FNULL)
	elif (decompiler == 'procyon'):
		subprocess.call(['java','-Xms512m', '-Xmx1024m', '-cp', lib_path, 'com.strobel.decompiler.DecompilerDriver', '-jar', ext_path + '/' + jar_filename, '--o', src_path], stdout=FNULL)


'''
====== Main ======
'''

parser = argparse.ArgumentParser(description='Decompile an Android APK archive.')

parser.add_argument('-c', '--converter', help='Dex to jar conversion method (default: dex2jar)', choices=['dex2jar','enjarify'], default = "dex2jar")
parser.add_argument('-d', '--decompiler', help='Decompiler backend to use (default: cfr)', choices=['cfr','procyon'], default = "cfr")
parser.add_argument('apkfile', help='File to decompile')

args = parser.parse_args()

'''
	Unzip the application package.
'''

ext_path = os.path.splitext(os.path.basename(args.apkfile))[0]
src_path = ext_path + "/src"

lib_path = cwd + "/apkx-libs.jar"

print("Extracting " + args.apkfile + " to " + ext_path)

try:
	zip_ref = zipfile.ZipFile(args.apkfile, 'r')
	zip_ref.extractall(ext_path)
	zip_ref.close()
except IOError as e:
	print("Error extracting apk: " + str(e))
	sys.exit(0)

'''
	Iterate over all .dex files
'''

for root, dirs, files in os.walk(ext_path):
	for file in files:
		if file.endswith((".dex")):
			jar_filename = os.path.splitext(file)[0] + ".jar"

			print('Converting: ' + file + ' -> ' + jar_filename + ' (' + args.converter + ')')

			'''
				Conversion Step
			'''

			try:
				convert(args.converter, lib_path, ext_path, file, jar_filename)
			except Exception as e:
				print('Error converting dex to jar:'+ str(e))
				next

			'''
				Decompilation Step
			'''

			print("Decompiling to " + src_path  + ' (' + args.decompiler + ')')

			try:
				decompile(args.decompiler, lib_path, ext_path, jar_filename)
			except Exception as e:
				print('Error decompiling:' + str(e))
