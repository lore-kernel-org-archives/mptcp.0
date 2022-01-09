Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528D29CA
	for <mptcp@lists.linux.dev>; Sun,  9 Jan 2022 21:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641762240; x=1673298240;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Nlmv/Ij2cE5E9yPdxLUGerediOLqGARZLSpT0jj7XIs=;
  b=YiVNbbgkRjT3K9eltvA2sH5iyqitZzQezVcII6HO9okKwRggnbM5otXf
   aJx07r6I0zkfomLRvmwnRXmkEuv7QYkGbXxcL4kvc1jnyn2KOQr9ltDA4
   Furr50pt1/e/x4edjV4WQHM3Y6zX/YETIjbXlHOC1ooPRvCnPNkX1LpwC
   L9DMt1AswmhaL/4iUngvvRoHdPECCu/mAIEZFRTFeT0/Cbxa0zAkWuwUo
   +OH4Yl01rl/Nj1wu6UeLBW84IG5dDtp2iO1P/7LuvWHcl89Cx5/YbKFoV
   i5jLS1QGZ22d9tUmLnydL+F1PGII+lVTmrvqpZ24ouzqmG7FwayPOTIa6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="230458704"
X-IronPort-AV: E=Sophos;i="5.88,275,1635231600"; 
   d="scan'208";a="230458704"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 13:03:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,275,1635231600"; 
   d="scan'208";a="514462738"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2022 13:03:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n6fM5-0001uR-Jh; Sun, 09 Jan 2022 21:03:57 +0000
Date: Mon, 10 Jan 2022 05:03:01 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 f414b385a1535fdd4cc50099cf9d94e80d3d46d2
Message-ID: <61db4d85.n1P+/BF3Aris4OWS%lkp@intel.com>
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
branch HEAD: f414b385a1535fdd4cc50099cf9d94e80d3d46d2  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 1988m

configs tested: 202
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220108
powerpc                         ps3_defconfig
nios2                         10m50_defconfig
sh                           se7712_defconfig
mips                      maltasmvp_defconfig
arm                            zeus_defconfig
mips                         db1xxx_defconfig
m68k                        m5272c3_defconfig
riscv                            allmodconfig
sh                   sh7724_generic_defconfig
powerpc                     rainier_defconfig
powerpc                        warp_defconfig
arm                        keystone_defconfig
mips                            ar7_defconfig
powerpc                     taishan_defconfig
sh                        dreamcast_defconfig
sh                             sh03_defconfig
arm                         cm_x300_defconfig
arm                         lpc18xx_defconfig
sh                          landisk_defconfig
sparc                               defconfig
sh                            shmin_defconfig
m68k                             alldefconfig
powerpc                 mpc8540_ads_defconfig
um                                  defconfig
powerpc                    sam440ep_defconfig
powerpc                      ppc6xx_defconfig
sh                            hp6xx_defconfig
alpha                            allyesconfig
powerpc                 mpc837x_mds_defconfig
sh                          rsk7203_defconfig
arm                            qcom_defconfig
sh                          sdk7786_defconfig
um                             i386_defconfig
m68k                            mac_defconfig
sh                            migor_defconfig
nds32                            alldefconfig
arc                          axs101_defconfig
arc                     nsimosci_hs_defconfig
openrisc                  or1klitex_defconfig
arm                        multi_v7_defconfig
powerpc                     tqm8541_defconfig
i386                             alldefconfig
alpha                               defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        stmark2_defconfig
s390                          debug_defconfig
sh                           se7722_defconfig
m68k                        m5307c3_defconfig
mips                             allyesconfig
powerpc                  iss476-smp_defconfig
h8300                            allyesconfig
riscv             nommu_k210_sdcard_defconfig
sh                           sh2007_defconfig
sh                           se7619_defconfig
arm                        oxnas_v6_defconfig
sh                      rts7751r2d1_defconfig
m68k                       m5475evb_defconfig
arm                            mps2_defconfig
sh                          kfr2r09_defconfig
sh                     sh7710voipgw_defconfig
m68k                                defconfig
mips                          rb532_defconfig
ia64                      gensparse_defconfig
powerpc                     pq2fads_defconfig
sh                             shx3_defconfig
arm                          exynos_defconfig
powerpc                      makalu_defconfig
sh                           se7780_defconfig
powerpc                 linkstation_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      cm5200_defconfig
x86_64                           alldefconfig
sh                        sh7757lcr_defconfig
sh                          r7780mp_defconfig
powerpc                      bamboo_defconfig
sparc                       sparc32_defconfig
powerpc                      chrp32_defconfig
m68k                            q40_defconfig
arm                  randconfig-c002-20220109
arm                  randconfig-c002-20220108
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20220109
x86_64               randconfig-a001-20220109
x86_64               randconfig-a004-20220109
x86_64               randconfig-a006-20220109
x86_64               randconfig-a003-20220109
x86_64               randconfig-a002-20220109
i386                 randconfig-a003-20220109
i386                 randconfig-a005-20220109
i386                 randconfig-a006-20220109
i386                 randconfig-a004-20220109
i386                 randconfig-a001-20220109
i386                 randconfig-a002-20220109
x86_64               randconfig-a015-20220108
x86_64               randconfig-a012-20220108
x86_64               randconfig-a014-20220108
x86_64               randconfig-a013-20220108
x86_64               randconfig-a011-20220108
x86_64               randconfig-a016-20220108
i386                 randconfig-a012-20220108
i386                 randconfig-a016-20220108
i386                 randconfig-a015-20220108
i386                 randconfig-a014-20220108
i386                 randconfig-a011-20220108
i386                 randconfig-a013-20220108
x86_64               randconfig-a005-20220110
x86_64               randconfig-a004-20220110
x86_64               randconfig-a001-20220110
x86_64               randconfig-a006-20220110
x86_64               randconfig-a002-20220110
x86_64               randconfig-a003-20220110
s390                 randconfig-r044-20220108
arc                  randconfig-r043-20220108
riscv                randconfig-r042-20220108
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220108
mips                 randconfig-c004-20220108
i386                 randconfig-c001-20220108
riscv                randconfig-c006-20220108
powerpc              randconfig-c003-20220108
x86_64               randconfig-c007-20220108
arm                  randconfig-c002-20220109
mips                 randconfig-c004-20220109
i386                 randconfig-c001-20220109
riscv                randconfig-c006-20220109
powerpc              randconfig-c003-20220109
x86_64               randconfig-c007-20220109
arm                        multi_v5_defconfig
powerpc                     tqm8540_defconfig
powerpc                     ppa8548_defconfig
mips                      maltaaprp_defconfig
powerpc                     skiroot_defconfig
x86_64               randconfig-a005-20220108
x86_64               randconfig-a001-20220108
x86_64               randconfig-a004-20220108
x86_64               randconfig-a006-20220108
x86_64               randconfig-a003-20220108
x86_64               randconfig-a002-20220108
i386                 randconfig-a003-20220108
i386                 randconfig-a005-20220108
i386                 randconfig-a006-20220108
i386                 randconfig-a004-20220108
i386                 randconfig-a001-20220108
i386                 randconfig-a002-20220108
x86_64               randconfig-a015-20220109
x86_64               randconfig-a012-20220109
x86_64               randconfig-a014-20220109
x86_64               randconfig-a013-20220109
x86_64               randconfig-a011-20220109
x86_64               randconfig-a016-20220109
i386                 randconfig-a012-20220109
i386                 randconfig-a016-20220109
i386                 randconfig-a015-20220109
i386                 randconfig-a014-20220109
i386                 randconfig-a011-20220109
i386                 randconfig-a013-20220109
hexagon              randconfig-r041-20220109
riscv                randconfig-r042-20220109
hexagon              randconfig-r045-20220109

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
