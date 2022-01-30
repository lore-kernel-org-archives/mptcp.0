Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3929CA
	for <mptcp@lists.linux.dev>; Sun, 30 Jan 2022 21:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643576634; x=1675112634;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jmrWN7ERRqI++LWA4WdF9LX09VOUEs+tCvHh9B4svrY=;
  b=SGx7r0vU1sPu5B9fXL+w+RWPcB3nRhHOVJqPv3GaKN7Ofr11Sj2l3Ily
   Q9ArVn5x8pCbQ1RiQM9Ig/cf4G65/iSsot6iT6N5LWnbY0VW+xm2Vk2iG
   FBKP9EtVeDbrDfwc+Kxhy1NJEX65hqvXV/2iYMZYEoBwuOfhEYpcwxg+C
   rWt5+pvOy+hbttnEoBKpXJ9sjWSY7HZrnNTLQzuuFWuLXYw9g1uK+T5mw
   TwZcuVBl5cQR+kXwFlDjIfD+fTyrRP5g8YBgD1gyHAbp3MtUjrR3yRA5X
   TECIcHi6PQppsy+ja9YeTWFDigDTOFT6Ug4UFcNxqYC0wOk9ObcUaJHB3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247592422"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="247592422"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:03:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="598678850"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2022 13:03:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nEHMV-000Qz6-L4; Sun, 30 Jan 2022 21:03:51 +0000
Date: Mon, 31 Jan 2022 05:02:50 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 a80dde33bf24ed704429057a638e3dc7a9dba4af
Message-ID: <61f6fcfa.QLKOR1YPkdfLkVoB%lkp@intel.com>
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
branch HEAD: a80dde33bf24ed704429057a638e3dc7a9dba4af  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 721m

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
i386                 randconfig-c001-20220131
sh                          polaris_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5208evb_defconfig
powerpc                  storcenter_defconfig
arm                           sama5_defconfig
parisc                generic-32bit_defconfig
arm                             pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
riscv                            allyesconfig
sh                        apsh4ad0a_defconfig
powerpc                     tqm8541_defconfig
arm                        spear6xx_defconfig
xtensa                           alldefconfig
m68k                                defconfig
powerpc                       ppc64_defconfig
sparc                       sparc32_defconfig
sh                            migor_defconfig
sh                        sh7757lcr_defconfig
powerpc                      ep88xc_defconfig
arc                          axs103_defconfig
sh                           se7206_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc834x_mds_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
s390                 randconfig-r044-20220130
riscv                    nommu_k210_defconfig
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
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
powerpc                   bluestone_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                    ge_imp3a_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
