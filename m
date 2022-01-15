Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A79168
	for <mptcp@lists.linux.dev>; Sat, 15 Jan 2022 03:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642216842; x=1673752842;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pz4W7TB6a4LS7RdQTmOqAnOovguEEYyILTauOHsk258=;
  b=lhIsOMV9teOTnx/EXUOHYaZNWn5jniwr7QTGmQzmGmBW2DGUwhJTohom
   hW+7Q5cUeSNJDMVAQq7aTp94UcxE1h3RpFPB8R8gaf7iAjKnG54v7zXle
   FAHmgc78AcyEnNYQmCXPlgjkzs494FHIOeID/TJhih9KFdhfzaKqCfxRr
   1CI68HyPnzu+9BRuAaiJnrxeHFcVgJb6Yubyp7su3zuV4p4VZSudY4rdh
   6Y6iot1jQfig8Jkap9/MoFpoM6C6bV3svBfDUZZIux8zouWAJ/2zoPsMp
   QvFedT6GngDdxl1eMIJ8gFuLt3xXoNlWAy80SM0YwJ+OoGq8s58eBYGq2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="224356480"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="224356480"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 19:20:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="475998017"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2022 19:20:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n8ZcL-0009K1-Tf; Sat, 15 Jan 2022 03:20:37 +0000
Date: Sat, 15 Jan 2022 11:20:03 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 5c45a004f2cc5b89606c2bb2963dc4deab9a6b37
Message-ID: <61e23d63.gNZDE9yPJ9tlsJXv%lkp@intel.com>
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
branch HEAD: 5c45a004f2cc5b89606c2bb2963dc4deab9a6b37  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 744m

configs tested: 93
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
sh                   sh7724_generic_defconfig
m68k                          atari_defconfig
powerpc                        warp_defconfig
arm                           tegra_defconfig
sh                              ul2_defconfig
arm                           sama5_defconfig
x86_64                           alldefconfig
powerpc                 mpc85xx_cds_defconfig
m68k                       m5475evb_defconfig
sparc                            allyesconfig
arm                          simpad_defconfig
arm                        mvebu_v7_defconfig
arm                           viper_defconfig
arm                      integrator_defconfig
powerpc                      tqm8xx_defconfig
arm                          iop32x_defconfig
mips                         tb0226_defconfig
arm                            mps2_defconfig
arm                          lpd270_defconfig
riscv                            allmodconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                  randconfig-c002-20220113
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220113
hexagon              randconfig-r041-20220113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
