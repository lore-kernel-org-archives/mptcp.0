Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E86A68
	for <mptcp@lists.linux.dev>; Sun,  5 Dec 2021 08:48:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="237112386"
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="237112386"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 00:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="678622851"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2021 00:48:25 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mtnC4-000Jz0-JJ; Sun, 05 Dec 2021 08:48:24 +0000
Date: Sun, 05 Dec 2021 16:47:54 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 2d64243a2b0d9ac768a8e85e76299acc67ca9eb4
Message-ID: <61ac7cba.ANWC7ixHgQvbKsQP%lkp@intel.com>
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
branch HEAD: 2d64243a2b0d9ac768a8e85e76299acc67ca9eb4  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 1600m

configs tested: 189
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211203
arm                        clps711x_defconfig
alpha                            alldefconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
powerpc                     mpc5200_defconfig
sh                      rts7751r2d1_defconfig
nios2                               defconfig
arm                         shannon_defconfig
powerpc                 mpc8540_ads_defconfig
sh                        edosk7760_defconfig
powerpc                     tqm8555_defconfig
openrisc                    or1ksim_defconfig
arc                              allyesconfig
sh                            hp6xx_defconfig
arm                          pxa3xx_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
powerpc                     ppa8548_defconfig
openrisc                         alldefconfig
sh                        sh7785lcr_defconfig
powerpc                  mpc866_ads_defconfig
sh                          kfr2r09_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                          atari_defconfig
powerpc                     tqm8560_defconfig
sh                     sh7710voipgw_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc834x_itx_defconfig
arm                         lpc32xx_defconfig
arm                       aspeed_g5_defconfig
powerpc                      cm5200_defconfig
powerpc                     skiroot_defconfig
arm                           sunxi_defconfig
powerpc                     tqm8541_defconfig
arm                          ep93xx_defconfig
m68k                            mac_defconfig
arm                          badge4_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      walnut_defconfig
m68k                        m5407c3_defconfig
ia64                          tiger_defconfig
xtensa                       common_defconfig
powerpc                          g5_defconfig
powerpc                      katmai_defconfig
arm                        neponset_defconfig
arm                      integrator_defconfig
powerpc                     kilauea_defconfig
sh                   sh7724_generic_defconfig
powerpc                    socrates_defconfig
sh                           se7712_defconfig
arm                           stm32_defconfig
sh                           se7780_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          lpd270_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         lubbock_defconfig
s390                       zfcpdump_defconfig
um                           x86_64_defconfig
sh                        sh7757lcr_defconfig
sh                           se7721_defconfig
arm                            qcom_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        mvebu_v5_defconfig
arm                            mps2_defconfig
arm                    vt8500_v6_v7_defconfig
i386                             allyesconfig
arc                     haps_hs_smp_defconfig
m68k                        m5307c3_defconfig
arc                         haps_hs_defconfig
arm                          moxart_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     mpc512x_defconfig
sh                         apsh4a3a_defconfig
sh                            migor_defconfig
arm                           h5000_defconfig
powerpc                     tqm8548_defconfig
arm                  randconfig-c002-20211205
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211203
x86_64               randconfig-a005-20211203
x86_64               randconfig-a001-20211203
x86_64               randconfig-a002-20211203
x86_64               randconfig-a004-20211203
x86_64               randconfig-a003-20211203
x86_64               randconfig-a006-20211205
x86_64               randconfig-a005-20211205
x86_64               randconfig-a001-20211205
x86_64               randconfig-a002-20211205
x86_64               randconfig-a004-20211205
x86_64               randconfig-a003-20211205
i386                 randconfig-a001-20211205
i386                 randconfig-a005-20211205
i386                 randconfig-a003-20211205
i386                 randconfig-a002-20211205
i386                 randconfig-a006-20211205
i386                 randconfig-a004-20211205
i386                 randconfig-a001-20211203
i386                 randconfig-a005-20211203
i386                 randconfig-a002-20211203
i386                 randconfig-a003-20211203
i386                 randconfig-a006-20211203
i386                 randconfig-a004-20211203
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20211203
x86_64               randconfig-a011-20211203
x86_64               randconfig-a013-20211203
x86_64               randconfig-a014-20211203
x86_64               randconfig-a015-20211203
x86_64               randconfig-a012-20211203
x86_64               randconfig-a016-20211205
x86_64               randconfig-a011-20211205
x86_64               randconfig-a013-20211205
x86_64               randconfig-a015-20211205
x86_64               randconfig-a012-20211205
x86_64               randconfig-a014-20211205
i386                 randconfig-a016-20211203
i386                 randconfig-a013-20211203
i386                 randconfig-a011-20211203
i386                 randconfig-a014-20211203
i386                 randconfig-a012-20211203
i386                 randconfig-a015-20211203
i386                 randconfig-a013-20211205
i386                 randconfig-a016-20211205
i386                 randconfig-a011-20211205
i386                 randconfig-a014-20211205
i386                 randconfig-a012-20211205
i386                 randconfig-a015-20211205
hexagon              randconfig-r045-20211203
s390                 randconfig-r044-20211203
hexagon              randconfig-r041-20211203
riscv                randconfig-r042-20211203
hexagon              randconfig-r045-20211205
s390                 randconfig-r044-20211205
riscv                randconfig-r042-20211205
hexagon              randconfig-r041-20211205
hexagon              randconfig-r045-20211204
hexagon              randconfig-r041-20211204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
