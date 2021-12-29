Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD1168
	for <mptcp@lists.linux.dev>; Wed, 29 Dec 2021 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640801333; x=1672337333;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gOGzrV+xv435ks1dhtsxq5J9CPkMeRHjoSDZ+bc1JUY=;
  b=ByYiwzleD8r/dYze4T5HcqG+m9L6rj+S0BnZq5DzqWdfu18tS9vgkVZ0
   YZdYfMWwFm64rVDZgQR0Xe1TynRH8OA/ir4j6mRhAk+8tpuAIFSCKBOVX
   T8dWwGAIa/RooBITDcy4XsfvrqsMU/fEQ0sb4XLZgvUbIh4mu4XvtoMGi
   IGitReJ1YPQ9tPstsJerV0bSAwtmakqGydO8F/gW0XzSxbdkvt9K9DiDf
   TgwdN2zzXjfzUKsXt1yPkUi6oGtugdDX/DJWuCxDdoD50gE0viL0pQqmE
   5gg763UnvUAfvsksFQFCAl1EFSEaEmkQhGJ8qOLXdzjL/VGvWGVVfouox
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="221549465"
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="221549465"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 10:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="686973509"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Dec 2021 10:08:15 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n2dN0-0009Iw-DI; Wed, 29 Dec 2021 18:08:14 +0000
Date: Thu, 30 Dec 2021 02:07:22 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 ac3838835db3324605a87ee4f08b27c919724974
Message-ID: <61cca3da.GDC5neNBLxdRevpC%lkp@intel.com>
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
branch HEAD: ac3838835db3324605a87ee4f08b27c919724974  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 721m

configs tested: 151
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
i386                 randconfig-c001-20211228
powerpc              randconfig-c003-20211229
arm                             mxs_defconfig
arm                          simpad_defconfig
powerpc                     mpc5200_defconfig
m68k                        mvme16x_defconfig
um                             i386_defconfig
mips                         tb0226_defconfig
arc                                 defconfig
riscv                    nommu_virt_defconfig
mips                        workpad_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           ip32_defconfig
mips                     decstation_defconfig
parisc                generic-32bit_defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
parisc                generic-64bit_defconfig
arm                       versatile_defconfig
arm                          pxa3xx_defconfig
mips                      bmips_stb_defconfig
sh                           se7343_defconfig
sh                          urquell_defconfig
arm                      pxa255-idp_defconfig
csky                                defconfig
powerpc                     kmeter1_defconfig
mips                  cavium_octeon_defconfig
i386                                defconfig
ia64                            zx1_defconfig
mips                         cobalt_defconfig
mips                            ar7_defconfig
powerpc                      cm5200_defconfig
ia64                          tiger_defconfig
powerpc                 mpc837x_rdb_defconfig
sparc                               defconfig
m68k                       m5249evb_defconfig
microblaze                      mmu_defconfig
sh                        sh7757lcr_defconfig
arm                     eseries_pxa_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            lart_defconfig
sh                           se7750_defconfig
mips                         tb0219_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                    maltaup_xpa_defconfig
arm                           sama5_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     tqm5200_defconfig
powerpc                     sequoia_defconfig
powerpc                 mpc836x_mds_defconfig
arm                     davinci_all_defconfig
mips                     loongson2k_defconfig
powerpc                    amigaone_defconfig
m68k                        m5272c3_defconfig
arm                       aspeed_g4_defconfig
arm                         at91_dt_defconfig
arm                       cns3420vb_defconfig
powerpc                     mpc83xx_defconfig
arm                        spear3xx_defconfig
arm                  randconfig-c002-20211229
arm                  randconfig-c002-20211228
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
nds32                             allnoconfig
nios2                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20211229
x86_64               randconfig-a014-20211229
x86_64               randconfig-a013-20211229
x86_64               randconfig-a011-20211229
x86_64               randconfig-a012-20211229
x86_64               randconfig-a016-20211229
arc                  randconfig-r043-20211229
riscv                randconfig-r042-20211229
s390                 randconfig-r044-20211229
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20211228
mips                 randconfig-c004-20211228
powerpc              randconfig-c003-20211228
arm                  randconfig-c002-20211228
x86_64               randconfig-c007-20211228
i386                 randconfig-c001-20211228
x86_64               randconfig-a005-20211229
x86_64               randconfig-a001-20211229
x86_64               randconfig-a003-20211229
x86_64               randconfig-a006-20211229
x86_64               randconfig-a004-20211229
x86_64               randconfig-a002-20211229
i386                 randconfig-a002-20211229
i386                 randconfig-a003-20211229
i386                 randconfig-a001-20211229
i386                 randconfig-a006-20211229
i386                 randconfig-a004-20211229
i386                 randconfig-a005-20211229
x86_64               randconfig-a015-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
x86_64               randconfig-a014-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a015-20211228
i386                 randconfig-a011-20211228
i386                 randconfig-a014-20211228
i386                 randconfig-a016-20211228
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228
hexagon              randconfig-r041-20211229
hexagon              randconfig-r045-20211229

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
