Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF792CA6
	for <mptcp@lists.linux.dev>; Wed,  8 Dec 2021 22:20:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="224833833"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="224833833"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 14:20:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="461894614"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Dec 2021 14:19:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mv5I6-00017U-Eb; Wed, 08 Dec 2021 22:19:58 +0000
Date: Thu, 09 Dec 2021 06:19:37 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 bda85b38d2d553815a6a7d51d9b397e23bd8e4a8
Message-ID: <61b12f79.u5F7y5Hz4Lsd004Q%lkp@intel.com>
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
branch HEAD: bda85b38d2d553815a6a7d51d9b397e23bd8e4a8  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 733m

configs tested: 244
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211207
m68k                             alldefconfig
csky                                defconfig
arc                           tb10x_defconfig
arm                           tegra_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                        edosk7760_defconfig
riscv                            alldefconfig
mips                     cu1000-neo_defconfig
arm                            xcep_defconfig
xtensa                           allyesconfig
arm                           stm32_defconfig
powerpc                  storcenter_defconfig
arm                          imote2_defconfig
sh                           se7750_defconfig
arm                        shmobile_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           xway_defconfig
mips                        jmr3927_defconfig
h8300                            allyesconfig
h8300                     edosk2674_defconfig
mips                           rs90_defconfig
mips                      maltasmvp_defconfig
sh                        sh7763rdp_defconfig
csky                             alldefconfig
arc                        nsim_700_defconfig
sh                           se7705_defconfig
powerpc                      cm5200_defconfig
sparc64                             defconfig
powerpc                         wii_defconfig
parisc                           alldefconfig
arm                        spear6xx_defconfig
arm                           h5000_defconfig
mips                          ath25_defconfig
arm                         orion5x_defconfig
m68k                        stmark2_defconfig
mips                         tb0287_defconfig
arm                           corgi_defconfig
sh                               alldefconfig
sh                             espt_defconfig
mips                  decstation_64_defconfig
powerpc                      pasemi_defconfig
arm                           sama5_defconfig
powerpc                     pseries_defconfig
powerpc                     sequoia_defconfig
sh                          rsk7201_defconfig
powerpc                   motionpro_defconfig
arm                           h3600_defconfig
mips                      loongson3_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                           ip22_defconfig
mips                         tb0219_defconfig
mips                     loongson1c_defconfig
sparc64                          alldefconfig
arm                        magician_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                           omap1_defconfig
powerpc                       holly_defconfig
arm                      pxa255-idp_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7206_defconfig
um                           x86_64_defconfig
arm                         palmz72_defconfig
arm                       versatile_defconfig
mips                       rbtx49xx_defconfig
powerpc                 canyonlands_defconfig
mips                        workpad_defconfig
arm                      footbridge_defconfig
powerpc                      acadia_defconfig
sh                     sh7710voipgw_defconfig
sh                           se7721_defconfig
arm                         lpc18xx_defconfig
arc                              allyesconfig
arm                            hisi_defconfig
powerpc                        icon_defconfig
arm                        mvebu_v7_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                         ecovec24_defconfig
sh                           se7780_defconfig
arc                     haps_hs_smp_defconfig
m68k                            q40_defconfig
arc                 nsimosci_hs_smp_defconfig
arm64                            alldefconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
i386                             allyesconfig
mips                         db1xxx_defconfig
sh                          sdk7786_defconfig
arc                            hsdk_defconfig
powerpc                      katmai_defconfig
arm                         shannon_defconfig
sh                           se7722_defconfig
arm                         lpc32xx_defconfig
sh                           se7619_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                   lite5200b_defconfig
parisc                generic-32bit_defconfig
arc                              alldefconfig
openrisc                 simple_smp_defconfig
powerpc                      tqm8xx_defconfig
arm                          pcm027_defconfig
m68k                          sun3x_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                            zeus_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     powernv_defconfig
arc                      axs103_smp_defconfig
arm                        cerfcube_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
arm                         hackkit_defconfig
arm                          badge4_defconfig
mips                       lemote2f_defconfig
powerpc                  iss476-smp_defconfig
nios2                            allyesconfig
powerpc                     tqm8548_defconfig
sh                        sh7757lcr_defconfig
powerpc                    ge_imp3a_defconfig
mips                  maltasmvp_eva_defconfig
arc                         haps_hs_defconfig
arm                            pleb_defconfig
arm                     am200epdkit_defconfig
sh                     magicpanelr2_defconfig
arm                       mainstone_defconfig
powerpc                        cell_defconfig
arm                       spear13xx_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc8540_ads_defconfig
mips                        qi_lb60_defconfig
sparc                       sparc64_defconfig
arm                  randconfig-c002-20211207
arm                  randconfig-c002-20211209
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a003-20211207
i386                 randconfig-a001-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
x86_64               randconfig-a016-20211208
x86_64               randconfig-a011-20211208
x86_64               randconfig-a013-20211208
x86_64               randconfig-a012-20211208
x86_64               randconfig-a015-20211208
x86_64               randconfig-a014-20211208
arc                  randconfig-r043-20211208
s390                 randconfig-r044-20211208
riscv                randconfig-r042-20211208
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211207
arm                  randconfig-c002-20211207
riscv                randconfig-c006-20211207
mips                 randconfig-c004-20211207
i386                 randconfig-c001-20211207
powerpc              randconfig-c003-20211207
s390                 randconfig-c005-20211207
arm                  randconfig-c002-20211209
x86_64               randconfig-c007-20211209
riscv                randconfig-c006-20211209
i386                 randconfig-c001-20211209
mips                 randconfig-c004-20211209
powerpc              randconfig-c003-20211209
s390                 randconfig-c005-20211209
x86_64               randconfig-a006-20211208
x86_64               randconfig-a005-20211208
x86_64               randconfig-a001-20211208
x86_64               randconfig-a002-20211208
x86_64               randconfig-a004-20211208
x86_64               randconfig-a003-20211208
x86_64               randconfig-a016-20211207
x86_64               randconfig-a011-20211207
x86_64               randconfig-a013-20211207
x86_64               randconfig-a014-20211207
x86_64               randconfig-a015-20211207
x86_64               randconfig-a012-20211207
i386                 randconfig-a016-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
hexagon              randconfig-r045-20211208
hexagon              randconfig-r041-20211208
hexagon              randconfig-r045-20211207
s390                 randconfig-r044-20211207
riscv                randconfig-r042-20211207
hexagon              randconfig-r041-20211207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
