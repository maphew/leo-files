<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<?xml-stylesheet ekr_test ?>
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
expanded="maphew.20100302221232.1487,maphew.20100223163802.3724,maphew.20100302221232.1485,"><vh>@file apt.py</vh></v>
<v t="maphew.20150330213839.2"><vh>Info</vh>
<v t="maphew.20141101125304.3"><vh>info</vh></v>
<v t="maphew.20141111130056.4"><vh>get_info</vh></v>
<v t="maphew.20100223163802.3754"><vh>parse_setup_ini</vh></v>
</v>
</v>
<v t="maphew.20150411172505.2" a="E"><vh>Recovered Nodes</vh>
<v t="maphew.20150411172505.3"><vh>Recovered node "get_info" from @file apt.py</vh>
<v t="maphew.20150411172505.4"><vh>old:get_info</vh></v>
<v t="maphew.20150411172505.5"><vh>new:get_info</vh></v>
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
    try:
        d = dists[distname][packagename]
    except KeyError:
        raise KeyError('*** Package "{}" not found in distribution "{}"'.format(packagename, distname))
        
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
<t tx="maphew.20150327024431.4">@path ../apt
@language python</t>
<t tx="maphew.20150330213839.2"></t>
<t tx="maphew.20150411172505.2"></t>
<t tx="maphew.20150411172505.3">(uncached) maphew.20141111130056.4
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
-     try:
-         d = dists[distname][packagename]
? ----
+     d = dists[distname][packagename]
-     except KeyError:
-         raise KeyError('*** Package "{}" not found in distribution "{}"'.format(packagename, distname))
-         
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
<t tx="maphew.20150411172505.4">def get_info(packagename):
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
<t tx="maphew.20150411172505.5">def get_info(packagename):
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
    try:
        d = dists[distname][packagename]
    except KeyError:
        raise KeyError('*** Package "{}" not found in distribution "{}"'.format(packagename, distname))
        
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
</tnodes>
</leo_file>
