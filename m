Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDE173
	for <mptcp@lists.linux.dev>; Mon, 13 Dec 2021 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639427638; x=1670963638;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5D7KJsBUxe2kZU/WqWZmUaWt/a69N0aoESLbvcOh6sc=;
  b=aOsa6fl+T2YPlMBSV422P29np3ibLVb0FxW60RgZ+HvdF5LujsyDlhuZ
   +mDLSbPvfTZBi5Cqd3+7+4a2phXjaJZniUq6GeugHePh3CJhrv6NqI0UQ
   1ki2gdZseJjJy0Aa3UK9ztZKkhU6SoQO2IiyRTwvkp7rtdwSZBdVbwFGr
   zyGjqyceWRgtLThCtyz9rlTCtuws5p1aXCsoKhNcJttlYUKinbo8YHwVV
   /KnnI4FUD17HlCQ6iiJroO3XvIJT/1aiOnmDzfRZzJcNfH/rGn5lkpah4
   8TpWqVg2mpGxUx0ZKn1Hik0uqN58OS8PensDMck29GJlSbdsWCiAkas02
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="218840073"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="218840073"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 12:33:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="464785932"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 12:33:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mws1D-00072T-2O; Mon, 13 Dec 2021 20:33:55 +0000
Date: Tue, 14 Dec 2021 04:32:59 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 fa9c2885492d7189f9403d92ae3f68f540002093
Message-ID: <61b7adfb.eX6qm3b6VqAkoHvx%lkp@intel.com>
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
branch HEAD: fa9c2885492d7189f9403d92ae3f68f540002093  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 831m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211213
mips                      fuloong2e_defconfig
m68k                        mvme16x_defconfig
microblaze                          defconfig
riscv                            alldefconfig
nios2                         10m50_defconfig
mips                     cu1830-neo_defconfig
mips                     loongson1c_defconfig
mips                           mtx1_defconfig
powerpc                     tqm8541_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         at91_dt_defconfig
powerpc                      ppc64e_defconfig
mips                       rbtx49xx_defconfig
mips                         tb0287_defconfig
arm                          pxa3xx_defconfig
powerpc                      pasemi_defconfig
sh                          r7780mp_defconfig
ia64                        generic_defconfig
sh                           sh2007_defconfig
arm                  randconfig-c002-20211213
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                               defconfig
i386                   debian-10.3-kselftests
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a011-20211213
x86_64               randconfig-a012-20211213
x86_64               randconfig-a014-20211213
x86_64               randconfig-a013-20211213
x86_64               randconfig-a016-20211213
x86_64               randconfig-a015-20211213
i386                 randconfig-a013-20211213
i386                 randconfig-a011-20211213
i386                 randconfig-a012-20211213
i386                 randconfig-a015-20211213
i386                 randconfig-a016-20211213
i386                 randconfig-a014-20211213
arc                  randconfig-r043-20211213
riscv                randconfig-r042-20211213
s390                 randconfig-r044-20211213
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-c007-20211213
arm                  randconfig-c002-20211213
mips                 randconfig-c004-20211213
i386                 randconfig-c001-20211213
s390                 randconfig-c005-20211213
powerpc              randconfig-c003-20211213
riscv                randconfig-c006-20211213
i386                 randconfig-a001-20211213
i386                 randconfig-a002-20211213
i386                 randconfig-a005-20211213
i386                 randconfig-a003-20211213
i386                 randconfig-a004-20211213
i386                 randconfig-a006-20211213
x86_64               randconfig-a001-20211213
x86_64               randconfig-a002-20211213
x86_64               randconfig-a003-20211213
x86_64               randconfig-a005-20211213
x86_64               randconfig-a004-20211213
x86_64               randconfig-a006-20211213
hexagon              randconfig-r045-20211213
hexagon              randconfig-r041-20211213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
