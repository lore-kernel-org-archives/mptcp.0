Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8C2C82
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 18:18:00 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="222563940"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="222563940"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 10:18:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="457568847"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Nov 2021 10:17:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mpwqE-0005At-1r; Wed, 24 Nov 2021 18:17:58 +0000
Date: Thu, 25 Nov 2021 02:17:30 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 47fe174364ce9f53d0be3ad7cd9e36df3a596cd5
Message-ID: <619e81ba.lAwYVjoNUUvZMnOk%lkp@intel.com>
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
branch HEAD: 47fe174364ce9f53d0be3ad7cd9e36df3a596cd5  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 721m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211124
powerpc                       maple_defconfig
sh                           se7724_defconfig
powerpc                    mvme5100_defconfig
powerpc                     pseries_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
arm                            qcom_defconfig
m68k                       m5275evb_defconfig
powerpc                   currituck_defconfig
ia64                             alldefconfig
sh                           se7721_defconfig
arm                        spear3xx_defconfig
powerpc                    socrates_defconfig
arc                            hsdk_defconfig
m68k                           sun3_defconfig
arc                     nsimosci_hs_defconfig
mips                   sb1250_swarm_defconfig
mips                  cavium_octeon_defconfig
mips                malta_qemu_32r6_defconfig
arm                          ixp4xx_defconfig
sh                     magicpanelr2_defconfig
arm                         lubbock_defconfig
h8300                    h8300h-sim_defconfig
sh                     sh7710voipgw_defconfig
mips                         rt305x_defconfig
arm                         axm55xx_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     taishan_defconfig
arm                     am200epdkit_defconfig
xtensa                  nommu_kc705_defconfig
arm                        shmobile_defconfig
sh                           se7751_defconfig
arm                       netwinder_defconfig
arm                           h5000_defconfig
mips                           ip22_defconfig
sh                           se7780_defconfig
arm                  colibri_pxa300_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
sh                            shmin_defconfig
arm                          lpd270_defconfig
arm                          collie_defconfig
powerpc                    sam440ep_defconfig
ia64                                defconfig
sh                ecovec24-romimage_defconfig
arm                            xcep_defconfig
arm                         lpc32xx_defconfig
powerpc                  mpc885_ads_defconfig
riscv                    nommu_k210_defconfig
arm                          pxa3xx_defconfig
arm                         orion5x_defconfig
powerpc                  mpc866_ads_defconfig
arm                        clps711x_defconfig
arm                          iop32x_defconfig
mips                          rb532_defconfig
sh                             shx3_defconfig
arm                         socfpga_defconfig
mips                  maltasmvp_eva_defconfig
sparc64                             defconfig
riscv                             allnoconfig
powerpc                 canyonlands_defconfig
arm                     eseries_pxa_defconfig
arm                        realview_defconfig
arm                        cerfcube_defconfig
powerpc                        icon_defconfig
arc                        vdk_hs38_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   secureedge5410_defconfig
powerpc                        fsp2_defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
parisc                           alldefconfig
powerpc                     sequoia_defconfig
sparc                       sparc32_defconfig
sh                           se7343_defconfig
mips                      maltaaprp_defconfig
s390                       zfcpdump_defconfig
powerpc                    adder875_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
arm                  randconfig-c002-20211124
ia64                             allmodconfig
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
x86_64               randconfig-a011-20211124
x86_64               randconfig-a014-20211124
x86_64               randconfig-a012-20211124
x86_64               randconfig-a016-20211124
x86_64               randconfig-a013-20211124
x86_64               randconfig-a015-20211124
i386                 randconfig-a016-20211124
i386                 randconfig-a015-20211124
i386                 randconfig-a012-20211124
i386                 randconfig-a013-20211124
i386                 randconfig-a014-20211124
i386                 randconfig-a011-20211124
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
s390                 randconfig-c005-20211124
i386                 randconfig-c001-20211124
powerpc              randconfig-c003-20211124
riscv                randconfig-c006-20211124
arm                  randconfig-c002-20211124
x86_64               randconfig-c007-20211124
mips                 randconfig-c004-20211124
x86_64               randconfig-a001-20211124
x86_64               randconfig-a006-20211124
x86_64               randconfig-a003-20211124
x86_64               randconfig-a004-20211124
x86_64               randconfig-a005-20211124
x86_64               randconfig-a002-20211124
i386                 randconfig-a002-20211124
i386                 randconfig-a001-20211124
i386                 randconfig-a005-20211124
i386                 randconfig-a006-20211124
i386                 randconfig-a004-20211124
i386                 randconfig-a003-20211124
hexagon              randconfig-r045-20211124
hexagon              randconfig-r041-20211124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
