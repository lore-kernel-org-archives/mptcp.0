Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06CE68
	for <mptcp@lists.linux.dev>; Wed, 17 Nov 2021 20:11:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="231527067"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="231527067"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 12:11:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="454779208"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2021 12:11:14 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mnRGz-0002AH-O5; Wed, 17 Nov 2021 20:11:13 +0000
Date: Thu, 18 Nov 2021 04:11:09 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 98fb1b1ee27f9173f03e2787422ad1045b988a96
Message-ID: <619561dd.3BCIRc3N1HnjBc46%lkp@intel.com>
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
branch HEAD: 98fb1b1ee27f9173f03e2787422ad1045b988a96  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 787m

configs tested: 117
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          gemini_defconfig
ia64                          tiger_defconfig
s390                       zfcpdump_defconfig
powerpc                      mgcoge_defconfig
sh                          rsk7269_defconfig
riscv                            alldefconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    ge_imp3a_defconfig
sh                   secureedge5410_defconfig
mips                      loongson3_defconfig
arm                           corgi_defconfig
powerpc                      ep88xc_defconfig
sh                          r7780mp_defconfig
mips                        jmr3927_defconfig
arm                        mini2440_defconfig
arm                         s3c2410_defconfig
powerpc                   motionpro_defconfig
arm                       omap2plus_defconfig
powerpc                 xes_mpc85xx_defconfig
sparc                       sparc32_defconfig
riscv                          rv32_defconfig
m68k                        stmark2_defconfig
powerpc                     mpc5200_defconfig
arm                       aspeed_g5_defconfig
sh                           se7619_defconfig
arm                              alldefconfig
sh                 kfr2r09-romimage_defconfig
x86_64                              defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                        cell_defconfig
arm                           tegra_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             alldefconfig
arc                        nsimosci_defconfig
arm                  randconfig-c002-20211117
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20211117
x86_64               randconfig-a003-20211117
x86_64               randconfig-a002-20211117
x86_64               randconfig-a001-20211117
x86_64               randconfig-a006-20211117
x86_64               randconfig-a004-20211117
i386                 randconfig-a003-20211117
i386                 randconfig-a001-20211117
i386                 randconfig-a002-20211117
i386                 randconfig-a004-20211117
i386                 randconfig-a006-20211117
i386                 randconfig-a005-20211117
arc                  randconfig-r043-20211117
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a015-20211117
x86_64               randconfig-a013-20211117
x86_64               randconfig-a011-20211117
x86_64               randconfig-a012-20211117
x86_64               randconfig-a016-20211117
x86_64               randconfig-a014-20211117
i386                 randconfig-a014-20211117
i386                 randconfig-a016-20211117
i386                 randconfig-a012-20211117
i386                 randconfig-a013-20211117
i386                 randconfig-a011-20211117
i386                 randconfig-a015-20211117
hexagon              randconfig-r045-20211117
hexagon              randconfig-r041-20211117
s390                 randconfig-r044-20211117
riscv                randconfig-r042-20211117

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
