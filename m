Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C0111AC;
	Thu, 29 Jun 2023 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688040868; x=1719576868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F+eUbxapSGsiKtbiiIpQEK35DPmhD2vQTTmQL63nLO8=;
  b=JX28RcJLuhCPTK79GyIZfvxuQSgmzxTlHNnz5lergezrhaQQRJry7p7P
   iu2AjD5uYuKn72eUGa6481A98HbzsjCwwKWhyvjFyk4VS517LraWqQaM7
   eqXw62fbXlPu7Ogww+PDnMEwSOJdNqA5bE0g/RKpq5ATEVcvdgDvvow2h
   u4AKuSQwX706J9owbiDVmQ/EhCoPfOm48tmL3A3yMsQkAYOHd/H7lTyCV
   bJgQXmDWzP+uX0LpjL8Xda7Vko4gVxqd4lUEZ+AKs9HDTHFAFBQHqjBuJ
   sfpS5pC98cREHa0nSE3vQPx+IAy6I8/JT2nnpjuqEG8aAJ5RlkWSoEEs1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="425761183"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="425761183"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 05:14:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="807283468"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="807283468"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2023 05:14:26 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qEqXZ-000E8L-0s;
	Thu, 29 Jun 2023 12:14:25 +0000
Date: Thu, 29 Jun 2023 20:13:53 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 2/38] fs/9p/vfs_file.c:402:25: error: 'P9L_DIRECT'
 undeclared; did you mean 'O_DIRECT'?
Message-ID: <202306292059.k2EzIIBV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   1834f1b52832f22323858d372f37f1a77ebe545b
commit: d258ffa36db2ae9e693e09a87b24a9465d2be84c [2/38] Revert "Merge tag '9p-6.4-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs"
config: i386-defconfig (https://download.01.org/0day-ci/archive/20230629/202306292059.k2EzIIBV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306292059.k2EzIIBV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306292059.k2EzIIBV-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/9p/vfs_file.c: In function 'v9fs_file_splice_read':
>> fs/9p/vfs_file.c:402:25: error: 'P9L_DIRECT' undeclared (first use in this function); did you mean 'O_DIRECT'?
     402 |         if (fid->mode & P9L_DIRECT)
         |                         ^~~~~~~~~~
         |                         O_DIRECT
   fs/9p/vfs_file.c:402:25: note: each undeclared identifier is reported only once for each function it appears in


vim +402 fs/9p/vfs_file.c

e69e7fe5b0c86b Eric Van Hensbergen 2005-09-09  384  
c829d0bd33ac0d David Howells       2023-05-22  385  /*
c829d0bd33ac0d David Howells       2023-05-22  386   * v9fs_file_splice_read - splice-read from a file
c829d0bd33ac0d David Howells       2023-05-22  387   * @in: The 9p file to read from
c829d0bd33ac0d David Howells       2023-05-22  388   * @ppos: Where to find/update the file position
c829d0bd33ac0d David Howells       2023-05-22  389   * @pipe: The pipe to splice into
c829d0bd33ac0d David Howells       2023-05-22  390   * @len: The maximum amount of data to splice
c829d0bd33ac0d David Howells       2023-05-22  391   * @flags: SPLICE_F_* flags
c829d0bd33ac0d David Howells       2023-05-22  392   */
c829d0bd33ac0d David Howells       2023-05-22  393  static ssize_t v9fs_file_splice_read(struct file *in, loff_t *ppos,
c829d0bd33ac0d David Howells       2023-05-22  394  				     struct pipe_inode_info *pipe,
c829d0bd33ac0d David Howells       2023-05-22  395  				     size_t len, unsigned int flags)
c829d0bd33ac0d David Howells       2023-05-22  396  {
c829d0bd33ac0d David Howells       2023-05-22  397  	struct p9_fid *fid = in->private_data;
c829d0bd33ac0d David Howells       2023-05-22  398  
c829d0bd33ac0d David Howells       2023-05-22  399  	p9_debug(P9_DEBUG_VFS, "fid %d count %zu offset %lld\n",
c829d0bd33ac0d David Howells       2023-05-22  400  		 fid->fid, len, *ppos);
c829d0bd33ac0d David Howells       2023-05-22  401  
c829d0bd33ac0d David Howells       2023-05-22 @402  	if (fid->mode & P9L_DIRECT)
c829d0bd33ac0d David Howells       2023-05-22  403  		return copy_splice_read(in, ppos, pipe, len, flags);
c829d0bd33ac0d David Howells       2023-05-22  404  	return filemap_splice_read(in, ppos, pipe, len, flags);
c829d0bd33ac0d David Howells       2023-05-22  405  }
c829d0bd33ac0d David Howells       2023-05-22  406  

:::::: The code at line 402 was first introduced by commit
:::::: c829d0bd33ac0df8cece64e50ec71a63f17790f8 9p: Add splice_read wrapper

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
