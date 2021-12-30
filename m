Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9629CA
	for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 19:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640892450; x=1672428450;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+o48Wg/lM37mFrscIzw3t9dJRYmlaTqy/ENA939ytDk=;
  b=AY8sLhGIo7oW+qplC8I0NtYLXrPOVatv7dWOLUWjHv+RE8AwPDiHK7Vk
   A2LiFz2CaNuJI83tkkxxQ6b7+pPqGy/3Jos9mYymBNMV+0lEyKXQkQ1Pl
   lFuoFDN8beQmoyf0I8z/fG5/pLRdBXaGsNiD+DCQxiLOVbow82QVlLGFq
   ed4SPYgMSxQju7YiFqoBVokdxa1wghjz3xmu7mtz8+Yj+MsUkDVxn64Us
   Lhs3vkkPlwCmteI8oJ2J8T0QfOW41dgjGODnUaMzqkiKHeAhk1DeZlDs3
   Z0bDOATDd2KSFgBbXvBgKIeJpR1O7YD6WqRDTtpoJbNl+iU2izMtu3Pt3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="221719497"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="221719497"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 11:27:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="524491597"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Dec 2021 11:27:28 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n315D-000AWc-Nr; Thu, 30 Dec 2021 19:27:27 +0000
Date: Fri, 31 Dec 2021 03:27:12 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 6bee05f40ab1a92ac2472db09306cf8042b23018
Message-ID: <61ce0810.B11yNQSMx+Xy2Adz%lkp@intel.com>
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
branch HEAD: 6bee05f40ab1a92ac2472db09306cf8042b23018  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 721m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211229
i386                 randconfig-c001-20211228
i386                 randconfig-c001-20211230
arm                        mvebu_v5_defconfig
mips                        qi_lb60_defconfig
sh                        apsh4ad0a_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc834x_mds_defconfig
arm                            hisi_defconfig
riscv                             allnoconfig
mips                       lemote2f_defconfig
powerpc                     ppa8548_defconfig
powerpc                      makalu_defconfig
sh                           se7780_defconfig
arm                  colibri_pxa300_defconfig
mips                           ip28_defconfig
arm                      tct_hammer_defconfig
arm                         s3c6400_defconfig
powerpc                     pseries_defconfig
arm                         lpc18xx_defconfig
arm                     eseries_pxa_defconfig
arc                     nsimosci_hs_defconfig
sh                        edosk7705_defconfig
powerpc                     akebono_defconfig
arc                          axs101_defconfig
arm                       imx_v4_v5_defconfig
powerpc                    ge_imp3a_defconfig
sh                         ap325rxa_defconfig
arm                        oxnas_v6_defconfig
arm                          moxart_defconfig
powerpc                     pq2fads_defconfig
sh                          sdk7786_defconfig
arc                            hsdk_defconfig
arm                        multi_v7_defconfig
mips                     loongson2k_defconfig
openrisc                         alldefconfig
arm                         at91_dt_defconfig
mips                        bcm63xx_defconfig
sh                           se7750_defconfig
sh                        sh7785lcr_defconfig
arm                          pxa910_defconfig
mips                         tb0287_defconfig
m68k                         apollo_defconfig
sh                ecovec24-romimage_defconfig
arm                      integrator_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
xtensa                          iss_defconfig
ia64                            zx1_defconfig
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
sh                           se7721_defconfig
h8300                       h8s-sim_defconfig
sh                                  defconfig
um                               alldefconfig
mips                            gpr_defconfig
m68k                           sun3_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
arm                           omap1_defconfig
arm                          ixp4xx_defconfig
arm                           sunxi_defconfig
m68k                          atari_defconfig
arm                         s5pv210_defconfig
arm                        mvebu_v7_defconfig
mips                         tb0226_defconfig
arc                        nsimosci_defconfig
arm                  randconfig-c002-20211230
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20211230
x86_64               randconfig-a015-20211230
x86_64               randconfig-a012-20211230
x86_64               randconfig-a011-20211230
x86_64               randconfig-a016-20211230
x86_64               randconfig-a014-20211230
i386                 randconfig-a011-20211230
i386                 randconfig-a012-20211230
i386                 randconfig-a013-20211230
i386                 randconfig-a014-20211230
i386                 randconfig-a015-20211230
i386                 randconfig-a016-20211230
arc                  randconfig-r043-20211230
riscv                randconfig-r042-20211230
s390                 randconfig-r044-20211230
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3

clang tested configs:
x86_64               randconfig-a002-20211230
x86_64               randconfig-a001-20211230
x86_64               randconfig-a003-20211230
x86_64               randconfig-a006-20211230
x86_64               randconfig-a004-20211230
x86_64               randconfig-a005-20211230
i386                 randconfig-a001-20211230
i386                 randconfig-a005-20211230
i386                 randconfig-a004-20211230
i386                 randconfig-a002-20211230
i386                 randconfig-a006-20211230
i386                 randconfig-a003-20211230
x86_64               randconfig-a015-20211228
x86_64               randconfig-a014-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
hexagon              randconfig-r041-20211230
hexagon              randconfig-r045-20211230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
