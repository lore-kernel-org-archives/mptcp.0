Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D4173
	for <mptcp@lists.linux.dev>; Fri, 24 Dec 2021 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640369042; x=1671905042;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hZ56VMJ4Jykx6VUNvnhWSUKGg7akjYn4JQcfs/+u+UA=;
  b=GoyKEu/Pslde0UBP+4J+u0SunWsF0EwxIbbj8Djdcuncuevto/Z/uj6G
   8ht8NHHLvbgZ2vRo0ax2CAKZid71Tc4fuoH6QbXC3MExsNqbxxI7z4avX
   +lBxAhhOqaXGfQ+49TytWLY7IrXfbY7Lm0ZQzbnDMwvuwjNvx35/4Etyi
   zeS6vw5Se9aHVxIEqMZJpDQubmDKM+zhVJ2u4w6+OH/EvAyCmvdPmhatw
   SL0WBV+FIqAxt3D1F1ScHrmjQWe3B4q/E16djaPmWNZbx5QOMj0DQvT0M
   fMj6F7UO/q+xaOkZSGnjeZFMFUhR0/lO03wyT1ZqtK/ia/fJMB0tl+5vU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="240948392"
X-IronPort-AV: E=Sophos;i="5.88,233,1635231600"; 
   d="scan'208";a="240948392"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 10:04:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,233,1635231600"; 
   d="scan'208";a="523296825"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Dec 2021 10:04:00 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n0ovA-0003Ix-5R; Fri, 24 Dec 2021 18:04:00 +0000
Date: Sat, 25 Dec 2021 02:03:23 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 21c7f598f200dc24f28bfa4ae7711ed0c9d31430
Message-ID: <61c60b6b.DhfQ9hkFNBq9/AF+%lkp@intel.com>
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
branch HEAD: 21c7f598f200dc24f28bfa4ae7711ed0c9d31430  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 720m

configs tested: 192
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211224
powerpc                     tqm8541_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     sequoia_defconfig
powerpc                      acadia_defconfig
sh                      rts7751r2d1_defconfig
arm                         lubbock_defconfig
arm                   milbeaut_m10v_defconfig
mips                             allmodconfig
m68k                        mvme147_defconfig
powerpc                      tqm8xx_defconfig
mips                        workpad_defconfig
m68k                         amcore_defconfig
powerpc                     mpc83xx_defconfig
xtensa                       common_defconfig
powerpc                     tqm8540_defconfig
arm                            qcom_defconfig
arm                          iop32x_defconfig
arc                          axs103_defconfig
m68k                          amiga_defconfig
arm64                            alldefconfig
m68k                          sun3x_defconfig
arm                        trizeps4_defconfig
mips                           ip27_defconfig
arc                              alldefconfig
arm                       spear13xx_defconfig
sh                            migor_defconfig
sh                            hp6xx_defconfig
powerpc                      pasemi_defconfig
arm                         s3c6400_defconfig
mips                         tb0226_defconfig
mips                   sb1250_swarm_defconfig
m68k                            q40_defconfig
arc                      axs103_smp_defconfig
arm                            mmp2_defconfig
arm                           omap1_defconfig
mips                            e55_defconfig
mips                        bcm47xx_defconfig
sh                           se7619_defconfig
powerpc                        cell_defconfig
openrisc                    or1ksim_defconfig
alpha                            alldefconfig
sh                           se7343_defconfig
arm                      integrator_defconfig
mips                        vocore2_defconfig
arm                          simpad_defconfig
powerpc                      ep88xc_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      pmac32_defconfig
arm                        oxnas_v6_defconfig
powerpc                     ppa8548_defconfig
mips                           gcw0_defconfig
m68k                       m5249evb_defconfig
m68k                       bvme6000_defconfig
um                               alldefconfig
powerpc                 mpc837x_mds_defconfig
mips                         tb0219_defconfig
powerpc                    amigaone_defconfig
arm                           sunxi_defconfig
powerpc                      pcm030_defconfig
powerpc                      arches_defconfig
sh                        apsh4ad0a_defconfig
arm                             pxa_defconfig
arc                                 defconfig
powerpc                 linkstation_defconfig
mips                        qi_lb60_defconfig
m68k                       m5475evb_defconfig
mips                           mtx1_defconfig
powerpc                     ksi8560_defconfig
csky                             alldefconfig
csky                                defconfig
m68k                            mac_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          gemini_defconfig
powerpc                 mpc834x_mds_defconfig
mips                         rt305x_defconfig
powerpc                       maple_defconfig
powerpc                      obs600_defconfig
h8300                       h8s-sim_defconfig
mips                           ip28_defconfig
powerpc                     pq2fads_defconfig
m68k                        m5307c3_defconfig
arm                            lart_defconfig
arm                         s3c2410_defconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                           se7721_defconfig
arm                     eseries_pxa_defconfig
arm                        neponset_defconfig
powerpc                     redwood_defconfig
powerpc64                           defconfig
powerpc                         ps3_defconfig
arm                        shmobile_defconfig
mips                  maltasmvp_eva_defconfig
mips                    maltaup_xpa_defconfig
xtensa                          iss_defconfig
mips                           ci20_defconfig
arm                         hackkit_defconfig
powerpc                  mpc885_ads_defconfig
sh                           se7780_defconfig
mips                          rm200_defconfig
powerpc                 mpc8272_ads_defconfig
sparc                            alldefconfig
arm                             rpc_defconfig
arc                     nsimosci_hs_defconfig
xtensa                  nommu_kc705_defconfig
arm                         lpc32xx_defconfig
arm                  colibri_pxa270_defconfig
mips                            gpr_defconfig
arm                  randconfig-c002-20211224
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                               defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
nios2                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20211224
x86_64               randconfig-a001-20211224
x86_64               randconfig-a005-20211224
x86_64               randconfig-a006-20211224
x86_64               randconfig-a004-20211224
x86_64               randconfig-a002-20211224
i386                 randconfig-a006-20211224
i386                 randconfig-a004-20211224
i386                 randconfig-a002-20211224
i386                 randconfig-a003-20211224
i386                 randconfig-a005-20211224
i386                 randconfig-a001-20211224
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a013-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a016-20211223
arc                  randconfig-r043-20211224
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

clang tested configs:
x86_64               randconfig-a013-20211224
x86_64               randconfig-a014-20211224
x86_64               randconfig-a015-20211224
x86_64               randconfig-a012-20211224
x86_64               randconfig-a011-20211224
x86_64               randconfig-a016-20211224
hexagon              randconfig-r041-20211224
hexagon              randconfig-r045-20211224
s390                 randconfig-r044-20211224
riscv                randconfig-r042-20211224

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
