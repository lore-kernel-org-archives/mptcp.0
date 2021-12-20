Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8429CA
	for <mptcp@lists.linux.dev>; Mon, 20 Dec 2021 19:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640029943; x=1671565943;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kKGwqTIge5bWyBN7l8PllpSsQb/55ZZYVwp9eTLmF2c=;
  b=IhWiX+n3ebX9ExvLszZXGc+Qln7WZvA9ABg63jTC3L0f57/84vouzphL
   Ci+vjtyJ8hhnbVC+CtD5MMXVg6GXWdXCQNPIk/OFUY0CIbVrc3jPzPo0f
   wQJ8PDzmM0LC58/Z+xruoWu2sIyO4be/IDAMCOQPRvdhtINeNW+U+2yG7
   OvCNCguMMw7gSsUtRTWH6krT26ig0tgU4pXE++EijVPUfGwQeMKHwzQaP
   /bUc7OYKJ41VkP9AMoh3iP0mZrv4sWW+RI3lh8yzVzu2v4a4SsxenuMLs
   cLwpmWrWP95pBMbT0JvP7s2tOYajpPMnI4twxqk687hEXOtngYjPEcxzY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227550637"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="227550637"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 11:52:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="520946731"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2021 11:52:21 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mzOho-0008Ag-Ln; Mon, 20 Dec 2021 19:52:20 +0000
Date: Tue, 21 Dec 2021 03:51:37 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 8e0407a2bb63280bcdd2cf2b35a93fa3aa574d0a
Message-ID: <61c0dec9.6M6zxnNDQ+w+xced%lkp@intel.com>
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
branch HEAD: 8e0407a2bb63280bcdd2cf2b35a93fa3aa574d0a  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 727m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
arm                        shmobile_defconfig
sh                        edosk7760_defconfig
sh                             espt_defconfig
arm                      footbridge_defconfig
arm                           tegra_defconfig
sh                        sh7757lcr_defconfig
powerpc                    sam440ep_defconfig
mips                        maltaup_defconfig
mips                         mpc30x_defconfig
sparc64                          alldefconfig
powerpc                        warp_defconfig
powerpc                 mpc832x_mds_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ppc44x_defconfig
powerpc                           allnoconfig
m68k                        m5307c3_defconfig
arm                          pcm027_defconfig
sh                          rsk7203_defconfig
h8300                            allyesconfig
powerpc                  mpc885_ads_defconfig
arm                          pxa3xx_defconfig
openrisc                            defconfig
sh                        apsh4ad0a_defconfig
arm                           stm32_defconfig
m68k                             allmodconfig
m68k                          atari_defconfig
arm                        magician_defconfig
mips                            e55_defconfig
powerpc                     taishan_defconfig
i386                             allyesconfig
arm                  randconfig-c002-20211220
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a005-20211220
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a013-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a014-20211219
i386                 randconfig-a012-20211219
i386                 randconfig-a016-20211219
arc                  randconfig-r043-20211220
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
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig

clang tested configs:
x86_64               randconfig-a013-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a015-20211220
x86_64               randconfig-a016-20211220
s390                 randconfig-r044-20211220
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
