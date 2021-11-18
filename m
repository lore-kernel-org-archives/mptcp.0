Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432C68
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 23:27:33 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="221193413"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="221193413"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 15:27:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="672999730"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2021 15:27:28 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mnqoR-0003kc-Kv; Thu, 18 Nov 2021 23:27:27 +0000
Date: Fri, 19 Nov 2021 07:26:49 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 7acbb96fbcdfe22f88a855491127b1891f37bc4f
Message-ID: <6196e139.fxEyK+5EgVDJ3stB%lkp@intel.com>
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
branch HEAD: 7acbb96fbcdfe22f88a855491127b1891f37bc4f  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 986m

configs tested: 124
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211118
arm                  colibri_pxa300_defconfig
arm                           h3600_defconfig
arc                    vdk_hs38_smp_defconfig
mips                   sb1250_swarm_defconfig
arc                     haps_hs_smp_defconfig
arm                            hisi_defconfig
openrisc                 simple_smp_defconfig
arm                           sunxi_defconfig
powerpc                      acadia_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     rainier_defconfig
mips                          ath25_defconfig
sh                             shx3_defconfig
sh                     sh7710voipgw_defconfig
arm                     davinci_all_defconfig
powerpc                      pasemi_defconfig
powerpc                       ppc64_defconfig
xtensa                           alldefconfig
arc                          axs103_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                      bmips_stb_defconfig
s390                       zfcpdump_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
mips                     cu1000-neo_defconfig
arm                           tegra_defconfig
sh                            migor_defconfig
arm                       cns3420vb_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
arm                      integrator_defconfig
arm                          pxa3xx_defconfig
arc                        nsim_700_defconfig
arm                         lpc32xx_defconfig
sh                         ecovec24_defconfig
mips                         cobalt_defconfig
xtensa                  nommu_kc705_defconfig
sh                        edosk7760_defconfig
arm                      pxa255-idp_defconfig
arm                     am200epdkit_defconfig
arm                  randconfig-c002-20211118
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
x86_64               randconfig-a015-20211118
x86_64               randconfig-a012-20211118
x86_64               randconfig-a011-20211118
x86_64               randconfig-a013-20211118
x86_64               randconfig-a016-20211118
x86_64               randconfig-a014-20211118
i386                 randconfig-a016-20211118
i386                 randconfig-a014-20211118
i386                 randconfig-a012-20211118
i386                 randconfig-a011-20211118
i386                 randconfig-a013-20211118
i386                 randconfig-a015-20211118
arc                  randconfig-r043-20211118
riscv                randconfig-r042-20211118
s390                 randconfig-r044-20211118
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a005-20211118
x86_64               randconfig-a003-20211118
x86_64               randconfig-a001-20211118
x86_64               randconfig-a002-20211118
x86_64               randconfig-a006-20211118
x86_64               randconfig-a004-20211118
i386                 randconfig-a006-20211118
i386                 randconfig-a003-20211118
i386                 randconfig-a001-20211118
i386                 randconfig-a005-20211118
i386                 randconfig-a004-20211118
i386                 randconfig-a002-20211118
hexagon              randconfig-r045-20211118
hexagon              randconfig-r041-20211118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
