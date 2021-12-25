Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AB173
	for <mptcp@lists.linux.dev>; Sat, 25 Dec 2021 18:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640455306; x=1671991306;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=a0tzoJu/XPRCy8qzMe2TQpRVX+KlWNgurnvqZE1ZzCg=;
  b=NRDlelLQvIT65B0Na8vQv84gJUpduNnM6FvKE3VKSP8MxFFW3JYRTsqP
   lyTlYkTjiNBwOglcflNpUS79fIpKtb9dy/Q94wxp6ycUhF50ryOEcr71R
   UI9ogajk/R1z+YXQXP/bnpvuJXRkGkbjB2DA8AurgHzu2RPkr6Sz7zxyU
   EmXvGo7l1xaisW7FoRT2nWUjMiuN1BOeed6zG7W2ly8JXyOIthYYhJJrf
   SZSJmgwDnXeCNTG+uO9S4NEDXxH/8iuJYKfxyUlj6uU5+A3QkDOzQapQR
   KyyydGLyRAfc+bROW9vNkR5d/L6F2z6v2H8hUFF2naStWmS5t/cp9Qyp1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="221066514"
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="221066514"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 10:01:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="522799034"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Dec 2021 10:01:44 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n1BMV-0004XL-US; Sat, 25 Dec 2021 18:01:43 +0000
Date: Sun, 26 Dec 2021 02:01:38 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 30700eb939c25cbcdf6a3b0e141ea84edc104e45
Message-ID: <61c75c82.ew8XO3zgHPKINSun%lkp@intel.com>
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
branch HEAD: 30700eb939c25cbcdf6a3b0e141ea84edc104e45  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 727m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211225
s390                       zfcpdump_defconfig
arm                       cns3420vb_defconfig
x86_64                              defconfig
sh                              ul2_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc834x_itx_defconfig
sh                         ap325rxa_defconfig
sh                               alldefconfig
mips                     decstation_defconfig
m68k                       bvme6000_defconfig
arm                            hisi_defconfig
h8300                       h8s-sim_defconfig
powerpc                      acadia_defconfig
powerpc                       eiger_defconfig
arm                            dove_defconfig
arm                           viper_defconfig
arm                        trizeps4_defconfig
ia64                          tiger_defconfig
powerpc                       ppc64_defconfig
sh                           se7619_defconfig
riscv                            allmodconfig
arm                    vt8500_v6_v7_defconfig
powerpc                   lite5200b_defconfig
sh                   secureedge5410_defconfig
arm                         cm_x300_defconfig
sh                      rts7751r2d1_defconfig
mips                           mtx1_defconfig
arm                          pcm027_defconfig
s390                             alldefconfig
arm                          pxa3xx_defconfig
arm                            mmp2_defconfig
sh                        sh7785lcr_defconfig
m68k                             allyesconfig
mips                     cu1830-neo_defconfig
sh                          urquell_defconfig
arm                           sama5_defconfig
arm                          moxart_defconfig
ia64                      gensparse_defconfig
arm                         orion5x_defconfig
powerpc                     ppa8548_defconfig
powerpc                     tqm5200_defconfig
h8300                    h8300h-sim_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sunxi_defconfig
arm                              alldefconfig
arc                          axs101_defconfig
arm                           omap1_defconfig
arm                        cerfcube_defconfig
sh                            hp6xx_defconfig
arm                          imote2_defconfig
arm                       imx_v4_v5_defconfig
parisc                              defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
microblaze                      mmu_defconfig
arm                  randconfig-c002-20211225
arm                  randconfig-c002-20211226
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
x86_64               randconfig-a013-20211225
x86_64               randconfig-a014-20211225
x86_64               randconfig-a015-20211225
x86_64               randconfig-a011-20211225
x86_64               randconfig-a012-20211225
x86_64               randconfig-a016-20211225
arc                  randconfig-r043-20211225
s390                 randconfig-r044-20211225
riscv                randconfig-r042-20211225
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a004-20211225
i386                 randconfig-a002-20211225
i386                 randconfig-a003-20211225
i386                 randconfig-a001-20211225
i386                 randconfig-a006-20211225
i386                 randconfig-a005-20211225
x86_64               randconfig-a003-20211225
x86_64               randconfig-a001-20211225
x86_64               randconfig-a005-20211225
x86_64               randconfig-a006-20211225
x86_64               randconfig-a004-20211225
x86_64               randconfig-a002-20211225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
