Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928672
	for <mptcp@lists.linux.dev>; Sun, 21 Nov 2021 18:05:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="234914916"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800"; 
   d="scan'208";a="234914916"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 10:05:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800"; 
   d="scan'208";a="508649863"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2021 10:04:59 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1morD0-00075P-VY; Sun, 21 Nov 2021 18:04:58 +0000
Date: Mon, 22 Nov 2021 02:04:29 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 9ab77fab7bf0a4241948923c03a374f92577b334
Message-ID: <619a8a2d.aScpqD9nqWVZ63cm%lkp@intel.com>
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
branch HEAD: 9ab77fab7bf0a4241948923c03a374f92577b334  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 720m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
nds32                            alldefconfig
powerpc                       maple_defconfig
h8300                     edosk2674_defconfig
mips                     cu1000-neo_defconfig
arm                            pleb_defconfig
arm                       spear13xx_defconfig
sh                           se7722_defconfig
sh                          rsk7264_defconfig
mips                      fuloong2e_defconfig
mips                     loongson1b_defconfig
arm                          simpad_defconfig
sh                     sh7710voipgw_defconfig
s390                                defconfig
mips                  cavium_octeon_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                         db1xxx_defconfig
mips                        bcm47xx_defconfig
arm                        multi_v5_defconfig
powerpc                     tqm8541_defconfig
sh                               alldefconfig
powerpc                 mpc832x_mds_defconfig
riscv                    nommu_virt_defconfig
powerpc                      obs600_defconfig
arm                          iop32x_defconfig
xtensa                       common_defconfig
powerpc                     stx_gp3_defconfig
sh                        sh7785lcr_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    ge_imp3a_defconfig
arm                         assabet_defconfig
mips                        vocore2_defconfig
sh                          urquell_defconfig
sh                        apsh4ad0a_defconfig
nios2                               defconfig
arm                             pxa_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7269_defconfig
arm                             rpc_defconfig
powerpc                      ppc40x_defconfig
powerpc                      pcm030_defconfig
riscv                            allyesconfig
sh                          r7785rp_defconfig
arm                  randconfig-c002-20211121
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64               randconfig-a001-20211121
x86_64               randconfig-a006-20211121
x86_64               randconfig-a003-20211121
x86_64               randconfig-a004-20211121
x86_64               randconfig-a005-20211121
x86_64               randconfig-a002-20211121
i386                 randconfig-a001-20211121
i386                 randconfig-a002-20211121
i386                 randconfig-a005-20211121
i386                 randconfig-a006-20211121
i386                 randconfig-a004-20211121
i386                 randconfig-a003-20211121
arc                  randconfig-r043-20211121
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
i386                 randconfig-c001-20211121
powerpc              randconfig-c003-20211121
arm                  randconfig-c002-20211121
x86_64               randconfig-c007-20211121
mips                 randconfig-c004-20211121
s390                 randconfig-c005-20211121
riscv                randconfig-c006-20211121
x86_64               randconfig-a011-20211121
x86_64               randconfig-a012-20211121
x86_64               randconfig-a013-20211121
x86_64               randconfig-a014-20211121
x86_64               randconfig-a016-20211121
x86_64               randconfig-a015-20211121
i386                 randconfig-a015-20211121
i386                 randconfig-a012-20211121
i386                 randconfig-a013-20211121
i386                 randconfig-a014-20211121
i386                 randconfig-a011-20211121
i386                 randconfig-a016-20211121
hexagon              randconfig-r045-20211121
s390                 randconfig-r044-20211121
hexagon              randconfig-r041-20211121
riscv                randconfig-r042-20211121

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
