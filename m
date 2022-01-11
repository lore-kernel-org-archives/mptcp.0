Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8009173
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 20:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641934426; x=1673470426;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LKDcjJOHqXpD3D3b6O6Ll9wd+cqsYuUfCxyLSVfVEQk=;
  b=KH5Yfs2Ad9ttT5CR3ybqEbljnR43M511Em7Y7MdfUT1/Hdg8lDjF7HTO
   0haa4SzAgl2k1WlUM2suIGOBNI4NLbE8fSj41GuuoEyAixM4jZsHK65X9
   OcTkM6ATYZENG5aBTcceVbg1BT/B4mi4XYblgkaXOYdxWcPwOCQyBsrNE
   NdzaBwQcmT53TMvjMljPcuJFS1rOKX+CYHSvAZZhuD1s5iRXxFt0u3iHe
   whKOA9Mh4+RN6UTu7sQIXzAvx6RrQWB8EB9tuOgz+N7AniTIQV5jz6W3a
   6GMYefIc06pyMUw2ojXQot006BtiX3a3H4WDkkCtmaiQHa7pweU58Gpjf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="329928445"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="329928445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 12:53:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="576323828"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jan 2022 12:53:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n7O9I-0005Di-8E; Tue, 11 Jan 2022 20:53:44 +0000
Date: Wed, 12 Jan 2022 04:53:14 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 0fae3b66ef59eb0a8b4f692d446fddff9c3cf343
Message-ID: <61ddee3a.gi1/Bk8egZ+eahyR%lkp@intel.com>
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
branch HEAD: 0fae3b66ef59eb0a8b4f692d446fddff9c3cf343  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 830m

configs tested: 153
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
sh                           se7750_defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
m68k                       m5475evb_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     mpc83xx_defconfig
mips                      maltasmvp_defconfig
sh                                  defconfig
powerpc                      ep88xc_defconfig
sh                            migor_defconfig
arm                        mini2440_defconfig
m68k                                defconfig
s390                          debug_defconfig
arc                              allyesconfig
arm                       multi_v4t_defconfig
arm                           viper_defconfig
h8300                       h8s-sim_defconfig
sh                           se7751_defconfig
arm                         assabet_defconfig
microblaze                          defconfig
s390                       zfcpdump_defconfig
sh                          urquell_defconfig
m68k                          amiga_defconfig
sh                           se7722_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          landisk_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
powerpc                  storcenter_defconfig
sh                            titan_defconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
arm                        multi_v7_defconfig
arm                            hisi_defconfig
sh                             shx3_defconfig
powerpc                      pcm030_defconfig
xtensa                       common_defconfig
powerpc                   motionpro_defconfig
sh                          kfr2r09_defconfig
m68k                             allmodconfig
sh                           se7780_defconfig
m68k                            q40_defconfig
sh                          sdk7780_defconfig
sh                        edosk7760_defconfig
mips                        jmr3927_defconfig
xtensa                           alldefconfig
m68k                         apollo_defconfig
arm                       aspeed_g5_defconfig
arm                        cerfcube_defconfig
um                               alldefconfig
arm                  randconfig-c002-20220111
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
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
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220111
arc                  randconfig-r043-20220111
s390                 randconfig-r044-20220111
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220111
x86_64                        randconfig-c007
riscv                randconfig-c006-20220111
powerpc              randconfig-c003-20220111
i386                          randconfig-c001
mips                 randconfig-c004-20220111
s390                 randconfig-c005-20220111
arm                  colibri_pxa300_defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_mds_defconfig
mips                        workpad_defconfig
mips                          ath79_defconfig
mips                           ip27_defconfig
powerpc                          allmodconfig
powerpc                     kmeter1_defconfig
arm                    vt8500_v6_v7_defconfig
mips                          rm200_defconfig
powerpc                      acadia_defconfig
hexagon                          alldefconfig
powerpc                      pmac32_defconfig
mips                           ip22_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc832x_mds_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220111
hexagon              randconfig-r041-20220111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
