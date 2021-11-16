Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A802C87
	for <mptcp@lists.linux.dev>; Tue, 16 Nov 2021 21:56:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="297256826"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="297256826"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 13:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="506632854"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2021 13:56:24 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mn6RD-0000s7-S0; Tue, 16 Nov 2021 21:56:23 +0000
Date: Wed, 17 Nov 2021 05:55:35 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 1ee2f5689da40817983433bca56d68b37cf625c8
Message-ID: <619428d7.yb8PwbjWOuzElF2t%lkp@intel.com>
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
branch HEAD: 1ee2f5689da40817983433bca56d68b37cf625c8  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 731m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211116
mips                 randconfig-c004-20211116
mips                         tb0287_defconfig
sh                   sh7724_generic_defconfig
m68k                       m5249evb_defconfig
x86_64                              defconfig
arm                        cerfcube_defconfig
powerpc                       eiger_defconfig
mips                     loongson2k_defconfig
powerpc                    socrates_defconfig
xtensa                       common_defconfig
mips                  decstation_64_defconfig
m68k                        mvme16x_defconfig
sh                          sdk7786_defconfig
sh                          r7785rp_defconfig
powerpc                        fsp2_defconfig
s390                       zfcpdump_defconfig
arm                        mini2440_defconfig
microblaze                          defconfig
sh                          landisk_defconfig
arm                         at91_dt_defconfig
m68k                        m5407c3_defconfig
openrisc                            defconfig
mips                 decstation_r4k_defconfig
arm                        clps711x_defconfig
arm                         socfpga_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
powerpc                        cell_defconfig
arm                         axm55xx_defconfig
arm                           sama5_defconfig
mips                          rm200_defconfig
arm                           stm32_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
powerpc                         ps3_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          gemini_defconfig
arm                     eseries_pxa_defconfig
arm                           u8500_defconfig
mips                         cobalt_defconfig
arm                             mxs_defconfig
sh                   secureedge5410_defconfig
powerpc                      bamboo_defconfig
h8300                               defconfig
arm                       aspeed_g4_defconfig
arm                       imx_v6_v7_defconfig
powerpc                 mpc832x_mds_defconfig
s390                             alldefconfig
nds32                            alldefconfig
arm                             pxa_defconfig
xtensa                    xip_kc705_defconfig
arm                             rpc_defconfig
mips                         mpc30x_defconfig
nios2                         3c120_defconfig
arm                       mainstone_defconfig
powerpc                         wii_defconfig
powerpc                     mpc512x_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          rsk7264_defconfig
m68k                         apollo_defconfig
sh                            shmin_defconfig
h8300                            alldefconfig
mips                         rt305x_defconfig
arm                            mps2_defconfig
xtensa                  cadence_csp_defconfig
sh                         ap325rxa_defconfig
m68k                         amcore_defconfig
arm                        mvebu_v7_defconfig
sh                        dreamcast_defconfig
sh                          urquell_defconfig
sh                           se7751_defconfig
arm                       cns3420vb_defconfig
arm                    vt8500_v6_v7_defconfig
arc                        nsim_700_defconfig
arm                   milbeaut_m10v_defconfig
sh                   sh7770_generic_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8313_rdb_defconfig
um                                  defconfig
xtensa                         virt_defconfig
ia64                          tiger_defconfig
arm                  randconfig-c002-20211116
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20211116
x86_64               randconfig-a012-20211116
x86_64               randconfig-a011-20211116
x86_64               randconfig-a016-20211116
x86_64               randconfig-a014-20211116
x86_64               randconfig-a015-20211116
i386                 randconfig-a014-20211116
i386                 randconfig-a016-20211116
i386                 randconfig-a012-20211116
i386                 randconfig-a013-20211116
i386                 randconfig-a011-20211116
i386                 randconfig-a015-20211116
arc                  randconfig-r043-20211116
s390                 randconfig-r044-20211116
riscv                randconfig-r042-20211116
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211116
i386                 randconfig-c001-20211116
arm                  randconfig-c002-20211116
riscv                randconfig-c006-20211116
powerpc              randconfig-c003-20211116
s390                 randconfig-c005-20211116
mips                 randconfig-c004-20211116
x86_64               randconfig-a005-20211116
x86_64               randconfig-a003-20211116
x86_64               randconfig-a001-20211116
x86_64               randconfig-a002-20211116
x86_64               randconfig-a006-20211116
x86_64               randconfig-a004-20211116
i386                 randconfig-a006-20211116
i386                 randconfig-a003-20211116
i386                 randconfig-a005-20211116
i386                 randconfig-a001-20211116
i386                 randconfig-a004-20211116
i386                 randconfig-a002-20211116
hexagon              randconfig-r045-20211116
hexagon              randconfig-r041-20211116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
