Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FF168
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 04:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642739251; x=1674275251;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1X79nRDyw6KkdAlUqihUcVZBXEhAEc/zAMFFkBnn5+I=;
  b=fj/djepwGwuZplTDd2r1FB6LK23jYKdZjN/C/sf3rwG6W4prhLA5e9mU
   fGlzbEs+N5da4KxxDmdgF/C+JJKJHPuZGWbmfe2eg9SDUDzWfutTJKIVz
   WfFpe5NMwiGbQwxHFvOsUH8XvPr0UIKct8/4WqaZ5Qd5dsjjuv6wSndig
   gkMSyTUVoKEjn1xuUTKxsDSnI3hiwjKeChPZVAY/VY23/LsuokqArI6PO
   Td67nVA72fOCb+KQ89KjeStvJQlmw9qOZeq62Wdt7kp6dSNkDYfHJDnaj
   utOc61ksB38ULQmpdkRS0DeD8tPmhHtdCgfextY5LTdMU1XUiq+tg8JCg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="331913052"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="331913052"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 20:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="596009540"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2022 20:27:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nAlWK-000Etq-US; Fri, 21 Jan 2022 04:27:28 +0000
Date: Fri, 21 Jan 2022 12:27:03 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 e8c56cbe2875bb1495df22277e6bf0d970248a4a
Message-ID: <61ea3617.9dK3aoaHtcQASm9z%lkp@intel.com>
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
branch HEAD: e8c56cbe2875bb1495df22277e6bf0d970248a4a  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 727m

configs tested: 163
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220120
sh                          urquell_defconfig
sh                          sdk7780_defconfig
sh                               j2_defconfig
arm                           stm32_defconfig
sh                          landisk_defconfig
arm                           corgi_defconfig
powerpc                       eiger_defconfig
xtensa                       common_defconfig
ia64                      gensparse_defconfig
arm                     eseries_pxa_defconfig
m68k                        m5307c3_defconfig
powerpc                     mpc83xx_defconfig
mips                            gpr_defconfig
ia64                             alldefconfig
m68k                       m5208evb_defconfig
powerpc                     rainier_defconfig
arm                           h5000_defconfig
mips                     decstation_defconfig
sparc                            allyesconfig
mips                        bcm47xx_defconfig
mips                 decstation_r4k_defconfig
sh                           se7721_defconfig
xtensa                generic_kc705_defconfig
sh                          polaris_defconfig
arm                       imx_v6_v7_defconfig
m68k                          sun3x_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                       m5475evb_defconfig
x86_64                              defconfig
powerpc                         wii_defconfig
s390                          debug_defconfig
powerpc                       maple_defconfig
m68k                       m5275evb_defconfig
arm                            mps2_defconfig
powerpc                  iss476-smp_defconfig
arm                  randconfig-c002-20220120
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
ia64                             allmodconfig
ia64                                defconfig
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
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220121
arc                  randconfig-r043-20220121
s390                 randconfig-r044-20220121
riscv                randconfig-r042-20220119
riscv                randconfig-r042-20220117
arc                  randconfig-r043-20220116
arc                  randconfig-r043-20220117
s390                 randconfig-r044-20220117
arc                  randconfig-r043-20220118
arc                  randconfig-r043-20220119
s390                 randconfig-r044-20220119
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
arm                  randconfig-c002-20220120
riscv                randconfig-c006-20220120
powerpc              randconfig-c003-20220120
mips                 randconfig-c004-20220120
i386                          randconfig-c001
powerpc                     ppa8548_defconfig
powerpc                       ebony_defconfig
mips                        omega2p_defconfig
x86_64                           allyesconfig
arm                      tct_hammer_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     kmeter1_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a003-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a005-20220117
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64               randconfig-a002-20220117
riscv                randconfig-r042-20220120
hexagon              randconfig-r045-20220120
hexagon              randconfig-r041-20220120
riscv                randconfig-r042-20220118
hexagon              randconfig-r045-20220116
hexagon              randconfig-r045-20220117
hexagon              randconfig-r045-20220118
hexagon              randconfig-r045-20220119
riscv                randconfig-r042-20220116
hexagon              randconfig-r041-20220118
hexagon              randconfig-r041-20220119
s390                 randconfig-r044-20220118
s390                 randconfig-r044-20220116
hexagon              randconfig-r041-20220116
hexagon              randconfig-r041-20220117

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
