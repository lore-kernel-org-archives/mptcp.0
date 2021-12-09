Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9F2C80
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 18:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639073021; x=1670609021;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9DI2Sk9C2NCKZOm7FmuoqUxb1YEfNF/FfD6ydvPyK4M=;
  b=csGnKxZwGad4H42UhQWDbZON3vMlxLNMeHXmyNw4PcLmONwJzKgGXTXX
   hKR8KeugA+GP5fecU8bFWMuVeCcKagvtms8nfPMhhRoXMJXabQG4LsPVu
   rNzHlVJhKJkDhExL4RccOYF9hIS1uTTj6nVcw4sda2gRK++zmXE/muPC0
   Jnf0UO2UhnmemLa6qpMALkZBM3k0bhmG7MhT//7cMBOj1Q3QcurB4dVnb
   Yd/GGUdFlryy8/c5NJ+CaO6OEyc0RYoTZA4EWOeiFIXkWYXoGS61yUxcA
   CrUtPlgdO6es+ybfffmczqHRABvS9YCoideT+6jbx2gegshxzNbIaygVW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="324431522"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="324431522"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 10:02:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="463343972"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2021 10:02:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mvNkZ-0002Ed-64; Thu, 09 Dec 2021 18:02:35 +0000
Date: Fri, 10 Dec 2021 02:02:04 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 fefe23ffeba5f26099705e4a27ca1893ddb3116d
Message-ID: <61b2449c.n5OaQ8VlVI53OSMG%lkp@intel.com>
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
branch HEAD: fefe23ffeba5f26099705e4a27ca1893ddb3116d  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 723m

configs tested: 156
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211209
powerpc                      mgcoge_defconfig
arm                        mvebu_v7_defconfig
m68k                        stmark2_defconfig
arm                          imote2_defconfig
powerpc                      chrp32_defconfig
arm                         hackkit_defconfig
arm                             mxs_defconfig
powerpc                       holly_defconfig
mips                         mpc30x_defconfig
sh                           se7206_defconfig
arc                      axs103_smp_defconfig
mips                           mtx1_defconfig
m68k                       m5249evb_defconfig
arm                           spitz_defconfig
powerpc64                        alldefconfig
sh                            titan_defconfig
powerpc                  storcenter_defconfig
arm                          lpd270_defconfig
powerpc                    sam440ep_defconfig
mips                          rm200_defconfig
arm                        keystone_defconfig
mips                      loongson3_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      pasemi_defconfig
m68k                        mvme16x_defconfig
arm                             rpc_defconfig
mips                        bcm63xx_defconfig
mips                     loongson2k_defconfig
sh                          kfr2r09_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                            dove_defconfig
powerpc                     tqm8548_defconfig
mips                        workpad_defconfig
arm                           corgi_defconfig
s390                             allyesconfig
alpha                               defconfig
arm                  colibri_pxa270_defconfig
powerpc                     stx_gp3_defconfig
mips                         tb0287_defconfig
sh                          landisk_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
riscv                               defconfig
arm                        clps711x_defconfig
sh                     sh7710voipgw_defconfig
arm                      integrator_defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
arm                           sama5_defconfig
powerpc                          g5_defconfig
powerpc                     sequoia_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
h8300                       h8s-sim_defconfig
sh                   sh7724_generic_defconfig
powerpc               mpc834x_itxgp_defconfig
um                                  defconfig
arc                     nsimosci_hs_defconfig
sh                          lboxre2_defconfig
arm                    vt8500_v6_v7_defconfig
nios2                         3c120_defconfig
arm                        spear6xx_defconfig
arc                            hsdk_defconfig
powerpc                 canyonlands_defconfig
powerpc                     tqm8560_defconfig
arm                         cm_x300_defconfig
arm                      tct_hammer_defconfig
powerpc                      ppc6xx_defconfig
m68k                        m5272c3_defconfig
arm                  randconfig-c002-20211209
ia64                                defconfig
ia64                             allmodconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
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
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
i386                 randconfig-a001-20211209
i386                 randconfig-a005-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
arm                  randconfig-c002-20211209
x86_64               randconfig-c007-20211209
riscv                randconfig-c006-20211209
i386                 randconfig-c001-20211209
mips                 randconfig-c004-20211209
powerpc              randconfig-c003-20211209
s390                 randconfig-c005-20211209
x86_64               randconfig-a016-20211209
x86_64               randconfig-a011-20211209
x86_64               randconfig-a013-20211209
x86_64               randconfig-a015-20211209
x86_64               randconfig-a012-20211209
x86_64               randconfig-a014-20211209
i386                 randconfig-a013-20211209
i386                 randconfig-a016-20211209
i386                 randconfig-a011-20211209
i386                 randconfig-a014-20211209
i386                 randconfig-a012-20211209
i386                 randconfig-a015-20211209
hexagon              randconfig-r045-20211209
s390                 randconfig-r044-20211209
hexagon              randconfig-r041-20211209
riscv                randconfig-r042-20211209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
