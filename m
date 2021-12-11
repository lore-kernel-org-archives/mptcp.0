Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D22C9C
	for <mptcp@lists.linux.dev>; Sat, 11 Dec 2021 23:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639265516; x=1670801516;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fFxreTbSPYuTLiyAPLgmL8zOkU46yw/ZmSD/bDQmSEQ=;
  b=hFt1Fngo64TvPH8MWb5ma10ji9/K9AR9TmIJ8tEAG2lfc9Z0zGSeKHzB
   G5QKIGTMmYWcKe0A56ig/Fy756YVR9olKlPSOpmwNsGJD1uQQxO/piFX/
   IHBno3fEsvoPpiKiISH/Ll4K/3wFpJRF4YgHohoWrs/UpP96CQgoRT+CI
   S1MNa6IeTIPIk8b9s7dihyEL+Pehs4Jcw0GrmFS3SvAIy7iXCI5qwa0mP
   mI2Cg9kifQu6whyX8WG/gbg9qZ+G85R/IbZzRV3qyUX3VWshXhZ6GbJ8D
   bfxyAIz/32xw9dl6kMp8M/+zWl6wNt0fojwzt+ynv9dgke0wZQwxEApFY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="299351476"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="299351476"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 15:31:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="613349103"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Dec 2021 15:31:54 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mwBqL-0005BM-LL; Sat, 11 Dec 2021 23:31:53 +0000
Date: Sun, 12 Dec 2021 07:31:17 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 b065e78ea956d085b25e6b7a2140b33ce5150273
Message-ID: <61b534c5.ihzPsK6McpW9q8Vd%lkp@intel.com>
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
branch HEAD: b065e78ea956d085b25e6b7a2140b33ce5150273  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 878m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211210
m68k                        m5307c3_defconfig
arm                        spear6xx_defconfig
sh                             sh03_defconfig
riscv                            alldefconfig
mips                      bmips_stb_defconfig
powerpc                        cell_defconfig
mips                         tb0287_defconfig
arm                       aspeed_g4_defconfig
sh                            titan_defconfig
sh                   sh7770_generic_defconfig
mips                         cobalt_defconfig
xtensa                generic_kc705_defconfig
m68k                            q40_defconfig
arc                           tb10x_defconfig
mips                       bmips_be_defconfig
arc                     nsimosci_hs_defconfig
nios2                         3c120_defconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                      integrator_defconfig
sh                               j2_defconfig
arm                            hisi_defconfig
xtensa                  audio_kc705_defconfig
powerpc                       eiger_defconfig
powerpc                      ppc40x_defconfig
arm                  randconfig-c002-20211211
arm                  randconfig-c002-20211212
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
x86_64               randconfig-a006-20211210
x86_64               randconfig-a005-20211210
x86_64               randconfig-a001-20211210
x86_64               randconfig-a002-20211210
x86_64               randconfig-a003-20211210
x86_64               randconfig-a004-20211210
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                          rhel-8.3-func

clang tested configs:
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
