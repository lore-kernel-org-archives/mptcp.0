Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0B72C82
	for <mptcp@lists.linux.dev>; Sun, 14 Nov 2021 05:35:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10167"; a="319508452"
X-IronPort-AV: E=Sophos;i="5.87,233,1631602800"; 
   d="scan'208";a="319508452"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2021 21:35:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,233,1631602800"; 
   d="scan'208";a="453624821"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2021 21:35:28 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mm8Ap-000KzZ-NZ; Sun, 14 Nov 2021 05:35:27 +0000
Date: Sun, 14 Nov 2021 13:35:23 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 aadccf14af5add5f0a7c20368f42a4e43b93b92f
Message-ID: <6190a01b.XJnIC1l4ISSWKlcy%lkp@intel.com>
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
branch HEAD: aadccf14af5add5f0a7c20368f42a4e43b93b92f  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 1408m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211113
powerpc                   motionpro_defconfig
powerpc                     asp8347_defconfig
arm                           omap1_defconfig
powerpc                    gamecube_defconfig
powerpc                     tqm8548_defconfig
arm                         cm_x300_defconfig
arm                        spear6xx_defconfig
riscv                            alldefconfig
sh                             espt_defconfig
m68k                         amcore_defconfig
mips                        jmr3927_defconfig
h8300                            allyesconfig
riscv                    nommu_k210_defconfig
arm                         lpc18xx_defconfig
powerpc                      ppc44x_defconfig
arm                          imote2_defconfig
powerpc                 mpc837x_rdb_defconfig
x86_64                           allyesconfig
powerpc                   lite5200b_defconfig
powerpc                       eiger_defconfig
arm                        trizeps4_defconfig
arm                        shmobile_defconfig
nds32                             allnoconfig
mips                        omega2p_defconfig
powerpc                        fsp2_defconfig
sh                           sh2007_defconfig
ia64                             allmodconfig
m68k                       m5249evb_defconfig
m68k                       bvme6000_defconfig
powerpc                 mpc837x_mds_defconfig
mips                      loongson3_defconfig
powerpc                      pmac32_defconfig
m68k                        mvme16x_defconfig
arm                          ep93xx_defconfig
mips                             allmodconfig
mips                         bigsur_defconfig
microblaze                          defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            zeus_defconfig
powerpc                       maple_defconfig
arm                           viper_defconfig
sh                         ap325rxa_defconfig
openrisc                  or1klitex_defconfig
mips                           ip32_defconfig
arm                  randconfig-c002-20211113
arm                  randconfig-c002-20211114
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                            allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                              allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
nios2                               defconfig
parisc                              defconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a015-20211114
x86_64               randconfig-a013-20211114
x86_64               randconfig-a012-20211114
x86_64               randconfig-a011-20211114
x86_64               randconfig-a016-20211114
x86_64               randconfig-a014-20211114
i386                 randconfig-a014-20211114
i386                 randconfig-a016-20211114
i386                 randconfig-a012-20211114
i386                 randconfig-a013-20211114
i386                 randconfig-a011-20211114
i386                 randconfig-a015-20211114
arc                  randconfig-r043-20211114
s390                 randconfig-r044-20211114
riscv                randconfig-r042-20211114
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211114
i386                 randconfig-c001-20211114
arm                  randconfig-c002-20211114
riscv                randconfig-c006-20211114
powerpc              randconfig-c003-20211114
s390                 randconfig-c005-20211114
mips                 randconfig-c004-20211114
i386                 randconfig-a006-20211114
i386                 randconfig-a003-20211114
i386                 randconfig-a005-20211114
i386                 randconfig-a001-20211114
i386                 randconfig-a004-20211114
i386                 randconfig-a002-20211114
x86_64               randconfig-a005-20211114
x86_64               randconfig-a003-20211114
x86_64               randconfig-a001-20211114
x86_64               randconfig-a002-20211114
x86_64               randconfig-a006-20211114
x86_64               randconfig-a004-20211114
i386                 randconfig-a016-20211113
i386                 randconfig-a014-20211113
i386                 randconfig-a012-20211113
i386                 randconfig-a013-20211113
i386                 randconfig-a011-20211113
i386                 randconfig-a015-20211113
hexagon              randconfig-r045-20211114
hexagon              randconfig-r041-20211114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
