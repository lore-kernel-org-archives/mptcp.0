Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201722CA3
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643225548; x=1674761548;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=U+3H7N5dyz9QrxJsa1abPL21p6/63vXzAvApdQVCIO0=;
  b=X/aGYbOcvOI55dxLhlwkJujpJeRisyIxP/dewU6Fu/2YWoFOjG/aCifK
   qk3HMeq5l6LsRQe9F1IMTamb8dXUNIs98KlqdFTXeaKjklUReQoRS6c4t
   9wf/m8AP3el1ySqoCMiUYpy3XwzL/eGqhJpSsO99j2PcRynsHd2nO02Is
   jR/+qwpM/eyFuHaIY/Z3dtMIZeVen3Zeuoyte1Arl6NNwasOtNp99mczF
   Bf42wf3NVYskAMnPGl9dCNnot9oPf53RM+/xXFUy6bP/nbxidMQ17qcIP
   HcgNjzHXJMcgwdpNPfC/e4okAP7M0MkOvI1TP3ED7hdumlbIblQ1YvIX+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309946204"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="309946204"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 11:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="535307532"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jan 2022 11:32:12 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nCo1a-000LYx-Mt; Wed, 26 Jan 2022 19:32:10 +0000
Date: Thu, 27 Jan 2022 03:31:35 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 05854a699d27b11d8fb3217ec2e0dbf28ecb58e8
Message-ID: <61f1a197.sx/cwghQ8m910A7M%lkp@intel.com>
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
branch HEAD: 05854a699d27b11d8fb3217ec2e0dbf28ecb58e8  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 724m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
arm                            hisi_defconfig
sh                            hp6xx_defconfig
arm                          gemini_defconfig
mips                            ar7_defconfig
sparc                               defconfig
m68k                             allyesconfig
m68k                            q40_defconfig
powerpc                 linkstation_defconfig
arm                         s3c6400_defconfig
m68k                           sun3_defconfig
arm                        oxnas_v6_defconfig
m68k                          multi_defconfig
arm                         vf610m4_defconfig
arm                         nhk8815_defconfig
mips                 decstation_r4k_defconfig
openrisc                  or1klitex_defconfig
arc                         haps_hs_defconfig
sh                        apsh4ad0a_defconfig
arm                        trizeps4_defconfig
sh                           se7780_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
mips                           xway_defconfig
sh                         apsh4a3a_defconfig
um                               alldefconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
openrisc                            defconfig
i386                                defconfig
ia64                         bigsur_defconfig
h8300                    h8300h-sim_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                            zeus_defconfig
sh                         ap325rxa_defconfig
nios2                         10m50_defconfig
s390                             allyesconfig
powerpc                 mpc834x_mds_defconfig
sh                          sdk7780_defconfig
arc                            hsdk_defconfig
arm                        mini2440_defconfig
mips                  decstation_64_defconfig
xtensa                           alldefconfig
s390                          debug_defconfig
m68k                        mvme16x_defconfig
xtensa                       common_defconfig
sh                   sh7724_generic_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            xcep_defconfig
arm                          lpd270_defconfig
sh                          r7785rp_defconfig
arc                              allyesconfig
h8300                     edosk2674_defconfig
powerpc                  storcenter_defconfig
sh                             shx3_defconfig
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
x86_64               randconfig-a001-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220124
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
arm                           omap1_defconfig
powerpc                   lite5200b_defconfig
mips                          malta_defconfig
powerpc                     mpc512x_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
arm                        multi_v5_defconfig
i386                             allyesconfig
powerpc                      walnut_defconfig
arm                        mvebu_v5_defconfig
powerpc                     tqm8560_defconfig
powerpc                        fsp2_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
s390                 randconfig-r044-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220125
hexagon              randconfig-r041-20220125
riscv                randconfig-r042-20220126
hexagon              randconfig-r045-20220126
hexagon              randconfig-r041-20220126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
