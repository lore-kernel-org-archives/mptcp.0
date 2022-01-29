Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECDF2CA1
	for <mptcp@lists.linux.dev>; Sat, 29 Jan 2022 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643478747; x=1675014747;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=i9zeq5J6QyoIHtDuXhECm4YDrd+pN8KbdpFSVGWWtck=;
  b=OEy22/yuCWOK62Z/u2r/KqcG78NqzjkxO1KWz7DwFCuwrc7roPVBHtSG
   RZupz5QEH8wfQljuEqWVF01g3Q+1K8GzysyDULhJtPfGKmiYT7WCKMowU
   +JIQZEoKz7t6pbuYYohzkO0V9zd6zGlj+MQtCimeMLrCed5UiL4eS0FrO
   DNWEpre+eNW5AspYBdMNUwtJ1TLDCXQ05+0Bs5gOMGxW6t4ms7FbP4C+j
   QqCABEMkU62AZMuZsxYlMz+bNtQBjQNv7/0PJ+r1BIyW7pVA2y0ooNmhm
   cmF0GemFHSjeJINIuvYJsY2ZoS020UQS3/8baNTO9BHJHEXICZ2KZOrOo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="247507838"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="247507838"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 09:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="629442937"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2022 09:52:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nDrth-000PT0-0i; Sat, 29 Jan 2022 17:52:25 +0000
Date: Sun, 30 Jan 2022 01:51:41 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 b6a4e01fa9103eb62b81ff0bfacec48d39490217
Message-ID: <61f57ead.d3OuzYfS9eMacz6Z%lkp@intel.com>
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
branch HEAD: b6a4e01fa9103eb62b81ff0bfacec48d39490217  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 722m

configs tested: 172
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
i386                          randconfig-c001
sh                             sh03_defconfig
powerpc                   motionpro_defconfig
parisc                generic-32bit_defconfig
arc                     nsimosci_hs_defconfig
arm                         axm55xx_defconfig
powerpc                      pcm030_defconfig
xtensa                           alldefconfig
arm                          pxa3xx_defconfig
m68k                                defconfig
arm                         cm_x300_defconfig
sh                           se7751_defconfig
sparc                               defconfig
powerpc                      ppc6xx_defconfig
arc                           tb10x_defconfig
arm                            zeus_defconfig
powerpc                      arches_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 canyonlands_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      ep88xc_defconfig
powerpc                     ep8248e_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc834x_itx_defconfig
arm                        shmobile_defconfig
mips                     decstation_defconfig
arm                         lubbock_defconfig
arm                          iop32x_defconfig
nds32                               defconfig
nds32                             allnoconfig
m68k                         amcore_defconfig
openrisc                         alldefconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     sequoia_defconfig
m68k                           sun3_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                       ppc64_defconfig
arm                        multi_v7_defconfig
sh                                  defconfig
ia64                         bigsur_defconfig
arm                           sunxi_defconfig
sh                           se7705_defconfig
arm                        mini2440_defconfig
sh                           se7343_defconfig
xtensa                    smp_lx200_defconfig
um                           x86_64_defconfig
sh                          polaris_defconfig
sh                           se7712_defconfig
xtensa                  audio_kc705_defconfig
mips                        vocore2_defconfig
powerpc                     asp8347_defconfig
mips                           ip32_defconfig
ia64                                defconfig
sh                        sh7763rdp_defconfig
powerpc                     rainier_defconfig
microblaze                      mmu_defconfig
arm                  randconfig-c002-20220127
arm                  randconfig-c002-20220124
arm                  randconfig-c002-20220129
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220129
s390                 randconfig-r044-20220129
arc                  randconfig-r043-20220129
arc                  randconfig-r043-20220127
arc                  randconfig-r043-20220124
s390                 randconfig-r044-20220127
riscv                randconfig-r042-20220127
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-c007
arm                  randconfig-c002-20220129
mips                 randconfig-c004-20220129
i386                          randconfig-c001
s390                 randconfig-c005-20220129
riscv                randconfig-c006-20220129
powerpc              randconfig-c003-20220129
powerpc                      acadia_defconfig
arm                         orion5x_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc8560_ads_defconfig
mips                     cu1000-neo_defconfig
arm                            mmp2_defconfig
powerpc                     ppa8548_defconfig
mips                          ath25_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a012-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
s390                 randconfig-r044-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r045-20220127
hexagon              randconfig-r041-20220124
hexagon              randconfig-r041-20220127
hexagon              randconfig-r045-20220125
hexagon              randconfig-r041-20220125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
