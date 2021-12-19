Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7F168
	for <mptcp@lists.linux.dev>; Sun, 19 Dec 2021 03:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639884855; x=1671420855;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X4DTx2lrAX30JK+7HmhV2wg1lp7Six3aIlxoAUCMUvk=;
  b=PZPRyM7gJlhsr0Opm8fKeVcar9whadOc6913H6yb/4Xfn4LZkI7YD+ye
   BBSrs7jA/77lqRkzc8QY7viswOGZtzo6uMehrlkMKJGeorrpLM51nJ8UM
   boG5WvwkTfhYXTqEBzoT/WX8Jc/W8HMBYyyxdKnkeepWyuY5Pp65ufCup
   bYQo58TevrufY2muwCkIyw3mPVNJYthOBCps3kVIXOvtYTnaz4OzFiqUa
   Z5C33Jo5vI3Qx63USiY0f93yLuez6tLxyzaxMkVjkc/X982lkCkVswzMJ
   4ZGPn8Xby4YyUhgzllPQ491pQxynDEHA8vkVqL7jY483kup3GbqCw8z/B
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="240198056"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="240198056"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 19:34:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="466965698"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2021 19:34:12 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mymxg-0006fw-4t; Sun, 19 Dec 2021 03:34:12 +0000
Date: Sun, 19 Dec 2021 11:33:34 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 6f979dcf10a2b38b6d4a0ed3d468f70c98f2c2f7
Message-ID: <61bea80e.W5A7araKveneLWl4%lkp@intel.com>
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
branch HEAD: 6f979dcf10a2b38b6d4a0ed3d468f70c98f2c2f7  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 1082m

configs tested: 198
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211218
mips                 randconfig-c004-20211218
powerpc                       maple_defconfig
nds32                               defconfig
arm                          simpad_defconfig
mips                        bcm63xx_defconfig
powerpc                   motionpro_defconfig
powerpc                    socrates_defconfig
powerpc                      arches_defconfig
powerpc                          g5_defconfig
powerpc                 canyonlands_defconfig
arm                        trizeps4_defconfig
sh                           se7724_defconfig
m68k                       m5208evb_defconfig
mips                        jmr3927_defconfig
arm                         lubbock_defconfig
sh                            titan_defconfig
powerpc                    sam440ep_defconfig
nios2                            alldefconfig
powerpc                       ebony_defconfig
mips                      malta_kvm_defconfig
arm                           sama5_defconfig
riscv                          rv32_defconfig
mips                malta_qemu_32r6_defconfig
mips                             allmodconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    ge_imp3a_defconfig
alpha                            alldefconfig
arc                        nsim_700_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                      pxa255-idp_defconfig
h8300                            alldefconfig
arm                       spear13xx_defconfig
mips                         cobalt_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                       common_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                        omega2p_defconfig
arm                              alldefconfig
powerpc                 xes_mpc85xx_defconfig
sparc64                             defconfig
sh                     sh7710voipgw_defconfig
arm                         shannon_defconfig
arm                        clps711x_defconfig
m68k                       m5249evb_defconfig
arm                            dove_defconfig
powerpc                     powernv_defconfig
um                           x86_64_defconfig
powerpc                     stx_gp3_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                         apollo_defconfig
m68k                         amcore_defconfig
mips                        bcm47xx_defconfig
h8300                    h8300h-sim_defconfig
sh                   sh7770_generic_defconfig
arm                         mv78xx0_defconfig
powerpc                     tqm8560_defconfig
sh                         apsh4a3a_defconfig
arm                           h5000_defconfig
arm                        neponset_defconfig
arc                          axs103_defconfig
powerpc                     asp8347_defconfig
h8300                       h8s-sim_defconfig
mips                     cu1830-neo_defconfig
i386                             alldefconfig
arm                           u8500_defconfig
m68k                        mvme147_defconfig
ia64                         bigsur_defconfig
arm                       aspeed_g4_defconfig
sh                             espt_defconfig
parisc                           allyesconfig
powerpc                      makalu_defconfig
arc                     haps_hs_smp_defconfig
mips                          rb532_defconfig
mips                         rt305x_defconfig
arm                         axm55xx_defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
sh                        sh7757lcr_defconfig
powerpc                 linkstation_defconfig
m68k                           sun3_defconfig
openrisc                    or1ksim_defconfig
arm                  randconfig-c002-20211219
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
i386                 randconfig-a002-20211216
i386                 randconfig-a003-20211216
i386                 randconfig-a006-20211216
i386                 randconfig-a004-20211216
i386                 randconfig-a001-20211216
i386                 randconfig-a005-20211216
i386                 randconfig-a002-20211218
i386                 randconfig-a005-20211218
i386                 randconfig-a003-20211218
i386                 randconfig-a006-20211218
i386                 randconfig-a004-20211218
x86_64               randconfig-a011-20211219
x86_64               randconfig-a013-20211219
x86_64               randconfig-a012-20211219
x86_64               randconfig-a014-20211219
x86_64               randconfig-a015-20211219
x86_64               randconfig-a016-20211219
i386                 randconfig-a013-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a012-20211219
i386                 randconfig-a014-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a016-20211219
arc                  randconfig-r043-20211217
s390                 randconfig-r044-20211217
riscv                randconfig-r042-20211217
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a002-20211219
i386                 randconfig-a001-20211219
i386                 randconfig-a005-20211219
i386                 randconfig-a003-20211219
i386                 randconfig-a006-20211219
i386                 randconfig-a004-20211219
x86_64               randconfig-a006-20211219
x86_64               randconfig-a005-20211219
x86_64               randconfig-a001-20211219
x86_64               randconfig-a003-20211219
x86_64               randconfig-a002-20211219
x86_64               randconfig-a004-20211219
x86_64               randconfig-a011-20211216
x86_64               randconfig-a014-20211216
x86_64               randconfig-a012-20211216
x86_64               randconfig-a013-20211216
x86_64               randconfig-a015-20211216
x86_64               randconfig-a016-20211216
i386                 randconfig-a013-20211218
i386                 randconfig-a011-20211218
i386                 randconfig-a016-20211218
i386                 randconfig-a015-20211218
i386                 randconfig-a014-20211218
i386                 randconfig-a012-20211218
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216
hexagon              randconfig-r045-20211219
hexagon              randconfig-r041-20211219
hexagon              randconfig-r045-20211217
hexagon              randconfig-r041-20211217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
