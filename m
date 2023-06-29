Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA6111AC;
	Thu, 29 Jun 2023 12:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688040929; x=1719576929;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eCVH5uDUpgrHoucii/u97i1adq0n9iGbppKDQCac4lU=;
  b=K31OhWRPFVfNRPLhOtNExk49trofoSRq1miPIkxCfFSnDX/E0pJNItYA
   cANGoNHY2pAwjavKvtQnk7qwWNeVGO1O2KQNo3yG8fus5OyRCdMD28rQ6
   WuTeuwVrI/8m1dAxQtAEpjCL5gHcLJI6bcY0x9L5mUB3pzm9TAHkyZpsY
   5REUAPVkfRqQMQREHutPCsSBc5se1wH9sNx/XWAEBwl3utggda44G8UsX
   ULsH1jYZ6d5D8y7+Qi4vmVdhTQiBwQjBu35HHGP3hN1p0vToc3+2fPyq5
   kfa34HCHUSm0agSb0J0eh12+PnlcmmnVhK3JT1AV/f9eFHpei/cUxHJF5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="392814490"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="392814490"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 05:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="891381274"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="891381274"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Jun 2023 05:15:26 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qEqYX-000E8P-0x;
	Thu, 29 Jun 2023 12:15:25 +0000
Date: Thu, 29 Jun 2023 20:14:41 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mptcp@lists.linux.dev
Subject: [mptcp:export 2/38] fs/9p/vfs_file.c:402:18: error: use of
 undeclared identifier 'P9L_DIRECT'
Message-ID: <202306292023.qN92MN5A-lkp@intel.com>
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
config: riscv-randconfig-r042-20230629 (https://download.01.org/0day-ci/archive/20230629/202306292023.qN92MN5A-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306292023.qN92MN5A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306292023.qN92MN5A-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:743:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     743 |         insb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
     104 | #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from fs/9p/vfs_file.c:18:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:751:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     751 |         insw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
     105 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from fs/9p/vfs_file.c:18:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:759:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     759 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from fs/9p/vfs_file.c:18:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:768:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     768 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
     118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from fs/9p/vfs_file.c:18:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:777:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     777 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
     119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from fs/9p/vfs_file.c:18:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:786:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     786 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from fs/9p/vfs_file.c:18:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1134:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1134 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> fs/9p/vfs_file.c:402:18: error: use of undeclared identifier 'P9L_DIRECT'
     402 |         if (fid->mode & P9L_DIRECT)
         |                         ^
   13 warnings and 1 error generated.


vim +/P9L_DIRECT +402 fs/9p/vfs_file.c

e69e7fe5b0c86b7 Eric Van Hensbergen 2005-09-09  384  
c829d0bd33ac0df David Howells       2023-05-22  385  /*
c829d0bd33ac0df David Howells       2023-05-22  386   * v9fs_file_splice_read - splice-read from a file
c829d0bd33ac0df David Howells       2023-05-22  387   * @in: The 9p file to read from
c829d0bd33ac0df David Howells       2023-05-22  388   * @ppos: Where to find/update the file position
c829d0bd33ac0df David Howells       2023-05-22  389   * @pipe: The pipe to splice into
c829d0bd33ac0df David Howells       2023-05-22  390   * @len: The maximum amount of data to splice
c829d0bd33ac0df David Howells       2023-05-22  391   * @flags: SPLICE_F_* flags
c829d0bd33ac0df David Howells       2023-05-22  392   */
c829d0bd33ac0df David Howells       2023-05-22  393  static ssize_t v9fs_file_splice_read(struct file *in, loff_t *ppos,
c829d0bd33ac0df David Howells       2023-05-22  394  				     struct pipe_inode_info *pipe,
c829d0bd33ac0df David Howells       2023-05-22  395  				     size_t len, unsigned int flags)
c829d0bd33ac0df David Howells       2023-05-22  396  {
c829d0bd33ac0df David Howells       2023-05-22  397  	struct p9_fid *fid = in->private_data;
c829d0bd33ac0df David Howells       2023-05-22  398  
c829d0bd33ac0df David Howells       2023-05-22  399  	p9_debug(P9_DEBUG_VFS, "fid %d count %zu offset %lld\n",
c829d0bd33ac0df David Howells       2023-05-22  400  		 fid->fid, len, *ppos);
c829d0bd33ac0df David Howells       2023-05-22  401  
c829d0bd33ac0df David Howells       2023-05-22 @402  	if (fid->mode & P9L_DIRECT)
c829d0bd33ac0df David Howells       2023-05-22  403  		return copy_splice_read(in, ppos, pipe, len, flags);
c829d0bd33ac0df David Howells       2023-05-22  404  	return filemap_splice_read(in, ppos, pipe, len, flags);
c829d0bd33ac0df David Howells       2023-05-22  405  }
c829d0bd33ac0df David Howells       2023-05-22  406  

:::::: The code at line 402 was first introduced by commit
:::::: c829d0bd33ac0df8cece64e50ec71a63f17790f8 9p: Add splice_read wrapper

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
