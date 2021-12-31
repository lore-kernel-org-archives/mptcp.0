Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EA168
	for <mptcp@lists.linux.dev>; Fri, 31 Dec 2021 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640974870; x=1672510870;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+NtWo4yw03Bv1p3/bg8iFVYdDVi7zLMLq2v0IvDOfyk=;
  b=bmWGpvbt8KbuWCoYrjJ1m3sHy32X7JakTqAO6lZID6xHJ910lMMx0H/W
   9NHXW3yBB9DHZkEi5aoW86l7R0Px/MvYae8VzY6o+4QwDJncYr7ofiaJF
   +Q4Y14wTB7PENjanzqrkm6URww87Kwy+jUAVGkBSumejGYB2yys91TDHn
   O4BKMBk9HTeeewo4vkUVROva2JhDDhuzpVcMeku6Hy9jNfQbNcRlnfFKb
   ZlCr89rT5fmUCFyw3l33atWe1/GNyXjItoOXSFQm1gPeBwwkAhTaZpaQM
   3Vy7yUuvACCkU1qOnEMm6NKBP8NI09YH2sKsK629h8iRO64uuAk9CuEes
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="229149464"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="229149464"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 10:21:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="589824949"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Dec 2021 10:21:08 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n3MWa-000BZV-72; Fri, 31 Dec 2021 18:21:08 +0000
Date: Sat, 01 Jan 2022 02:20:17 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 47fd217c8dc0861b04bf29095a00d42fdcf3ae69
Message-ID: <61cf49e1.0ZBBaMBw/SZpVfnW%lkp@intel.com>
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
branch HEAD: 47fd217c8dc0861b04bf29095a00d42fdcf3ae69  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 727m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211231
alpha                            allyesconfig
sh                            shmin_defconfig
arm                            dove_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                            lart_defconfig
parisc                generic-64bit_defconfig
arm                            mps2_defconfig
nds32                             allnoconfig
parisc                              defconfig
powerpc                      walnut_defconfig
powerpc                     pseries_defconfig
sh                             shx3_defconfig
arm                         cm_x300_defconfig
arm                           corgi_defconfig
m68k                            q40_defconfig
arm                       cns3420vb_defconfig
powerpc                    gamecube_defconfig
nds32                            alldefconfig
powerpc                        fsp2_defconfig
m68k                         amcore_defconfig
powerpc                        icon_defconfig
arm                            zeus_defconfig
arm                         hackkit_defconfig
powerpc                 mpc8540_ads_defconfig
sh                ecovec24-romimage_defconfig
powerpc                   lite5200b_defconfig
arm                           viper_defconfig
mips                  maltasmvp_eva_defconfig
openrisc                            defconfig
alpha                               defconfig
arm                         shannon_defconfig
mips                         tb0287_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           ci20_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                    sam440ep_defconfig
h8300                       h8s-sim_defconfig
sparc                            allyesconfig
um                                  defconfig
powerpc                      chrp32_defconfig
i386                                defconfig
arc                          axs103_defconfig
m68k                       m5475evb_defconfig
sh                           sh2007_defconfig
xtensa                           alldefconfig
microblaze                          defconfig
arm                          pxa910_defconfig
powerpc                      arches_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                   currituck_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
sh                          rsk7201_defconfig
alpha                            alldefconfig
mips                         db1xxx_defconfig
parisc                generic-32bit_defconfig
h8300                               defconfig
arm                        realview_defconfig
arm                           omap1_defconfig
mips                         mpc30x_defconfig
arm                            qcom_defconfig
mips                     loongson1b_defconfig
powerpc                       holly_defconfig
m68k                       bvme6000_defconfig
arm                        oxnas_v6_defconfig
powerpc                  storcenter_defconfig
arm                           spitz_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc836x_mds_defconfig
sparc                       sparc64_defconfig
sh                              ul2_defconfig
microblaze                      mmu_defconfig
powerpc                      tqm8xx_defconfig
ia64                             allmodconfig
sh                   sh7724_generic_defconfig
powerpc                    socrates_defconfig
mips                            e55_defconfig
sh                        edosk7705_defconfig
arm                  randconfig-c002-20211231
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                               defconfig
nds32                               defconfig
csky                                defconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211231
x86_64               randconfig-a001-20211231
x86_64               randconfig-a003-20211231
x86_64               randconfig-a006-20211231
x86_64               randconfig-a004-20211231
x86_64               randconfig-a005-20211231
i386                 randconfig-a001-20211231
i386                 randconfig-a005-20211231
i386                 randconfig-a004-20211231
i386                 randconfig-a002-20211231
i386                 randconfig-a006-20211231
i386                 randconfig-a003-20211231
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                          moxart_defconfig
mips                          ath25_defconfig
mips                      maltaaprp_defconfig
arm                         socfpga_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                  colibri_pxa270_defconfig
x86_64               randconfig-a013-20211231
x86_64               randconfig-a015-20211231
x86_64               randconfig-a012-20211231
x86_64               randconfig-a011-20211231
x86_64               randconfig-a016-20211231
x86_64               randconfig-a014-20211231
i386                 randconfig-a016-20211231
i386                 randconfig-a011-20211231
i386                 randconfig-a012-20211231
i386                 randconfig-a013-20211231
i386                 randconfig-a014-20211231
i386                 randconfig-a015-20211231
hexagon              randconfig-r041-20211231
hexagon              randconfig-r045-20211231
riscv                randconfig-r042-20211231

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
