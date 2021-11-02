Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D472C85
	for <mptcp@lists.linux.dev>; Tue,  2 Nov 2021 22:38:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="218573509"
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="218573509"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 15:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="560270913"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 02 Nov 2021 15:38:50 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mi2Qb-0004wK-EP; Tue, 02 Nov 2021 22:38:49 +0000
Date: Wed, 03 Nov 2021 06:37:58 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 96dff9bc77012a43ed25747f12810d3040222c75
Message-ID: <6181bdc6.koWarjh5LGpgNCkl%lkp@intel.com>
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
branch HEAD: 96dff9bc77012a43ed25747f12810d3040222c75  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 723m

configs tested: 119
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
mips                           ip27_defconfig
arm                      tct_hammer_defconfig
arm                        mvebu_v5_defconfig
microblaze                          defconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
sh                             espt_defconfig
sh                        apsh4ad0a_defconfig
powerpc                      ppc40x_defconfig
arm                        mvebu_v7_defconfig
mips                      loongson3_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
arc                          axs103_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      ppc6xx_defconfig
powerpc                      acadia_defconfig
arm                        oxnas_v6_defconfig
arm                         socfpga_defconfig
mips                     cu1000-neo_defconfig
mips                        omega2p_defconfig
arc                           tb10x_defconfig
xtensa                  cadence_csp_defconfig
mips                      maltaaprp_defconfig
powerpc                     asp8347_defconfig
mips                     loongson1c_defconfig
arm                        keystone_defconfig
ia64                            zx1_defconfig
mips                           ip22_defconfig
arm                  randconfig-c002-20211101
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
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
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20211102
i386                 randconfig-a003-20211102
i386                 randconfig-a001-20211102
i386                 randconfig-a004-20211102
i386                 randconfig-a006-20211102
i386                 randconfig-a002-20211102
x86_64               randconfig-a012-20211101
x86_64               randconfig-a015-20211101
x86_64               randconfig-a016-20211101
x86_64               randconfig-a013-20211101
x86_64               randconfig-a011-20211101
x86_64               randconfig-a014-20211101
i386                 randconfig-a016-20211101
i386                 randconfig-a014-20211101
i386                 randconfig-a015-20211101
i386                 randconfig-a013-20211101
i386                 randconfig-a011-20211101
i386                 randconfig-a012-20211101
arc                  randconfig-r043-20211101
riscv                randconfig-r042-20211101
s390                 randconfig-r044-20211101
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
x86_64               randconfig-a004-20211101
x86_64               randconfig-a006-20211101
x86_64               randconfig-a001-20211101
x86_64               randconfig-a002-20211101
x86_64               randconfig-a003-20211101
x86_64               randconfig-a005-20211101
i386                 randconfig-a005-20211101
i386                 randconfig-a001-20211101
i386                 randconfig-a003-20211101
i386                 randconfig-a004-20211101
i386                 randconfig-a006-20211101
i386                 randconfig-a002-20211101
hexagon              randconfig-r041-20211101
hexagon              randconfig-r045-20211101

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
