Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A72C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642116913; x=1673652913;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=G8i0wtgVcG5x4LKUMiU9+eed+evq88Z+kDoifNU4CCc=;
  b=FUG5gXughrcC4OVVlpoK8Tf1XxBoHl5mnwoq6sxgO4BZRskw/2lOTNmc
   UcpmPkwQjGS4cXhfevjObENiR8miU0Pn/lq856pw9qx4YcXViKXRWu7ZO
   EiQWO7wVmrYAg1eZtDsDNeHh1tOjN2/mQxqz9ViiayjfFSzx0oBul1qvP
   fWgXJAc3+gcq1H6U3iF0KfnqG0Z0XipVPCRknpb3JnQrAPfUvyOf0ytxL
   WcfQs0DFUVPd6UUlwylLF273xBmf5uwoFK/imIeZUMTiN+04dKUuOI9ZF
   0wqsU//d6oT+YzsV7SCy3urFUCY6xh5j316BklYvqi+0Q4i9Ypua+r6d5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="231485492"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="231485492"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:35:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="529899692"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2022 15:35:11 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n89cc-0007mO-PU; Thu, 13 Jan 2022 23:35:10 +0000
Date: Fri, 14 Jan 2022 07:34:14 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 945797376d51bac7fa478a5c7569ca771a9311bd
Message-ID: <61e0b6f6.cJ0FROI+SgfzPq0p%lkp@intel.com>
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
branch HEAD: 945797376d51bac7fa478a5c7569ca771a9311bd  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 720m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                           corgi_defconfig
ia64                        generic_defconfig
arm                            xcep_defconfig
powerpc                       holly_defconfig
mips                         tb0226_defconfig
m68k                       m5475evb_defconfig
m68k                        m5307c3_defconfig
arc                    vdk_hs38_smp_defconfig
mips                       capcella_defconfig
powerpc                     sequoia_defconfig
sh                 kfr2r09-romimage_defconfig
sh                               alldefconfig
m68k                       m5208evb_defconfig
openrisc                 simple_smp_defconfig
sh                          sdk7780_defconfig
sparc                       sparc32_defconfig
arm                         axm55xx_defconfig
arm                           h5000_defconfig
arm                            qcom_defconfig
arm                            pleb_defconfig
sh                   rts7751r2dplus_defconfig
mips                  maltasmvp_eva_defconfig
sh                   sh7770_generic_defconfig
arm                          exynos_defconfig
sh                      rts7751r2d1_defconfig
sh                          kfr2r09_defconfig
um                           x86_64_defconfig
mips                        jmr3927_defconfig
mips                         rt305x_defconfig
powerpc                   motionpro_defconfig
arm                         lpc18xx_defconfig
powerpc                      ppc6xx_defconfig
xtensa                       common_defconfig
sh                                  defconfig
i386                             alldefconfig
sh                          sdk7786_defconfig
arm                           tegra_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
arm                  randconfig-c002-20220113
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
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220113
arc                  randconfig-r043-20220113
s390                 randconfig-r044-20220113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220113
x86_64                        randconfig-c007
riscv                randconfig-c006-20220113
powerpc              randconfig-c003-20220113
i386                          randconfig-c001
mips                 randconfig-c004-20220113
mips                           ip28_defconfig
arm                          pxa168_defconfig
powerpc                     mpc5200_defconfig
mips                            e55_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
arm                            mmp2_defconfig
arm                       netwinder_defconfig
mips                           ip22_defconfig
arm                          imote2_defconfig
arm                              alldefconfig
riscv                            alldefconfig
arm                        multi_v5_defconfig
mips                          ath25_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220113
hexagon              randconfig-r041-20220113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
