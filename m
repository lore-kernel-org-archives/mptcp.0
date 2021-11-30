Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689192CA1
	for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 19:06:08 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223528045"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="223528045"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 11:06:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="499901625"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2021 11:06:06 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1ms8S5-000Dg4-70; Tue, 30 Nov 2021 19:06:05 +0000
Date: Wed, 01 Dec 2021 03:05:16 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 11e07797314e452f2222c9c9f0558ab787e22726
Message-ID: <61a675ec.TfORcYzBYqPBC1ES%lkp@intel.com>
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
branch HEAD: 11e07797314e452f2222c9c9f0558ab787e22726  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 732m

configs tested: 132
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211128
arm                    vt8500_v6_v7_defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
xtensa                       common_defconfig
arm                         s3c2410_defconfig
powerpc                     kilauea_defconfig
arm                            xcep_defconfig
mips                      loongson3_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
mips                           ip28_defconfig
mips                  maltasmvp_eva_defconfig
m68k                        m5407c3_defconfig
arc                        nsim_700_defconfig
arm                         lubbock_defconfig
sh                     magicpanelr2_defconfig
arc                            hsdk_defconfig
arm                          ixp4xx_defconfig
arm                          pxa168_defconfig
arm                  randconfig-c002-20211128
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20211130
i386                 randconfig-a002-20211130
i386                 randconfig-a006-20211130
i386                 randconfig-a004-20211130
i386                 randconfig-a003-20211130
i386                 randconfig-a001-20211130
i386                 randconfig-a001-20211129
i386                 randconfig-a002-20211129
i386                 randconfig-a006-20211129
i386                 randconfig-a005-20211129
i386                 randconfig-a004-20211129
i386                 randconfig-a003-20211129
x86_64               randconfig-a001-20211130
x86_64               randconfig-a006-20211130
x86_64               randconfig-a003-20211130
x86_64               randconfig-a004-20211130
x86_64               randconfig-a005-20211130
x86_64               randconfig-a002-20211130
x86_64               randconfig-a011-20211128
x86_64               randconfig-a014-20211128
x86_64               randconfig-a012-20211128
x86_64               randconfig-a016-20211128
x86_64               randconfig-a013-20211128
x86_64               randconfig-a015-20211128
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a003-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a006-20211128
x86_64               randconfig-a014-20211130
x86_64               randconfig-a016-20211130
x86_64               randconfig-a013-20211130
x86_64               randconfig-a012-20211130
x86_64               randconfig-a015-20211130
x86_64               randconfig-a011-20211130
i386                 randconfig-a011-20211130
i386                 randconfig-a015-20211130
i386                 randconfig-a012-20211130
i386                 randconfig-a013-20211130
i386                 randconfig-a014-20211130
i386                 randconfig-a016-20211130
i386                 randconfig-a015-20211129
i386                 randconfig-a016-20211129
i386                 randconfig-a013-20211129
i386                 randconfig-a012-20211129
i386                 randconfig-a014-20211129
i386                 randconfig-a011-20211129
hexagon              randconfig-r045-20211129
hexagon              randconfig-r041-20211129
s390                 randconfig-r044-20211129
riscv                randconfig-r042-20211129
hexagon              randconfig-r045-20211128
hexagon              randconfig-r041-20211128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
