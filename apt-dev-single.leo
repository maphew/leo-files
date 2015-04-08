<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<?xml-stylesheet ekr_test?>
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="maphew.20150327024431.4" a="E"><vh>./apt</vh>
<v t="maphew.20150402222826.2"><vh>@auto build-exe.bat</vh></v>
<v t="maphew.20150402222826.3"><vh>@auto build-release-pkg.bat</vh></v>
<v t="maphew.20150327024628.2" a="E"
expanded="maphew.20100302221232.1487,maphew.20100223163802.3724,maphew.20100223163802.3727,maphew.20100302221232.1485,maphew.20100308085005.1379,maphew.20100223163802.3739,maphew.20100308085005.1380,maphew.20100308085005.1381,maphew.20100308085005.1382,"><vh>@file apt.py</vh></v>
<v t="maphew.20150330213839.2"><vh>Info</vh>
<v t="maphew.20141101125304.3"><vh>info</vh></v>
<v t="maphew.20141111130056.4"><vh>get_info</vh></v>
<v t="maphew.20100223163802.3754"><vh>parse_setup_ini</vh></v>
</v>
</v>
<v t="maphew.20150402222826.4"><vh>@persistence</vh>
<v t="maphew.20150402222826.5"><vh>@data:@auto build-release-pkg.bat</vh>
<v t="maphew.20150402222826.7"><vh>@gnxs</vh></v>
</v>
</v>
<v t="maphew.20150403193730.1"><vh>Recovered Nodes</vh>
<v t="maphew.20150403193730.10"><vh>Recovered node "info from @file apt.py</vh>
<v t="maphew.20150403193730.5"><vh>old:info</vh></v>
<v t="maphew.20150403193730.8"><vh>new:info</vh></v>
</v>
<v t="maphew.20150403193730.2"><vh>Recovered node "get_info from @file apt.py</vh>
<v t="maphew.20150403193730.9"><vh>old:get_info</vh></v>
<v t="maphew.20150403193730.7"><vh>new:get_info</vh></v>
</v>
<v t="maphew.20150403193730.3"><vh>Recovered node "parse_setup_ini from @file apt.py</vh>
<v t="maphew.20150403193730.4"><vh>old:parse_setup_ini</vh></v>
<v t="maphew.20150403193730.6"><vh>new:parse_setup_ini</vh></v>
</v>
</v>
<v t="maphew.20150404102108.3" a="E"><vh>Recovered Nodes</vh>
<v t="maphew.20150404102108.7"><vh>Recovered node "info from @file apt.py</vh>
<v t="maphew.20150404102108.9"><vh>old:info</vh></v>
<v t="maphew.20150404102108.5"><vh>new:info</vh></v>
</v>
<v t="maphew.20150404102108.4"><vh>Recovered node "get_info from @file apt.py</vh>
<v t="maphew.20150404102108.2"><vh>old:get_info</vh></v>
<v t="maphew.20150404102108.1"><vh>new:get_info</vh></v>
</v>
<v t="maphew.20150404102108.10"><vh>Recovered node "parse_setup_ini from @file apt.py</vh>
<v t="maphew.20150404102108.6"><vh>old:parse_setup_ini</vh></v>
<v t="maphew.20150404102108.8"><vh>new:parse_setup_ini</vh></v>
</v>
</v>
<v t="maphew.20150404102108.11" a="E"><vh>Recovered Nodes</vh>
<v t="maphew.20150404102108.12"><vh>Recovered node "&lt;&lt;imports&gt;&gt; from @file apt.py</vh>
<v t="maphew.20150404102108.13"><vh>old:&lt;&lt;imports&gt;&gt;</vh></v>
<v t="maphew.20150404102108.14"><vh>new:&lt;&lt;imports&gt;&gt;</vh></v>
</v>
<v t="maphew.20150404102108.15"><vh>Recovered node "install from @file apt.py</vh>
<v t="maphew.20150404102108.16"><vh>old:install</vh></v>
<v t="maphew.20150404102108.17"><vh>new:install</vh></v>
</v>
<v t="maphew.20150404102108.18"><vh>Recovered node "get_new from @file apt.py</vh>
<v t="maphew.20150404102108.19"><vh>old:get_new</vh></v>
<v t="maphew.20150404102108.20"><vh>new:get_new</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="maphew.20100223163802.3754">def parse_setup_ini(fname):
    '''Parse setup.ini into package name, description, version, dependencies, etc.
    
    Args:
        fname: full path to setup.ini
            
    Returns:
        A nested dictionary: {Distribution {Program_name{['category', 'source', 'ldesc', 'version', 'install', 'sdesc', 'requires']}}}
    
        {curr {
            'gdal' {
                'name': 'gdal',
                'version': '1.11.1-4',
                'category': 'Libs Commandline_Utilities',
                etc... }
            }}
    '''
    # global dists
    dists = {'test': {}, 'curr': {}, 'prev': {}}
    
    chunks = string.split(open(fname).read(), '\n\n@ ')
    for i in chunks[1:]:
        lines = string.split(i, '\n')
        name = string.strip(lines[0])
        if debug and verbose:
            print 'package: ' + name
        packages = dists['curr']
        records = {'sdesc': name}
        j = 1
        while j &lt; len(lines) and string.strip(lines[j]):
            if debug and verbose:
                print 'raw: ' + lines[j]
            if lines[j][0] == '#':
                j = j + 1
                continue
            elif lines[j][0] == '[':
                if debug and verbose:
                    print 'dist: ' + lines[j][1:5]
                packages[name] = records.copy()
                packages = dists[lines[j][1:5]]
                j = j + 1
                continue
            # split "field: value record for field" into dict record
            # e.g. "category: Libs Commandline_Utilities" 
            #   --&gt; {'category': 'Libs Commandline_Utilities'}
            try:
                key, value = map(string.strip,
                      string.split(lines[j], ': ', 1))
            except:
                print lines[j]
                raise TypeError('urg')
            
            #strip outer quotes?
            if value[0] == '"' and value.find('"', 1) == -1:
                while 1:
                    j = j + 1
                    value += lines[j]
                    if lines[j].find('"') != -1:
                        break
            
            records[key] = value
            j = j + 1
        packages[name] = records

    # this duplicated from get_info()
    # ...in order to populate keys built from 'install' and 'source'
    # FIXME: apply DRY and split into smaller re-usable functions
    for p in packages:
        # print p
        # print dists[distname][p]['install']
        d = dists[distname][p]
        d['name'] = p
        #print d    # debug peek at incoming dict
        try:
            # 'install' and 'source keys have compound values, atomize them
            d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
            
            ## issue #29
            #if not debug:
                #del d['install']
                
        except KeyError as e:
            d['zip_path'],d['zip_size'],d['md5'] = ('', '', '')
            if debug:
              print "\n*** Warning: '%s' is missing %s entry in setup.ini. This might cause problems.\n" % (p, e)

        try:
            d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
            if not debug:
                del d['source']
        except KeyError as e:
            d['src_zip_path'],d['src_zip_size'],d['src_md5'] = ('', '', '')
            
        #based on current mirror, might be different from when downloaded and/or installed
        d['local_zip'] = '%s/%s' % (downloads, d['zip_path'])
        d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])
            
        # insert the parsed fields back into parent dict
        dists[distname][p] = d
        
    # # print dists[distname]['gdal'].keys()    
    return dists
</t>
<t tx="maphew.20141101125304.3">def info(packages):
    '''info - report name, version, category, etc. about the package(s)
        
    B:\&gt; apt info shell
    
    name     : shell
    version  : 1.0.0-13
    sdesc    : "OSGeo4W Command Shell"
    ldesc    : "Menu and Desktop icon launch OSGeo4W command shell"
    category : Commandline_Utilities
    requires : msvcrt setup
    zip_path : x86/release/shell/shell-1.0.0-13.tar.bz2
    zip_size : 3763
    md5      : c38f03d2b7160f891fc36ec776ca4685
    local_zip: d:/temp/o4w-cache/setup/http%3.../shell-1.0.0-13.tar.bz2
    installed: True
    install_v: 1.0.0-11
        
    Notes:
        - "local_zip" is best guess based on current mirror. (We don't record which mirror was in use at the time of package install.)
        - "version" is from setup.ini, what is available on the mirror server
        - "install_v" is the version currently installed
    '''
    if isinstance(packages, basestring): packages = [packages]

    if not packages:
        help('info')
        sys.stderr.write("\n*** Can't show info, no package names specified. ***\n")
        return

    for p in packages:
        d = get_info(p)
        print('')
        # NB: only prints fields we know about, if something is added
        # upstream we'll miss it here
        fields = ['name', 
            'version', 
            'sdesc', 
            'ldesc', 
            'category', 
            'requires', 
            'zip_path', 
            'zip_size', 
            'md5', 
            'local_zip', 
            'installed']
        for k in fields:
            print('{0:9}: {1}'.format(k,d[k]))
        if d['installed']:
            print('{0:9}: {1}'.format('install_v',d['install_v']))

        if debug:            
            # This guaranteed to print entire dict contents,
            # but not in a logical order.
            print '\n----- DEBUG: %s -----' % sys._getframe().f_code.co_name
            for k in d.keys():
                print('{0:8}:\t{1}'.format(k,d[k]))
            print '-' * 36
</t>
<t tx="maphew.20141111130056.4">def get_info(packagename):
    '''Retrieve details for package X.
    
    Returns dict of information for the package from dict created by parse_setup_ini()
        (category, version, archive name, etc.)
    
    Incoming packagename dict duplicates the original key names and values. Here we further parse the compound record values into constituent parts.
    
        {'install': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2 5430991 3b60f036f0d29c401d0927a9ae000f0c'}
    
    becomes:
        
        {'zip_path': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2'}
        {'zip_size':'5430991'}
        {'md5':'3b60f036f0d29c401d0927a9ae000f0c'}
    '''   
    d = dists[distname][packagename]
    d['name'] = packagename
    #print d    # debug peek at incoming dict
    
    if 'install' in d.keys():
        # 'install' and 'source keys have compound values, atomize them
        d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
        
        ## issue #29
        # if not debug:
            # del d['install']
            
    if 'source' in d.keys():
        d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
        if not debug:
            del d['source']
        
    #based on current mirror, might be different from when downloaded and/or installed
    d['local_zip'] = os.path.normpath(os.path.join(downloads, d['zip_path']))
    d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])

    d['filename'] = os.path.basename(d['zip_path'])
    
    # ensure requires key exists even if it's empty
    if not 'requires' in d.keys():
        d['requires'] = ''
    
    if packagename in installed[0].keys():
        d['installed'] = True
        d['install_v'] = version_to_string(get_installed_version(packagename))
            # don't like key name, but...
    else:
        d['installed'] = False
    
    return d
</t>
<t tx="maphew.20150327024431.4">@path apt
@language python</t>
<t tx="maphew.20150330213839.2"></t>
<t tx="maphew.20150402222826.4"></t>
<t tx="maphew.20150402222826.5">gnx: maphew.20150402222826.3
</t>
<t tx="maphew.20150402222826.7"></t>
<t tx="maphew.20150403193730.1"></t>
<t tx="maphew.20150403193730.10">(uncached) maphew.20141101125304.3
Diff...
  def info(packages):
      '''info - report name, version, category, etc. about the package(s)
          
      B:\&gt; apt info shell
      
      name     : shell
      version  : 1.0.0-13
      sdesc    : "OSGeo4W Command Shell"
      ldesc    : "Menu and Desktop icon launch OSGeo4W command shell"
      category : Commandline_Utilities
      requires : msvcrt setup
      zip_path : x86/release/shell/shell-1.0.0-13.tar.bz2
      zip_size : 3763
      md5      : c38f03d2b7160f891fc36ec776ca4685
      local_zip: d:/temp/o4w-cache/setup/http%3.../shell-1.0.0-13.tar.bz2
+     installed: True
+     install_v: 1.0.0-11
          
+     Notes:
-     Note: "local_zip" is best guess based on current mirror. (We don't record which mirror was in use at the time of package install.)
?     ^^^^^
+         - "local_zip" is best guess based on current mirror. (We don't record which mirror was in use at the time of package install.)
?     ^^^^^
+         - "version" is from setup.ini, what is available on the mirror server
+         - "install_v" is the version currently installed
      '''
-         #AMR66:
      if isinstance(packages, basestring): packages = [packages]
-     #if type(packages) is str: packages = [packages]
  
      if not packages:
          help('info')
          sys.stderr.write("\n*** Can't show info, no package names specified. ***\n")
          return
  
      for p in packages:
          d = get_info(p)
          print('')
          # NB: only prints fields we know about, if something is added
          # upstream we'll miss it here
          fields = ['name', 
              'version', 
              'sdesc', 
              'ldesc', 
              'category', 
              'requires', 
              'zip_path', 
              'zip_size', 
              'md5', 
              'local_zip', 
              'installed']
          for k in fields:
              print('{0:9}: {1}'.format(k,d[k]))
+         if d['installed']:
+             print('{0:9}: {1}'.format('install_v',d['install_v']))
  
          if debug:            
              # This guaranteed to print entire dict contents,
              # but not in a logical order.
+             print '\n----- DEBUG: %s -----' % sys._getframe().f_code.co_name
              for k in d.keys():
                  print('{0:8}:\t{1}'.format(k,d[k]))
+             print '-' * 36
</t>
<t tx="maphew.20150403193730.2">(uncached) maphew.20141111130056.4
Diff...
  def get_info(packagename):
      '''Retrieve details for package X.
      
      Returns dict of information for the package from dict created by parse_setup_ini()
          (category, version, archive name, etc.)
      
      Incoming packagename dict duplicates the original key names and values. Here we further parse the compound record values into constituent parts.
      
          {'install': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2 5430991 3b60f036f0d29c401d0927a9ae000f0c'}
      
      becomes:
          
          {'zip_path': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2'}
          {'zip_size':'5430991'}
          {'md5':'3b60f036f0d29c401d0927a9ae000f0c'}
      '''   
      d = dists[distname][packagename]
      d['name'] = packagename
      #print d    # debug peek at incoming dict
      
      if 'install' in d.keys():
          # 'install' and 'source keys have compound values, atomize them
          d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
          
          ## issue #29
          # if not debug:
              # del d['install']
              
      if 'source' in d.keys():
          d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
          if not debug:
              del d['source']
          
      #based on current mirror, might be different from when downloaded and/or installed
      d['local_zip'] = os.path.normpath(os.path.join(downloads, d['zip_path']))
      d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])
  
      d['filename'] = os.path.basename(d['zip_path'])
      
      # ensure requires key exists even if it's empty
      if not 'requires' in d.keys():
          d['requires'] = ''
      
      if packagename in installed[0].keys():
          d['installed'] = True
-         d['installed_ver'] = version_to_string(get_installed_version(packagename))
?                   --  --
+         d['install_v'] = version_to_string(get_installed_version(packagename))
-             # don't like long key name, but...
?                          -----
+             # don't like key name, but...
      else:
          d['installed'] = False
      
      return d
</t>
<t tx="maphew.20150403193730.3">(uncached) maphew.20100223163802.3754
Diff...
  def parse_setup_ini(fname):
      '''Parse setup.ini into package name, description, version, dependencies, etc.
      
      Args:
          fname: full path to setup.ini
              
      Returns:
          A nested dictionary: {Distribution {Program_name{['category', 'source', 'ldesc', 'version', 'install', 'sdesc', 'requires']}}}
      
          {curr {
              'gdal' {
                  'name': 'gdal',
                  'version': '1.11.1-4',
                  'category': 'Libs Commandline_Utilities',
                  etc... }
              }}
      '''
      # global dists
      dists = {'test': {}, 'curr': {}, 'prev': {}}
      
      chunks = string.split(open(fname).read(), '\n\n@ ')
      for i in chunks[1:]:
          lines = string.split(i, '\n')
          name = string.strip(lines[0])
          if debug and verbose:
              print 'package: ' + name
          packages = dists['curr']
          records = {'sdesc': name}
          j = 1
          while j &lt; len(lines) and string.strip(lines[j]):
              if debug and verbose:
                  print 'raw: ' + lines[j]
              if lines[j][0] == '#':
                  j = j + 1
                  continue
              elif lines[j][0] == '[':
                  if debug and verbose:
                      print 'dist: ' + lines[j][1:5]
                  packages[name] = records.copy()
                  packages = dists[lines[j][1:5]]
                  j = j + 1
                  continue
              # split "field: value record for field" into dict record
              # e.g. "category: Libs Commandline_Utilities" 
              #   --&gt; {'category': 'Libs Commandline_Utilities'}
              try:
                  key, value = map(string.strip,
                        string.split(lines[j], ': ', 1))
              except:
                  print lines[j]
                  raise TypeError('urg')
              
              #strip outer quotes?
              if value[0] == '"' and value.find('"', 1) == -1:
                  while 1:
                      j = j + 1
                      value += lines[j]
                      if lines[j].find('"') != -1:
                          break
              
              records[key] = value
              j = j + 1
          packages[name] = records
  
      # this duplicated from get_info()
      # ...in order to populate keys built from 'install' and 'source'
      # FIXME: apply DRY and split into smaller re-usable functions
      for p in packages:
          # print p
          # print dists[distname][p]['install']
          d = dists[distname][p]
          d['name'] = p
          #print d    # debug peek at incoming dict
          try:
              # 'install' and 'source keys have compound values, atomize them
              d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
              
              ## issue #29
              #if not debug:
                  #del d['install']
                  
          except KeyError as e:
              d['zip_path'],d['zip_size'],d['md5'] = ('', '', '')
+             if debug:
-             print "\n*** Warning: '%s' is missing %s entry in setup.ini. This might cause problems.\n" % (p, e)
+               print "\n*** Warning: '%s' is missing %s entry in setup.ini. This might cause problems.\n" % (p, e)
? ++
  
          try:
              d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
              if not debug:
                  del d['source']
          except KeyError as e:
              d['src_zip_path'],d['src_zip_size'],d['src_md5'] = ('', '', '')
              
          #based on current mirror, might be different from when downloaded and/or installed
          d['local_zip'] = '%s/%s' % (downloads, d['zip_path'])
          d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])
              
          # insert the parsed fields back into parent dict
          dists[distname][p] = d
          
      # # print dists[distname]['gdal'].keys()    
      return dists
</t>
<t tx="maphew.20150403193730.4">def parse_setup_ini(fname):
    '''Parse setup.ini into package name, description, version, dependencies, etc.
    
    Args:
        fname: full path to setup.ini
            
    Returns:
        A nested dictionary: {Distribution {Program_name{['category', 'source', 'ldesc', 'version', 'install', 'sdesc', 'requires']}}}
    
        {curr {
            'gdal' {
                'name': 'gdal',
                'version': '1.11.1-4',
                'category': 'Libs Commandline_Utilities',
                etc... }
            }}
    '''
    # global dists
    dists = {'test': {}, 'curr': {}, 'prev': {}}
    
    chunks = string.split(open(fname).read(), '\n\n@ ')
    for i in chunks[1:]:
        lines = string.split(i, '\n')
        name = string.strip(lines[0])
        if debug and verbose:
            print 'package: ' + name
        packages = dists['curr']
        records = {'sdesc': name}
        j = 1
        while j &lt; len(lines) and string.strip(lines[j]):
            if debug and verbose:
                print 'raw: ' + lines[j]
            if lines[j][0] == '#':
                j = j + 1
                continue
            elif lines[j][0] == '[':
                if debug and verbose:
                    print 'dist: ' + lines[j][1:5]
                packages[name] = records.copy()
                packages = dists[lines[j][1:5]]
                j = j + 1
                continue
            # split "field: value record for field" into dict record
            # e.g. "category: Libs Commandline_Utilities" 
            #   --&gt; {'category': 'Libs Commandline_Utilities'}
            try:
                key, value = map(string.strip,
                      string.split(lines[j], ': ', 1))
            except:
                print lines[j]
                raise TypeError('urg')
            
            #strip outer quotes?
            if value[0] == '"' and value.find('"', 1) == -1:
                while 1:
                    j = j + 1
                    value += lines[j]
                    if lines[j].find('"') != -1:
                        break
            
            records[key] = value
            j = j + 1
        packages[name] = records

    # this duplicated from get_info()
    # ...in order to populate keys built from 'install' and 'source'
    # FIXME: apply DRY and split into smaller re-usable functions
    for p in packages:
        # print p
        # print dists[distname][p]['install']
        d = dists[distname][p]
        d['name'] = p
        #print d    # debug peek at incoming dict
        try:
            # 'install' and 'source keys have compound values, atomize them
            d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
            
            ## issue #29
            #if not debug:
                #del d['install']
                
        except KeyError as e:
            d['zip_path'],d['zip_size'],d['md5'] = ('', '', '')
            if debug:
              print "\n*** Warning: '%s' is missing %s entry in setup.ini. This might cause problems.\n" % (p, e)

        try:
            d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
            if not debug:
                del d['source']
        except KeyError as e:
            d['src_zip_path'],d['src_zip_size'],d['src_md5'] = ('', '', '')
            
        #based on current mirror, might be different from when downloaded and/or installed
        d['local_zip'] = '%s/%s' % (downloads, d['zip_path'])
        d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])
            
        # insert the parsed fields back into parent dict
        dists[distname][p] = d
        
    # # print dists[distname]['gdal'].keys()    
    return dists
</t>
<t tx="maphew.20150403193730.5">def info(packages):
    '''info - report name, version, category, etc. about the package(s)
        
    B:\&gt; apt info shell
    
    name     : shell
    version  : 1.0.0-13
    sdesc    : "OSGeo4W Command Shell"
    ldesc    : "Menu and Desktop icon launch OSGeo4W command shell"
    category : Commandline_Utilities
    requires : msvcrt setup
    zip_path : x86/release/shell/shell-1.0.0-13.tar.bz2
    zip_size : 3763
    md5      : c38f03d2b7160f891fc36ec776ca4685
    local_zip: d:/temp/o4w-cache/setup/http%3.../shell-1.0.0-13.tar.bz2
    installed: True
    install_v: 1.0.0-11
        
    Notes:
        - "local_zip" is best guess based on current mirror. (We don't record which mirror was in use at the time of package install.)
        - "version" is from setup.ini, what is available on the mirror server
        - "install_v" is the version currently installed
    '''
    if isinstance(packages, basestring): packages = [packages]

    if not packages:
        help('info')
        sys.stderr.write("\n*** Can't show info, no package names specified. ***\n")
        return

    for p in packages:
        d = get_info(p)
        print('')
        # NB: only prints fields we know about, if something is added
        # upstream we'll miss it here
        fields = ['name', 
            'version', 
            'sdesc', 
            'ldesc', 
            'category', 
            'requires', 
            'zip_path', 
            'zip_size', 
            'md5', 
            'local_zip', 
            'installed']
        for k in fields:
            print('{0:9}: {1}'.format(k,d[k]))
        if d['installed']:
            print('{0:9}: {1}'.format('install_v',d['install_v']))

        if debug:            
            # This guaranteed to print entire dict contents,
            # but not in a logical order.
            print '\n----- DEBUG: %s -----' % sys._getframe().f_code.co_name
            for k in d.keys():
                print('{0:8}:\t{1}'.format(k,d[k]))
            print '-' * 36
</t>
<t tx="maphew.20150403193730.6">def parse_setup_ini(fname):
    '''Parse setup.ini into package name, description, version, dependencies, etc.
    
    Args:
        fname: full path to setup.ini
            
    Returns:
        A nested dictionary: {Distribution {Program_name{['category', 'source', 'ldesc', 'version', 'install', 'sdesc', 'requires']}}}
    
        {curr {
            'gdal' {
                'name': 'gdal',
                'version': '1.11.1-4',
                'category': 'Libs Commandline_Utilities',
                etc... }
            }}
    '''
    # global dists
    dists = {'test': {}, 'curr': {}, 'prev': {}}
    
    chunks = string.split(open(fname).read(), '\n\n@ ')
    for i in chunks[1:]:
        lines = string.split(i, '\n')
        name = string.strip(lines[0])
        if debug and verbose:
            print 'package: ' + name
        packages = dists['curr']
        records = {'sdesc': name}
        j = 1
        while j &lt; len(lines) and string.strip(lines[j]):
            if debug and verbose:
                print 'raw: ' + lines[j]
            if lines[j][0] == '#':
                j = j + 1
                continue
            elif lines[j][0] == '[':
                if debug and verbose:
                    print 'dist: ' + lines[j][1:5]
                packages[name] = records.copy()
                packages = dists[lines[j][1:5]]
                j = j + 1
                continue
            # split "field: value record for field" into dict record
            # e.g. "category: Libs Commandline_Utilities" 
            #   --&gt; {'category': 'Libs Commandline_Utilities'}
            try:
                key, value = map(string.strip,
                      string.split(lines[j], ': ', 1))
            except:
                print lines[j]
                raise TypeError('urg')
            
            #strip outer quotes?
            if value[0] == '"' and value.find('"', 1) == -1:
                while 1:
                    j = j + 1
                    value += lines[j]
                    if lines[j].find('"') != -1:
                        break
            
            records[key] = value
            j = j + 1
        packages[name] = records

    # this duplicated from get_info()
    # ...in order to populate keys built from 'install' and 'source'
    # FIXME: apply DRY and split into smaller re-usable functions
    for p in packages:
        # print p
        # print dists[distname][p]['install']
        d = dists[distname][p]
        d['name'] = p
        #print d    # debug peek at incoming dict
        try:
            # 'install' and 'source keys have compound values, atomize them
            d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
            
            ## issue #29
            #if not debug:
                #del d['install']
                
        except KeyError as e:
            d['zip_path'],d['zip_size'],d['md5'] = ('', '', '')
            print "\n*** Warning: '%s' is missing %s entry in setup.ini. This might cause problems.\n" % (p, e)

        try:
            d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
            if not debug:
                del d['source']
        except KeyError as e:
            d['src_zip_path'],d['src_zip_size'],d['src_md5'] = ('', '', '')
            
        #based on current mirror, might be different from when downloaded and/or installed
        d['local_zip'] = '%s/%s' % (downloads, d['zip_path'])
        d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])
            
        # insert the parsed fields back into parent dict
        dists[distname][p] = d
        
    # # print dists[distname]['gdal'].keys()    
    return dists
</t>
<t tx="maphew.20150403193730.7">def get_info(packagename):
    '''Retrieve details for package X.
    
    Returns dict of information for the package from dict created by parse_setup_ini()
        (category, version, archive name, etc.)
    
    Incoming packagename dict duplicates the original key names and values. Here we further parse the compound record values into constituent parts.
    
        {'install': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2 5430991 3b60f036f0d29c401d0927a9ae000f0c'}
    
    becomes:
        
        {'zip_path': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2'}
        {'zip_size':'5430991'}
        {'md5':'3b60f036f0d29c401d0927a9ae000f0c'}
    '''   
    d = dists[distname][packagename]
    d['name'] = packagename
    #print d    # debug peek at incoming dict
    
    if 'install' in d.keys():
        # 'install' and 'source keys have compound values, atomize them
        d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
        
        ## issue #29
        # if not debug:
            # del d['install']
            
    if 'source' in d.keys():
        d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
        if not debug:
            del d['source']
        
    #based on current mirror, might be different from when downloaded and/or installed
    d['local_zip'] = os.path.normpath(os.path.join(downloads, d['zip_path']))
    d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])

    d['filename'] = os.path.basename(d['zip_path'])
    
    # ensure requires key exists even if it's empty
    if not 'requires' in d.keys():
        d['requires'] = ''
    
    if packagename in installed[0].keys():
        d['installed'] = True
        d['installed_ver'] = version_to_string(get_installed_version(packagename))
            # don't like long key name, but...
    else:
        d['installed'] = False
    
    return d
</t>
<t tx="maphew.20150403193730.8">def info(packages):
    '''info - report name, version, category, etc. about the package(s)
        
    B:\&gt; apt info shell
    
    name     : shell
    version  : 1.0.0-13
    sdesc    : "OSGeo4W Command Shell"
    ldesc    : "Menu and Desktop icon launch OSGeo4W command shell"
    category : Commandline_Utilities
    requires : msvcrt setup
    zip_path : x86/release/shell/shell-1.0.0-13.tar.bz2
    zip_size : 3763
    md5      : c38f03d2b7160f891fc36ec776ca4685
    local_zip: d:/temp/o4w-cache/setup/http%3.../shell-1.0.0-13.tar.bz2
        
    Note: "local_zip" is best guess based on current mirror. (We don't record which mirror was in use at the time of package install.)
    '''
        #AMR66:
    if isinstance(packages, basestring): packages = [packages]
    #if type(packages) is str: packages = [packages]

    if not packages:
        help('info')
        sys.stderr.write("\n*** Can't show info, no package names specified. ***\n")
        return

    for p in packages:
        d = get_info(p)
        print('')
        # NB: only prints fields we know about, if something is added
        # upstream we'll miss it here
        fields = ['name', 
            'version', 
            'sdesc', 
            'ldesc', 
            'category', 
            'requires', 
            'zip_path', 
            'zip_size', 
            'md5', 
            'local_zip', 
            'installed']
        for k in fields:
            print('{0:9}: {1}'.format(k,d[k]))

        if debug:            
            # This guaranteed to print entire dict contents,
            # but not in a logical order.
            for k in d.keys():
                print('{0:8}:\t{1}'.format(k,d[k]))
</t>
<t tx="maphew.20150403193730.9">def get_info(packagename):
    '''Retrieve details for package X.
    
    Returns dict of information for the package from dict created by parse_setup_ini()
        (category, version, archive name, etc.)
    
    Incoming packagename dict duplicates the original key names and values. Here we further parse the compound record values into constituent parts.
    
        {'install': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2 5430991 3b60f036f0d29c401d0927a9ae000f0c'}
    
    becomes:
        
        {'zip_path': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2'}
        {'zip_size':'5430991'}
        {'md5':'3b60f036f0d29c401d0927a9ae000f0c'}
    '''   
    d = dists[distname][packagename]
    d['name'] = packagename
    #print d    # debug peek at incoming dict
    
    if 'install' in d.keys():
        # 'install' and 'source keys have compound values, atomize them
        d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
        
        ## issue #29
        # if not debug:
            # del d['install']
            
    if 'source' in d.keys():
        d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
        if not debug:
            del d['source']
        
    #based on current mirror, might be different from when downloaded and/or installed
    d['local_zip'] = os.path.normpath(os.path.join(downloads, d['zip_path']))
    d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])

    d['filename'] = os.path.basename(d['zip_path'])
    
    # ensure requires key exists even if it's empty
    if not 'requires' in d.keys():
        d['requires'] = ''
    
    if packagename in installed[0].keys():
        d['installed'] = True
        d['install_v'] = version_to_string(get_installed_version(packagename))
            # don't like key name, but...
    else:
        d['installed'] = False
    
    return d
</t>
<t tx="maphew.20150404102108.1">def get_info(packagename):
    '''Retrieve details for package X.
    
    Returns dict of information for the package from dict created by parse_setup_ini()
        (category, version, archive name, etc.)
    
    Incoming packagename dict duplicates the original key names and values. Here we further parse the compound record values into constituent parts.
    
        {'install': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2 5430991 3b60f036f0d29c401d0927a9ae000f0c'}
    
    becomes:
        
        {'zip_path': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2'}
        {'zip_size':'5430991'}
        {'md5':'3b60f036f0d29c401d0927a9ae000f0c'}
    '''   
    d = dists[distname][packagename]
    d['name'] = packagename
    #print d    # debug peek at incoming dict
    
    if 'install' in d.keys():
        # 'install' and 'source keys have compound values, atomize them
        d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
        
        ## issue #29
        # if not debug:
            # del d['install']
            
    if 'source' in d.keys():
        d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
        if not debug:
            del d['source']
        
    #based on current mirror, might be different from when downloaded and/or installed
    d['local_zip'] = os.path.normpath(os.path.join(downloads, d['zip_path']))
    d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])

    d['filename'] = os.path.basename(d['zip_path'])
    
    # ensure requires key exists even if it's empty
    if not 'requires' in d.keys():
        d['requires'] = ''
    
    if packagename in installed[0].keys():
        d['installed'] = True
        d['install_v'] = version_to_string(get_installed_version(packagename))
            # don't like key name, but...
    else:
        d['installed'] = False
    
    return d
</t>
<t tx="maphew.20150404102108.10">(uncached) maphew.20100223163802.3754
Diff...
  def parse_setup_ini(fname):
      '''Parse setup.ini into package name, description, version, dependencies, etc.
      
      Args:
          fname: full path to setup.ini
              
      Returns:
          A nested dictionary: {Distribution {Program_name{['category', 'source', 'ldesc', 'version', 'install', 'sdesc', 'requires']}}}
      
          {curr {
              'gdal' {
                  'name': 'gdal',
                  'version': '1.11.1-4',
                  'category': 'Libs Commandline_Utilities',
                  etc... }
              }}
      '''
      # global dists
      dists = {'test': {}, 'curr': {}, 'prev': {}}
      
      chunks = string.split(open(fname).read(), '\n\n@ ')
      for i in chunks[1:]:
          lines = string.split(i, '\n')
          name = string.strip(lines[0])
          if debug and verbose:
              print 'package: ' + name
          packages = dists['curr']
          records = {'sdesc': name}
          j = 1
          while j &lt; len(lines) and string.strip(lines[j]):
              if debug and verbose:
                  print 'raw: ' + lines[j]
              if lines[j][0] == '#':
                  j = j + 1
                  continue
              elif lines[j][0] == '[':
                  if debug and verbose:
                      print 'dist: ' + lines[j][1:5]
                  packages[name] = records.copy()
                  packages = dists[lines[j][1:5]]
                  j = j + 1
                  continue
              # split "field: value record for field" into dict record
              # e.g. "category: Libs Commandline_Utilities" 
              #   --&gt; {'category': 'Libs Commandline_Utilities'}
              try:
                  key, value = map(string.strip,
                        string.split(lines[j], ': ', 1))
              except:
                  print lines[j]
                  raise TypeError('urg')
              
              #strip outer quotes?
              if value[0] == '"' and value.find('"', 1) == -1:
                  while 1:
                      j = j + 1
                      value += lines[j]
                      if lines[j].find('"') != -1:
                          break
              
              records[key] = value
              j = j + 1
          packages[name] = records
  
      # this duplicated from get_info()
      # ...in order to populate keys built from 'install' and 'source'
      # FIXME: apply DRY and split into smaller re-usable functions
      for p in packages:
          # print p
          # print dists[distname][p]['install']
          d = dists[distname][p]
          d['name'] = p
          #print d    # debug peek at incoming dict
          try:
              # 'install' and 'source keys have compound values, atomize them
              d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
              
              ## issue #29
              #if not debug:
                  #del d['install']
                  
          except KeyError as e:
              d['zip_path'],d['zip_size'],d['md5'] = ('', '', '')
-             if debug:
-               print "\n*** Warning: '%s' is missing %s entry in setup.ini. This might cause problems.\n" % (p, e)
? --
+             print "\n*** Warning: '%s' is missing %s entry in setup.ini. This might cause problems.\n" % (p, e)
  
          try:
              d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
              if not debug:
                  del d['source']
          except KeyError as e:
              d['src_zip_path'],d['src_zip_size'],d['src_md5'] = ('', '', '')
              
          #based on current mirror, might be different from when downloaded and/or installed
          d['local_zip'] = '%s/%s' % (downloads, d['zip_path'])
          d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])
              
          # insert the parsed fields back into parent dict
          dists[distname][p] = d
          
      # # print dists[distname]['gdal'].keys()    
      return dists
</t>
<t tx="maphew.20150404102108.11"></t>
<t tx="maphew.20150404102108.12">(uncached) maphew.20100307230644.3847
Diff...
  import __main__
  import getopt
  import os
  import glob
  import re
  import shutil
  import string
  import sys
  import urllib
  import gzip, tarfile, bz2
  import hashlib
  import requests
  import subprocess
  import shlex
  import locale
- from pkg_resources import parse_version
+ import pkg_resources # for version comparing
  from datetime import datetime, timedelta
  #from attrdict import AttrDict
  
</t>
<t tx="maphew.20150404102108.13">import __main__
import getopt
import os
import glob
import re
import shutil
import string
import sys
import urllib
import gzip, tarfile, bz2
import hashlib
import requests
import subprocess
import shlex
import locale
import pkg_resources # for version comparing
from datetime import datetime, timedelta
#from attrdict import AttrDict

</t>
<t tx="maphew.20150404102108.14">import __main__
import getopt
import os
import glob
import re
import shutil
import string
import sys
import urllib
import gzip, tarfile, bz2
import hashlib
import requests
import subprocess
import shlex
import locale
from pkg_resources import parse_version
from datetime import datetime, timedelta
#from attrdict import AttrDict

</t>
<t tx="maphew.20150404102108.15">(uncached) maphew.20100223163802.3724
Diff...
  def install(packages, force=False):
      '''Download and install packages, including dependencies
      
          C:\&gt; apt install shell gdal
      '''
      if isinstance(packages, basestring): packages = [packages]
      if debug:
          print '\n--- DEBUG: %s ---' % sys._getframe().f_code.co_name
          print '--- pkgs:', packages
      
      if not packages:
          sys.stderr.write('\n*** No packages specified. Use "apt available" for ideas. ***\n')
          help('install')
          return
      
      # build list of dependencies
      reqs = []
      for p in packages:
          reqs.extend(get_all_dependencies(p, []))
      if debug: print 'PKGS: %s, REQS: %s' % (packages, reqs)
      
      # remove duplicates and empty items
      packages = unique(packages)
      reqs = unique(reqs)
      # don't need pkg dupes listed in requires
      for p in packages:
          while p in reqs[:]:
              reqs.remove(p)    
      if debug: print 'Unique PKGS: %s, REQS: %s' % (packages, reqs)
      pkgs_requested = packages[:] # save copy for later
      reqs_requested = reqs[:]
      
      # skip everything already installed
      # for p in packages:
          # Skips items! See "Remove items from a list while iterating in Python"
          # http://stackoverflow.com/a/1207427/14420
      print 'PKGS: Checking install status:', ' '.join(packages)
      for p in packages[:]:
          print '\t %s - %s' % (p, get_info(p)['installed'])
          if get_info(p)['installed']:
              #ini_v = get_info(p)['version']
              ini_v = version_to_string(get_version(p))
              local_v = version_to_string(get_installed_version(p))
-             if parse_version(local_v) &gt;= parse_version(ini_v):
+             if pkg_resources.parse_version(local_v) &gt;= pkg_resources.parse_version(ini_v):
?                ++++++++++++++                           ++++++++++++++
-                 print '--- local &gt;= ini:', parse_version(local_v) &gt;= parse_version(ini_v)
+                 print '--- local &gt;= ini:', pkg_resources.parse_version(local_v) &gt;= pkg_resources.parse_version(ini_v)
?                                             ++++++++++++++                          ++++++++++++++
                  print 'local:', local_v
                  print 'remote:', ini_v
              #if version_to_string(get_installed_version(p)) &gt;= get_info(p)['version']:
                  packages.remove(p)
  
      # skip installed dependencies
      print 'REQS: Checking dependencies installed:', ' '.join(reqs)
      for r in reqs[:]:
          print '\t %s - %s' % (r, get_info(r)['installed'])
          if get_info(r)['installed']:
              reqs.remove(r)
      
      if debug: print 'Not installed PKGS: %s, REQS: %s' % (packages, reqs)
      
      if reqs:
          print 'REQS: --- To install:', reqs
          for r in reversed(reqs):
              download(r)
              if download_p:  # quit if download only flag is set
                  sys.exit(0)
              do_install(r)
      if packages:
          print 'PKGS: --- To install:', packages
          for p in packages:
              download(p)    
          if download_p:  # quit if download only flag is set
              sys.exit(0)
          do_install(p)
  
      else:
          print '\nPackages and required dependencies are installed.\n'
          version(pkgs_requested)
          print ''
          version(reqs_requested)
</t>
<t tx="maphew.20150404102108.16">def install(packages, force=False):
    '''Download and install packages, including dependencies
    
        C:\&gt; apt install shell gdal
    '''
    if isinstance(packages, basestring): packages = [packages]
    if debug:
        print '\n--- DEBUG: %s ---' % sys._getframe().f_code.co_name
        print '--- pkgs:', packages
    
    if not packages:
        sys.stderr.write('\n*** No packages specified. Use "apt available" for ideas. ***\n')
        help('install')
        return
    
    # build list of dependencies
    reqs = []
    for p in packages:
        reqs.extend(get_all_dependencies(p, []))
    if debug: print 'PKGS: %s, REQS: %s' % (packages, reqs)
    
    # remove duplicates and empty items
    packages = unique(packages)
    reqs = unique(reqs)
    # don't need pkg dupes listed in requires
    for p in packages:
        while p in reqs[:]:
            reqs.remove(p)    
    if debug: print 'Unique PKGS: %s, REQS: %s' % (packages, reqs)
    pkgs_requested = packages[:] # save copy for later
    reqs_requested = reqs[:]
    
    # skip everything already installed
    # for p in packages:
        # Skips items! See "Remove items from a list while iterating in Python"
        # http://stackoverflow.com/a/1207427/14420
    print 'PKGS: Checking install status:', ' '.join(packages)
    for p in packages[:]:
        print '\t %s - %s' % (p, get_info(p)['installed'])
        if get_info(p)['installed']:
            #ini_v = get_info(p)['version']
            ini_v = version_to_string(get_version(p))
            local_v = version_to_string(get_installed_version(p))
            if pkg_resources.parse_version(local_v) &gt;= pkg_resources.parse_version(ini_v):
                print '--- local &gt;= ini:', pkg_resources.parse_version(local_v) &gt;= pkg_resources.parse_version(ini_v)
                print 'local:', local_v
                print 'remote:', ini_v
            #if version_to_string(get_installed_version(p)) &gt;= get_info(p)['version']:
                packages.remove(p)

    # skip installed dependencies
    print 'REQS: Checking dependencies installed:', ' '.join(reqs)
    for r in reqs[:]:
        print '\t %s - %s' % (r, get_info(r)['installed'])
        if get_info(r)['installed']:
            reqs.remove(r)
    
    if debug: print 'Not installed PKGS: %s, REQS: %s' % (packages, reqs)
    
    if reqs:
        print 'REQS: --- To install:', reqs
        for r in reversed(reqs):
            download(r)
            if download_p:  # quit if download only flag is set
                sys.exit(0)
            do_install(r)
    if packages:
        print 'PKGS: --- To install:', packages
        for p in packages:
            download(p)    
        if download_p:  # quit if download only flag is set
            sys.exit(0)
        do_install(p)

    else:
        print '\nPackages and required dependencies are installed.\n'
        version(pkgs_requested)
        print ''
        version(reqs_requested)
</t>
<t tx="maphew.20150404102108.17">def install(packages, force=False):
    '''Download and install packages, including dependencies
    
        C:\&gt; apt install shell gdal
    '''
    if isinstance(packages, basestring): packages = [packages]
    if debug:
        print '\n--- DEBUG: %s ---' % sys._getframe().f_code.co_name
        print '--- pkgs:', packages
    
    if not packages:
        sys.stderr.write('\n*** No packages specified. Use "apt available" for ideas. ***\n')
        help('install')
        return
    
    # build list of dependencies
    reqs = []
    for p in packages:
        reqs.extend(get_all_dependencies(p, []))
    if debug: print 'PKGS: %s, REQS: %s' % (packages, reqs)
    
    # remove duplicates and empty items
    packages = unique(packages)
    reqs = unique(reqs)
    # don't need pkg dupes listed in requires
    for p in packages:
        while p in reqs[:]:
            reqs.remove(p)    
    if debug: print 'Unique PKGS: %s, REQS: %s' % (packages, reqs)
    pkgs_requested = packages[:] # save copy for later
    reqs_requested = reqs[:]
    
    # skip everything already installed
    # for p in packages:
        # Skips items! See "Remove items from a list while iterating in Python"
        # http://stackoverflow.com/a/1207427/14420
    print 'PKGS: Checking install status:', ' '.join(packages)
    for p in packages[:]:
        print '\t %s - %s' % (p, get_info(p)['installed'])
        if get_info(p)['installed']:
            #ini_v = get_info(p)['version']
            ini_v = version_to_string(get_version(p))
            local_v = version_to_string(get_installed_version(p))
            if parse_version(local_v) &gt;= parse_version(ini_v):
                print '--- local &gt;= ini:', parse_version(local_v) &gt;= parse_version(ini_v)
                print 'local:', local_v
                print 'remote:', ini_v
            #if version_to_string(get_installed_version(p)) &gt;= get_info(p)['version']:
                packages.remove(p)

    # skip installed dependencies
    print 'REQS: Checking dependencies installed:', ' '.join(reqs)
    for r in reqs[:]:
        print '\t %s - %s' % (r, get_info(r)['installed'])
        if get_info(r)['installed']:
            reqs.remove(r)
    
    if debug: print 'Not installed PKGS: %s, REQS: %s' % (packages, reqs)
    
    if reqs:
        print 'REQS: --- To install:', reqs
        for r in reversed(reqs):
            download(r)
            if download_p:  # quit if download only flag is set
                sys.exit(0)
            do_install(r)
    if packages:
        print 'PKGS: --- To install:', packages
        for p in packages:
            download(p)    
        if download_p:  # quit if download only flag is set
            sys.exit(0)
        do_install(p)

    else:
        print '\nPackages and required dependencies are installed.\n'
        version(pkgs_requested)
        print ''
        version(reqs_requested)
</t>
<t tx="maphew.20150404102108.18">(uncached) maphew.20100223163802.3753
Diff...
  def get_new():
      '''Return list of mirror packages of newer versions than those installed.'''
      lst = []
      for packagename in installed[0].keys():
          remote = get_version(packagename)
          local = get_installed_version(packagename)
-         remote = parse_version(version_to_string(remote))
+         remote = pkg_resources.parse_version(version_to_string(remote))
?                  ++++++++++++++
-         local = parse_version(version_to_string(local))
+         local = pkg_resources.parse_version(version_to_string(local))
?                 ++++++++++++++
          
          if remote &gt; local:
              lst.append(packagename)
      return lst
</t>
<t tx="maphew.20150404102108.19">def get_new():
    '''Return list of mirror packages of newer versions than those installed.'''
    lst = []
    for packagename in installed[0].keys():
        remote = get_version(packagename)
        local = get_installed_version(packagename)
        remote = pkg_resources.parse_version(version_to_string(remote))
        local = pkg_resources.parse_version(version_to_string(local))
        
        if remote &gt; local:
            lst.append(packagename)
    return lst
</t>
<t tx="maphew.20150404102108.2">def get_info(packagename):
    '''Retrieve details for package X.
    
    Returns dict of information for the package from dict created by parse_setup_ini()
        (category, version, archive name, etc.)
    
    Incoming packagename dict duplicates the original key names and values. Here we further parse the compound record values into constituent parts.
    
        {'install': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2 5430991 3b60f036f0d29c401d0927a9ae000f0c'}
    
    becomes:
        
        {'zip_path': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2'}
        {'zip_size':'5430991'}
        {'md5':'3b60f036f0d29c401d0927a9ae000f0c'}
    '''   
    d = dists[distname][packagename]
    d['name'] = packagename
    #print d    # debug peek at incoming dict
    
    if 'install' in d.keys():
        # 'install' and 'source keys have compound values, atomize them
        d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
        
        ## issue #29
        # if not debug:
            # del d['install']
            
    if 'source' in d.keys():
        d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
        if not debug:
            del d['source']
        
    #based on current mirror, might be different from when downloaded and/or installed
    d['local_zip'] = os.path.normpath(os.path.join(downloads, d['zip_path']))
    d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])

    d['filename'] = os.path.basename(d['zip_path'])
    
    # ensure requires key exists even if it's empty
    if not 'requires' in d.keys():
        d['requires'] = ''
    
    if packagename in installed[0].keys():
        d['installed'] = True
        d['installed_ver'] = version_to_string(get_installed_version(packagename))
            # don't like long key name, but...
    else:
        d['installed'] = False
    
    return d
</t>
<t tx="maphew.20150404102108.20">def get_new():
    '''Return list of mirror packages of newer versions than those installed.'''
    lst = []
    for packagename in installed[0].keys():
        remote = get_version(packagename)
        local = get_installed_version(packagename)
        remote = parse_version(version_to_string(remote))
        local = parse_version(version_to_string(local))
        
        if remote &gt; local:
            lst.append(packagename)
    return lst
</t>
<t tx="maphew.20150404102108.3"></t>
<t tx="maphew.20150404102108.4">(uncached) maphew.20141111130056.4
Diff...
  def get_info(packagename):
      '''Retrieve details for package X.
      
      Returns dict of information for the package from dict created by parse_setup_ini()
          (category, version, archive name, etc.)
      
      Incoming packagename dict duplicates the original key names and values. Here we further parse the compound record values into constituent parts.
      
          {'install': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2 5430991 3b60f036f0d29c401d0927a9ae000f0c'}
      
      becomes:
          
          {'zip_path': 'x86/release/gdal/gdal-1.11.1-4.tar.bz2'}
          {'zip_size':'5430991'}
          {'md5':'3b60f036f0d29c401d0927a9ae000f0c'}
      '''   
      d = dists[distname][packagename]
      d['name'] = packagename
      #print d    # debug peek at incoming dict
      
      if 'install' in d.keys():
          # 'install' and 'source keys have compound values, atomize them
          d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
          
          ## issue #29
          # if not debug:
              # del d['install']
              
      if 'source' in d.keys():
          d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
          if not debug:
              del d['source']
          
      #based on current mirror, might be different from when downloaded and/or installed
      d['local_zip'] = os.path.normpath(os.path.join(downloads, d['zip_path']))
      d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])
  
      d['filename'] = os.path.basename(d['zip_path'])
      
      # ensure requires key exists even if it's empty
      if not 'requires' in d.keys():
          d['requires'] = ''
      
      if packagename in installed[0].keys():
          d['installed'] = True
-         d['install_v'] = version_to_string(get_installed_version(packagename))
+         d['installed_ver'] = version_to_string(get_installed_version(packagename))
?                   ++  ++
-             # don't like key name, but...
+             # don't like long key name, but...
?                          +++++
      else:
          d['installed'] = False
      
      return d
</t>
<t tx="maphew.20150404102108.5">def info(packages):
    '''info - report name, version, category, etc. about the package(s)
        
    B:\&gt; apt info shell
    
    name     : shell
    version  : 1.0.0-13
    sdesc    : "OSGeo4W Command Shell"
    ldesc    : "Menu and Desktop icon launch OSGeo4W command shell"
    category : Commandline_Utilities
    requires : msvcrt setup
    zip_path : x86/release/shell/shell-1.0.0-13.tar.bz2
    zip_size : 3763
    md5      : c38f03d2b7160f891fc36ec776ca4685
    local_zip: d:/temp/o4w-cache/setup/http%3.../shell-1.0.0-13.tar.bz2
    installed: True
    install_v: 1.0.0-11
        
    Notes:
        - "local_zip" is best guess based on current mirror. (We don't record which mirror was in use at the time of package install.)
        - "version" is from setup.ini, what is available on the mirror server
        - "install_v" is the version currently installed
    '''
    if isinstance(packages, basestring): packages = [packages]

    if not packages:
        help('info')
        sys.stderr.write("\n*** Can't show info, no package names specified. ***\n")
        return

    for p in packages:
        d = get_info(p)
        print('')
        # NB: only prints fields we know about, if something is added
        # upstream we'll miss it here
        fields = ['name', 
            'version', 
            'sdesc', 
            'ldesc', 
            'category', 
            'requires', 
            'zip_path', 
            'zip_size', 
            'md5', 
            'local_zip', 
            'installed']
        for k in fields:
            print('{0:9}: {1}'.format(k,d[k]))
        if d['installed']:
            print('{0:9}: {1}'.format('install_v',d['install_v']))

        if debug:            
            # This guaranteed to print entire dict contents,
            # but not in a logical order.
            print '\n----- DEBUG: %s -----' % sys._getframe().f_code.co_name
            for k in d.keys():
                print('{0:8}:\t{1}'.format(k,d[k]))
            print '-' * 36
</t>
<t tx="maphew.20150404102108.6">def parse_setup_ini(fname):
    '''Parse setup.ini into package name, description, version, dependencies, etc.
    
    Args:
        fname: full path to setup.ini
            
    Returns:
        A nested dictionary: {Distribution {Program_name{['category', 'source', 'ldesc', 'version', 'install', 'sdesc', 'requires']}}}
    
        {curr {
            'gdal' {
                'name': 'gdal',
                'version': '1.11.1-4',
                'category': 'Libs Commandline_Utilities',
                etc... }
            }}
    '''
    # global dists
    dists = {'test': {}, 'curr': {}, 'prev': {}}
    
    chunks = string.split(open(fname).read(), '\n\n@ ')
    for i in chunks[1:]:
        lines = string.split(i, '\n')
        name = string.strip(lines[0])
        if debug and verbose:
            print 'package: ' + name
        packages = dists['curr']
        records = {'sdesc': name}
        j = 1
        while j &lt; len(lines) and string.strip(lines[j]):
            if debug and verbose:
                print 'raw: ' + lines[j]
            if lines[j][0] == '#':
                j = j + 1
                continue
            elif lines[j][0] == '[':
                if debug and verbose:
                    print 'dist: ' + lines[j][1:5]
                packages[name] = records.copy()
                packages = dists[lines[j][1:5]]
                j = j + 1
                continue
            # split "field: value record for field" into dict record
            # e.g. "category: Libs Commandline_Utilities" 
            #   --&gt; {'category': 'Libs Commandline_Utilities'}
            try:
                key, value = map(string.strip,
                      string.split(lines[j], ': ', 1))
            except:
                print lines[j]
                raise TypeError('urg')
            
            #strip outer quotes?
            if value[0] == '"' and value.find('"', 1) == -1:
                while 1:
                    j = j + 1
                    value += lines[j]
                    if lines[j].find('"') != -1:
                        break
            
            records[key] = value
            j = j + 1
        packages[name] = records

    # this duplicated from get_info()
    # ...in order to populate keys built from 'install' and 'source'
    # FIXME: apply DRY and split into smaller re-usable functions
    for p in packages:
        # print p
        # print dists[distname][p]['install']
        d = dists[distname][p]
        d['name'] = p
        #print d    # debug peek at incoming dict
        try:
            # 'install' and 'source keys have compound values, atomize them
            d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
            
            ## issue #29
            #if not debug:
                #del d['install']
                
        except KeyError as e:
            d['zip_path'],d['zip_size'],d['md5'] = ('', '', '')
            print "\n*** Warning: '%s' is missing %s entry in setup.ini. This might cause problems.\n" % (p, e)

        try:
            d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
            if not debug:
                del d['source']
        except KeyError as e:
            d['src_zip_path'],d['src_zip_size'],d['src_md5'] = ('', '', '')
            
        #based on current mirror, might be different from when downloaded and/or installed
        d['local_zip'] = '%s/%s' % (downloads, d['zip_path'])
        d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])
            
        # insert the parsed fields back into parent dict
        dists[distname][p] = d
        
    # # print dists[distname]['gdal'].keys()    
    return dists
</t>
<t tx="maphew.20150404102108.7">(uncached) maphew.20141101125304.3
Diff...
  def info(packages):
      '''info - report name, version, category, etc. about the package(s)
          
      B:\&gt; apt info shell
      
      name     : shell
      version  : 1.0.0-13
      sdesc    : "OSGeo4W Command Shell"
      ldesc    : "Menu and Desktop icon launch OSGeo4W command shell"
      category : Commandline_Utilities
      requires : msvcrt setup
      zip_path : x86/release/shell/shell-1.0.0-13.tar.bz2
      zip_size : 3763
      md5      : c38f03d2b7160f891fc36ec776ca4685
      local_zip: d:/temp/o4w-cache/setup/http%3.../shell-1.0.0-13.tar.bz2
-     installed: True
-     install_v: 1.0.0-11
          
-     Notes:
-         - "local_zip" is best guess based on current mirror. (We don't record which mirror was in use at the time of package install.)
?     ^^^^^
+     Note: "local_zip" is best guess based on current mirror. (We don't record which mirror was in use at the time of package install.)
?     ^^^^^
-         - "version" is from setup.ini, what is available on the mirror server
-         - "install_v" is the version currently installed
      '''
+         #AMR66:
      if isinstance(packages, basestring): packages = [packages]
+     #if type(packages) is str: packages = [packages]
  
      if not packages:
          help('info')
          sys.stderr.write("\n*** Can't show info, no package names specified. ***\n")
          return
  
      for p in packages:
          d = get_info(p)
          print('')
          # NB: only prints fields we know about, if something is added
          # upstream we'll miss it here
          fields = ['name', 
              'version', 
              'sdesc', 
              'ldesc', 
              'category', 
              'requires', 
              'zip_path', 
              'zip_size', 
              'md5', 
              'local_zip', 
              'installed']
          for k in fields:
              print('{0:9}: {1}'.format(k,d[k]))
-         if d['installed']:
-             print('{0:9}: {1}'.format('install_v',d['install_v']))
  
          if debug:            
              # This guaranteed to print entire dict contents,
              # but not in a logical order.
-             print '\n----- DEBUG: %s -----' % sys._getframe().f_code.co_name
              for k in d.keys():
                  print('{0:8}:\t{1}'.format(k,d[k]))
-             print '-' * 36
</t>
<t tx="maphew.20150404102108.8">def parse_setup_ini(fname):
    '''Parse setup.ini into package name, description, version, dependencies, etc.
    
    Args:
        fname: full path to setup.ini
            
    Returns:
        A nested dictionary: {Distribution {Program_name{['category', 'source', 'ldesc', 'version', 'install', 'sdesc', 'requires']}}}
    
        {curr {
            'gdal' {
                'name': 'gdal',
                'version': '1.11.1-4',
                'category': 'Libs Commandline_Utilities',
                etc... }
            }}
    '''
    # global dists
    dists = {'test': {}, 'curr': {}, 'prev': {}}
    
    chunks = string.split(open(fname).read(), '\n\n@ ')
    for i in chunks[1:]:
        lines = string.split(i, '\n')
        name = string.strip(lines[0])
        if debug and verbose:
            print 'package: ' + name
        packages = dists['curr']
        records = {'sdesc': name}
        j = 1
        while j &lt; len(lines) and string.strip(lines[j]):
            if debug and verbose:
                print 'raw: ' + lines[j]
            if lines[j][0] == '#':
                j = j + 1
                continue
            elif lines[j][0] == '[':
                if debug and verbose:
                    print 'dist: ' + lines[j][1:5]
                packages[name] = records.copy()
                packages = dists[lines[j][1:5]]
                j = j + 1
                continue
            # split "field: value record for field" into dict record
            # e.g. "category: Libs Commandline_Utilities" 
            #   --&gt; {'category': 'Libs Commandline_Utilities'}
            try:
                key, value = map(string.strip,
                      string.split(lines[j], ': ', 1))
            except:
                print lines[j]
                raise TypeError('urg')
            
            #strip outer quotes?
            if value[0] == '"' and value.find('"', 1) == -1:
                while 1:
                    j = j + 1
                    value += lines[j]
                    if lines[j].find('"') != -1:
                        break
            
            records[key] = value
            j = j + 1
        packages[name] = records

    # this duplicated from get_info()
    # ...in order to populate keys built from 'install' and 'source'
    # FIXME: apply DRY and split into smaller re-usable functions
    for p in packages:
        # print p
        # print dists[distname][p]['install']
        d = dists[distname][p]
        d['name'] = p
        #print d    # debug peek at incoming dict
        try:
            # 'install' and 'source keys have compound values, atomize them
            d['zip_path'],d['zip_size'],d['md5'] = d['install'].split()
            
            ## issue #29
            #if not debug:
                #del d['install']
                
        except KeyError as e:
            d['zip_path'],d['zip_size'],d['md5'] = ('', '', '')
            if debug:
              print "\n*** Warning: '%s' is missing %s entry in setup.ini. This might cause problems.\n" % (p, e)

        try:
            d['src_zip_path'],d['src_zip_size'],d['src_md5'] = d['source'].split()
            if not debug:
                del d['source']
        except KeyError as e:
            d['src_zip_path'],d['src_zip_size'],d['src_md5'] = ('', '', '')
            
        #based on current mirror, might be different from when downloaded and/or installed
        d['local_zip'] = '%s/%s' % (downloads, d['zip_path'])
        d['mirror_path'] = '%s/%s' % (mirror, d['zip_path'])
            
        # insert the parsed fields back into parent dict
        dists[distname][p] = d
        
    # # print dists[distname]['gdal'].keys()    
    return dists
</t>
<t tx="maphew.20150404102108.9">def info(packages):
    '''info - report name, version, category, etc. about the package(s)
        
    B:\&gt; apt info shell
    
    name     : shell
    version  : 1.0.0-13
    sdesc    : "OSGeo4W Command Shell"
    ldesc    : "Menu and Desktop icon launch OSGeo4W command shell"
    category : Commandline_Utilities
    requires : msvcrt setup
    zip_path : x86/release/shell/shell-1.0.0-13.tar.bz2
    zip_size : 3763
    md5      : c38f03d2b7160f891fc36ec776ca4685
    local_zip: d:/temp/o4w-cache/setup/http%3.../shell-1.0.0-13.tar.bz2
        
    Note: "local_zip" is best guess based on current mirror. (We don't record which mirror was in use at the time of package install.)
    '''
        #AMR66:
    if isinstance(packages, basestring): packages = [packages]
    #if type(packages) is str: packages = [packages]

    if not packages:
        help('info')
        sys.stderr.write("\n*** Can't show info, no package names specified. ***\n")
        return

    for p in packages:
        d = get_info(p)
        print('')
        # NB: only prints fields we know about, if something is added
        # upstream we'll miss it here
        fields = ['name', 
            'version', 
            'sdesc', 
            'ldesc', 
            'category', 
            'requires', 
            'zip_path', 
            'zip_size', 
            'md5', 
            'local_zip', 
            'installed']
        for k in fields:
            print('{0:9}: {1}'.format(k,d[k]))

        if debug:            
            # This guaranteed to print entire dict contents,
            # but not in a logical order.
            for k in d.keys():
                print('{0:8}:\t{1}'.format(k,d[k]))
</t>
</tnodes>
</leo_file>
