Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC468
	for <mptcp@lists.linux.dev>; Wed,  3 Nov 2021 18:55:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="218762879"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="218762879"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 11:55:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="450173500"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2021 11:55:27 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1miLPy-0005mx-Fe; Wed, 03 Nov 2021 18:55:26 +0000
Date: Thu, 04 Nov 2021 02:55:13 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 b98e1b93fdd5f7daab4985fc9c1736f7fb462d26
Message-ID: <6182db11.mDl6a53w48KYEtNv%lkp@intel.com>
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
branch HEAD: b98e1b93fdd5f7daab4985fc9c1736f7fb462d26  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 754m

configs tested: 145
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211103
powerpc                   motionpro_defconfig
ia64                        generic_defconfig
powerpc                     tqm8560_defconfig
m68k                        m5307c3_defconfig
arc                      axs103_smp_defconfig
arm                        spear6xx_defconfig
i386                                defconfig
arm                         lpc18xx_defconfig
sh                         ecovec24_defconfig
mips                       lemote2f_defconfig
sh                          kfr2r09_defconfig
nios2                            allyesconfig
mips                     loongson1c_defconfig
powerpc                  storcenter_defconfig
powerpc                     tqm8555_defconfig
m68k                       m5475evb_defconfig
mips                     loongson1b_defconfig
powerpc                        fsp2_defconfig
m68k                         amcore_defconfig
powerpc                      cm5200_defconfig
mips                         mpc30x_defconfig
powerpc                        icon_defconfig
sh                           se7721_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
powerpc                         wii_defconfig
arm                          badge4_defconfig
mips                      maltaaprp_defconfig
sh                        edosk7760_defconfig
sh                               allmodconfig
openrisc                            defconfig
powerpc                      arches_defconfig
powerpc                     ppa8548_defconfig
openrisc                  or1klitex_defconfig
sh                          rsk7269_defconfig
m68k                        mvme16x_defconfig
powerpc                 mpc8560_ads_defconfig
arc                                 defconfig
nios2                         3c120_defconfig
arm64                            alldefconfig
arm                           stm32_defconfig
powerpc                     tqm8548_defconfig
sh                           se7780_defconfig
m68k                            q40_defconfig
mips                           jazz_defconfig
arm                        mvebu_v7_defconfig
powerpc                      pmac32_defconfig
sh                     sh7710voipgw_defconfig
powerpc                    sam440ep_defconfig
arm                     eseries_pxa_defconfig
arm                       imx_v6_v7_defconfig
riscv                    nommu_virt_defconfig
h8300                    h8300h-sim_defconfig
arc                          axs101_defconfig
mips                      maltasmvp_defconfig
sh                         microdev_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            shmin_defconfig
powerpc                    adder875_defconfig
ia64                          tiger_defconfig
arm                        vexpress_defconfig
arm                  randconfig-c002-20211103
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a012-20211103
x86_64               randconfig-a015-20211103
x86_64               randconfig-a016-20211103
x86_64               randconfig-a011-20211103
x86_64               randconfig-a013-20211103
x86_64               randconfig-a014-20211103
i386                 randconfig-a014-20211103
i386                 randconfig-a016-20211103
i386                 randconfig-a013-20211103
i386                 randconfig-a015-20211103
i386                 randconfig-a011-20211103
i386                 randconfig-a012-20211103
arc                  randconfig-r043-20211103
riscv                randconfig-r042-20211103
s390                 randconfig-r044-20211103
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20211103
s390                 randconfig-c005-20211103
powerpc              randconfig-c003-20211103
riscv                randconfig-c006-20211103
arm                  randconfig-c002-20211103
i386                 randconfig-c001-20211103
x86_64               randconfig-c007-20211103
x86_64               randconfig-a006-20211103
x86_64               randconfig-a004-20211103
x86_64               randconfig-a001-20211103
x86_64               randconfig-a002-20211103
x86_64               randconfig-a005-20211103
x86_64               randconfig-a003-20211103
i386                 randconfig-a005-20211103
i386                 randconfig-a003-20211103
i386                 randconfig-a001-20211103
i386                 randconfig-a004-20211103
i386                 randconfig-a006-20211103
i386                 randconfig-a002-20211103
hexagon              randconfig-r041-20211103
hexagon              randconfig-r045-20211103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
