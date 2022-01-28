Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C529CA
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643398802; x=1674934802;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nPAjRq6zEK92MpoXVBOaVFHci4vLtU0hkqF6Jy6ZHXw=;
  b=I/52/pEWnszmTfQ2e12a2jSK6PetYpnTgDzDy2E7PfZPOZzzt2PnGS9l
   JHvm2+LlHA9+jvp9XlRHpF7GdokC7J0WbkyHBS2prPWzJpKuPQ0xCuhkX
   rtXeDLvLqRIAGsAneLzDAIn+OqNSnG0AekyGXybLl/UROTZ67+fIc6Tes
   x16TPbqKWb7idfseeJlmuZBRbTsZQ/PvjqrKJKwYTjYyjMI/KHaOwo8l4
   i7bz4kZyHb6RJQnWMhX7Wasq4rLg8aT6Urf+Pt6xbi3RRJgk6zQPlVolL
   bjDK88sck5z4QxRGqQlPt2PpwFNSrVemtHKRyswh/tJX6cu3/D50E7Hu+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246957337"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="246957337"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:40:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="629222871"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Jan 2022 11:39:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nDX6E-000OFA-Jh; Fri, 28 Jan 2022 19:39:58 +0000
Date: Sat, 29 Jan 2022 03:39:25 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 d0d55271e0c825d4eb3746369aee6e871c0ab9b7
Message-ID: <61f4466d.XcclC2UXlIhdJnrT%lkp@intel.com>
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
branch HEAD: d0d55271e0c825d4eb3746369aee6e871c0ab9b7  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 724m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
arc                      axs103_smp_defconfig
arm                       imx_v6_v7_defconfig
m68k                       m5275evb_defconfig
powerpc                      mgcoge_defconfig
mips                            ar7_defconfig
arm                           tegra_defconfig
arm                         axm55xx_defconfig
arm                       aspeed_g5_defconfig
arm                             rpc_defconfig
mips                        vocore2_defconfig
sh                   secureedge5410_defconfig
h8300                    h8300h-sim_defconfig
sh                           sh2007_defconfig
sh                           se7721_defconfig
s390                       zfcpdump_defconfig
arm                            pleb_defconfig
sparc                       sparc64_defconfig
powerpc                  storcenter_defconfig
arm                        keystone_defconfig
sh                     sh7710voipgw_defconfig
arm                            zeus_defconfig
arm                        clps711x_defconfig
arm                      footbridge_defconfig
riscv                            allyesconfig
powerpc                     rainier_defconfig
mips                    maltaup_xpa_defconfig
sh                        sh7763rdp_defconfig
arm                          pxa910_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      ppc6xx_defconfig
arc                              alldefconfig
arm                           sunxi_defconfig
arc                        nsimosci_defconfig
arm                         assabet_defconfig
arm                             pxa_defconfig
s390                          debug_defconfig
h8300                     edosk2674_defconfig
nios2                         3c120_defconfig
sh                         apsh4a3a_defconfig
mips                           ci20_defconfig
xtensa                    xip_kc705_defconfig
arm                  randconfig-c002-20220124
arm                  randconfig-c002-20220127
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
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
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a006-20220124
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220127
arc                  randconfig-r043-20220124
s390                 randconfig-r044-20220127
riscv                randconfig-r042-20220127
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
powerpc                     powernv_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                    socrates_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                          g5_defconfig
powerpc                      acadia_defconfig
arm                        magician_defconfig
mips                     cu1830-neo_defconfig
powerpc                     kilauea_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r045-20220127
hexagon              randconfig-r041-20220124
hexagon              randconfig-r041-20220127
hexagon              randconfig-r045-20220125
hexagon              randconfig-r041-20220125
riscv                randconfig-r042-20220126
hexagon              randconfig-r045-20220126
hexagon              randconfig-r041-20220126
s390                 randconfig-r044-20220124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
