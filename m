Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944D168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641406932; x=1672942932;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FexL9zKX2HF7RJ1m9iXDDOAqTed7cdrC8ckwBPrTNWg=;
  b=Ug0yw8rVv93LcLgsDObnTW6yc1+bKKOir++pRQFeU+w8F2xI96w4zXSs
   ITyw9vLWajnRRbSPdrxiZsZqyUTaMRl8kzkOFLzPjtFSyWTlSFZm5ZKhi
   Ml4ODjpfgy0WlNnIURHg6NvvZh+H8aIuXzGTbP2Mye2AISFcyl1E24QM9
   GgddiMi0J3fQhHwPJ4wu+wEB4RjcVJFKyz7OVCrDJczoUt6F5M/ODXeKM
   viD6urTg2pz3eXxSNGlv+xVDzRdMZz5wO1OEufPjDlzhZozO0itW28x9h
   nDTQi2XjZeG8tkGSV7JPxdN+NJbMEFSfhGbTwVPWuYj9bJZ0ct3f/90Y+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242462604"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="242462604"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 10:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="591115607"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 10:21:49 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n5Auy-000Gvf-Di; Wed, 05 Jan 2022 18:21:48 +0000
Date: Thu, 06 Jan 2022 02:21:07 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 9478f9d57df23cfa5caa4317e75a6efe6e782ab3
Message-ID: <61d5e193.udR1w0T5SBGpaYZd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

tree/branch: https://github.com/multipath-tcp/mptcp_net-next.git export
branch HEAD: 9478f9d57df23cfa5caa4317e75a6efe6e782ab3  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 723m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
