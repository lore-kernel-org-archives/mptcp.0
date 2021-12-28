Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5372C80
	for <mptcp@lists.linux.dev>; Tue, 28 Dec 2021 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640716283; x=1672252283;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TvkmCBKu/Suis1Nl0nK9Glfcgpob+cY3GsndqFgY9CE=;
  b=P8bvqlaY3c5ipljHzl6FtkFb0ImWzxThFn8/vfOLS6CaGZUzUnpoiuOZ
   ikpOIoaPAJJ8s8gCDPl2Dlr4NPCZJwUgMaGzS6wZjWAVGpDziGHsm8yFz
   8nu+hdOOn/epalGPO+eNsSiQQ8qrO/SfQ0XiFbqm+nZa8zfiDEbJ4cZ4g
   Qe5L5Xnt2UNY7nU3zWyQYxx1cg35VXkwRj4/cVTjMoWcb6LIFcWDxgsl3
   ZPCpjo49ikwbS4LvLWmGuK1qtEHdZWn9fu/oR5251DycuTLW3UTiZCO4d
   iiDw+DikJIFruwJPZ+cDXZGjE6B/ar41w/QTf+FemJH75txRL2QR8z0MC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="228235661"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="228235661"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 10:31:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="524611177"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Dec 2021 10:31:21 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n2HFp-0007vj-1B; Tue, 28 Dec 2021 18:31:21 +0000
Date: Wed, 29 Dec 2021 02:31:07 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 d007fdc9c5bccfac1f0d7b556b5774e9c6c5b517
Message-ID: <61cb57eb.sD35erT8Unm0MK4J%lkp@intel.com>
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
branch HEAD: d007fdc9c5bccfac1f0d7b556b5774e9c6c5b517  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 721m

configs tested: 188
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211228
powerpc                      chrp32_defconfig
arm64                            alldefconfig
powerpc                        warp_defconfig
powerpc                   currituck_defconfig
arc                     haps_hs_smp_defconfig
mips                         db1xxx_defconfig
arm                             mxs_defconfig
parisc                generic-32bit_defconfig
arm                          simpad_defconfig
h8300                            allyesconfig
powerpc                     ep8248e_defconfig
sparc64                             defconfig
powerpc                       holly_defconfig
powerpc                     skiroot_defconfig
arm                          pxa168_defconfig
arc                         haps_hs_defconfig
sh                         ecovec24_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     mpc5200_defconfig
mips                     decstation_defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
arm                         cm_x300_defconfig
openrisc                  or1klitex_defconfig
arm                         at91_dt_defconfig
powerpc                      cm5200_defconfig
arm                          pcm027_defconfig
mips                       rbtx49xx_defconfig
sh                           se7724_defconfig
parisc                generic-64bit_defconfig
arm                          exynos_defconfig
xtensa                       common_defconfig
powerpc                     mpc512x_defconfig
ia64                         bigsur_defconfig
arm                         s3c2410_defconfig
powerpc                     tqm8540_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                      maltaaprp_defconfig
sh                     magicpanelr2_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
sh                            titan_defconfig
arm                             rpc_defconfig
arm                         vf610m4_defconfig
arm                          collie_defconfig
mips                  cavium_octeon_defconfig
h8300                     edosk2674_defconfig
powerpc                    ge_imp3a_defconfig
ia64                            zx1_defconfig
powerpc                 mpc836x_mds_defconfig
arm                            zeus_defconfig
powerpc                     tqm8541_defconfig
arm                           h3600_defconfig
mips                           jazz_defconfig
openrisc                            defconfig
xtensa                           alldefconfig
xtensa                    xip_kc705_defconfig
m68k                       m5475evb_defconfig
arm                      pxa255-idp_defconfig
arc                          axs103_defconfig
sh                                  defconfig
mips                         tb0219_defconfig
nds32                             allnoconfig
powerpc                      walnut_defconfig
powerpc                      arches_defconfig
mips                        workpad_defconfig
arm                           sama7_defconfig
sh                        apsh4ad0a_defconfig
m68k                       m5208evb_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                 decstation_r4k_defconfig
ia64                                defconfig
arm                        magician_defconfig
sh                           se7619_defconfig
powerpc                     ksi8560_defconfig
um                                  defconfig
sh                        edosk7705_defconfig
arm                    vt8500_v6_v7_defconfig
sh                          rsk7269_defconfig
sh                          sdk7780_defconfig
powerpc                      bamboo_defconfig
sh                           sh2007_defconfig
h8300                               defconfig
i386                             alldefconfig
mips                          rm200_defconfig
arm                           stm32_defconfig
mips                    maltaup_xpa_defconfig
powerpc                  mpc885_ads_defconfig
arm                         lpc18xx_defconfig
powerpc                     pq2fads_defconfig
arm                           sama5_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa910_defconfig
sparc                               defconfig
mips                            ar7_defconfig
m68k                           sun3_defconfig
sh                           se7780_defconfig
arm                        spear3xx_defconfig
s390                       zfcpdump_defconfig
arm                         lpc32xx_defconfig
arc                        nsimosci_defconfig
arm                              alldefconfig
nds32                            alldefconfig
m68k                        stmark2_defconfig
powerpc                     asp8347_defconfig
powerpc                 canyonlands_defconfig
sh                           se7721_defconfig
arm                  randconfig-c002-20211228
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20211228
x86_64               randconfig-a001-20211228
x86_64               randconfig-a003-20211228
x86_64               randconfig-a006-20211228
x86_64               randconfig-a004-20211228
x86_64               randconfig-a002-20211228
i386                 randconfig-a006-20211228
i386                 randconfig-a004-20211228
i386                 randconfig-a002-20211228
i386                 randconfig-a003-20211228
i386                 randconfig-a001-20211228
i386                 randconfig-a005-20211228
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20211228
x86_64               randconfig-a014-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a011-20211228
i386                 randconfig-a014-20211228
i386                 randconfig-a016-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a015-20211228
hexagon              randconfig-r041-20211228
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
