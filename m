Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF529CA
	for <mptcp@lists.linux.dev>; Sun, 19 Dec 2021 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639942721; x=1671478721;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yd7mwJ+ePoxv6slyZZzeO/q/hWmZeINjVOix5cQrC+Y=;
  b=jCiYoKaERDdM3ZSEXq/LkC0BYdmwllBTkB6RNKyv/LkhtE5cO3ML/06D
   HptDDm39c2TWwd4L3Wp7Xce6GVtHDOekwQsbU25S4NK+ztCTIx5NlaYDD
   1IA63HbmVAelm4nZcsTH3c9EOhBIHLu3DCLfx5hNBn2jTJcQc9XusuLYl
   9KcjYOAbCqVrvSTlEazamXpT2/yjMeJW+Oa4kpgeGDTguqoiXVYqkRnwG
   3GEtNIfn8dOTstNHltk/hyLqAHH5PvxEhU9lq0zzEgR7OWSNv2VHmUyTu
   wg6jgyXOi0VzI6GtBC8I8zoQUvF3rUBVHbfCc9jVSYNRPew8jsGvX/Hzy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="264232803"
X-IronPort-AV: E=Sophos;i="5.88,218,1635231600"; 
   d="scan'208";a="264232803"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 11:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,218,1635231600"; 
   d="scan'208";a="507432428"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2021 11:38:38 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mz210-0007Bf-2J; Sun, 19 Dec 2021 19:38:38 +0000
Date: Mon, 20 Dec 2021 03:38:33 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 826f8a6fcb01e217eb82febb0427d3483c1fc166
Message-ID: <61bf8a39.pNyxM6YoLYcVhrsM%lkp@intel.com>
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
branch HEAD: 826f8a6fcb01e217eb82febb0427d3483c1fc166  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 720m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                        m5307c3_defconfig
mips                      malta_kvm_defconfig
arm                        mvebu_v7_defconfig
sparc64                             defconfig
arm                         cm_x300_defconfig
arc                              allyesconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                       ppc64_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                        edosk7705_defconfig
arm                      pxa255-idp_defconfig
h8300                            alldefconfig
arm                       spear13xx_defconfig
mips                         cobalt_defconfig
nios2                            alldefconfig
powerpc                      pasemi_defconfig
m68k                        m5407c3_defconfig
ia64                          tiger_defconfig
arm                       netwinder_defconfig
powerpc                      pmac32_defconfig
powerpc                     powernv_defconfig
mips                        jmr3927_defconfig
powerpc                     stx_gp3_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                   sh7770_generic_defconfig
arm                         mv78xx0_defconfig
powerpc                     tqm8560_defconfig
xtensa                generic_kc705_defconfig
mips                             allyesconfig
arm                  randconfig-c002-20211219
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
sparc                               defconfig
nds32                             allnoconfig
nios2                               defconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a011-20211219
x86_64               randconfig-a013-20211219
x86_64               randconfig-a012-20211219
x86_64               randconfig-a014-20211219
x86_64               randconfig-a015-20211219
x86_64               randconfig-a016-20211219
i386                 randconfig-a013-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a016-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a014-20211219
i386                 randconfig-a012-20211219
arc                  randconfig-r043-20211219
riscv                randconfig-r042-20211219
s390                 randconfig-r044-20211219
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20211219
x86_64               randconfig-a003-20211219
x86_64               randconfig-a002-20211219
x86_64               randconfig-a004-20211219
x86_64               randconfig-a006-20211219
x86_64               randconfig-a005-20211219
i386                 randconfig-a002-20211219
i386                 randconfig-a001-20211219
i386                 randconfig-a003-20211219
i386                 randconfig-a005-20211219
i386                 randconfig-a004-20211219
i386                 randconfig-a006-20211219
hexagon              randconfig-r045-20211219
hexagon              randconfig-r041-20211219

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
