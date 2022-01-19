Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEE168
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 23:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642633725; x=1674169725;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FgzjWzmR5G1hFISwZ5AtAN44l6MR0G1yawh4enTsOEo=;
  b=XWusgh0Ql1yxojHFmdVbI8SmX6qtEbmnjuJnCjbHt+3lwSWnXucU7CRt
   ZuohXA7kkgoMLaHov/sxQ2GpKH/sMCksLcpmXxQu60zKmphDKDpa8smat
   3m6da0QxR9tIh9CSOZjDvlDzbg4tgsvYmKR+e4muuBFARMTmhePNNt/lH
   4J/hJBdDcO5kwitHzCN1s18UZ3fvL5Zb7c0Sx0V5Bopdi5GQ0dpD4u41n
   J+b2Y8s0t+Lr0Izz0P/HYckOkYMq1wRPqnNKkvihz+4nscHPYiuxT77ly
   tRnYunInaClrKiqgRldb0zFEIEgm/G1xzUNLUn0y3ay9ERg/v6R6J1Na3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="232583837"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="232583837"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 15:08:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="475317695"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2022 15:08:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nAK4I-000Dop-AD; Wed, 19 Jan 2022 23:08:42 +0000
Date: Thu, 20 Jan 2022 07:08:03 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 e27d2e0775d0da96a5e578e072cea004896c6bf7
Message-ID: <61e899d3.VurBo7rRwWIzBwNt%lkp@intel.com>
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
branch HEAD: e27d2e0775d0da96a5e578e072cea004896c6bf7  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 724m

configs tested: 131
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
arc                        vdk_hs38_defconfig
m68k                            q40_defconfig
sh                ecovec24-romimage_defconfig
mips                             allmodconfig
sh                          kfr2r09_defconfig
arm                           stm32_defconfig
arm                        mvebu_v7_defconfig
xtensa                  cadence_csp_defconfig
m68k                          hp300_defconfig
powerpc                        cell_defconfig
powerpc                      chrp32_defconfig
xtensa                         virt_defconfig
sh                             sh03_defconfig
sh                          sdk7780_defconfig
csky                             alldefconfig
arc                         haps_hs_defconfig
sh                          r7785rp_defconfig
x86_64                           alldefconfig
xtensa                generic_kc705_defconfig
ia64                          tiger_defconfig
arm                        multi_v7_defconfig
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
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
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
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
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a012-20220117
i386                 randconfig-a014-20220117
i386                 randconfig-a011-20220117
i386                 randconfig-a013-20220117
i386                 randconfig-a015-20220117
i386                 randconfig-a016-20220117
riscv                randconfig-r042-20220119
riscv                randconfig-r042-20220117
arc                  randconfig-r043-20220116
arc                  randconfig-r043-20220117
s390                 randconfig-r044-20220119
s390                 randconfig-r044-20220117
arc                  randconfig-r043-20220118
arc                  randconfig-r043-20220119
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
arm                                 defconfig
riscv                            alldefconfig
arm                            mmp2_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 xes_mpc85xx_defconfig
i386                             allyesconfig
powerpc               mpc834x_itxgp_defconfig
mips                     cu1830-neo_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      walnut_defconfig
arm                          ep93xx_defconfig
hexagon                             defconfig
mips                      maltaaprp_defconfig
powerpc                  mpc866_ads_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220119
hexagon              randconfig-r041-20220119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
