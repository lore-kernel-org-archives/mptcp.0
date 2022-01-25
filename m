Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F300F29CA
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 22:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643150486; x=1674686486;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2NoLw+E6YShE46P4WI/2FeAwQxAd7KfNhf4KqCD/ttw=;
  b=GvIIe1Q6i7Hwc+1wMNNHcSOqIRAYItjsQxhdmT4YaTg8YmfBizCepzns
   832BolM3Kr3SVKnNIgkFSuE/nBDQKCitGuq+LtoFKhOieZyxaUDtIQjBq
   zVuRWzpuTBrrx7pr5Xfd9sxldnDySO8VD+Zsf5kgyT2DVX0cY+vUTjODz
   0ndF3vPgSFxYLS7W9latfBkfY/uWo95QCJD1eXQW3dr051qK+062t289p
   bfS+o3aWP2QcyK8xUQqlHWB0f6ekmgds2veAPPfetQphpEldjYAhFHseP
   Nt0bFw2n0pT1OYf8zMAq3zoGm9CPYEn0gbc3hWl9Ctp1SAWCKPDozEMTd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307147684"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="307147684"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 14:41:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="520573621"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2022 14:41:24 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1nCUV9-000KWK-Tx; Tue, 25 Jan 2022 22:41:23 +0000
Date: Wed, 26 Jan 2022 06:40:50 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 eaf44f1da65c7e76af2b8196f9b9c42497824519
Message-ID: <61f07c72.SFPAMkbPD0DhSQkV%lkp@intel.com>
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
branch HEAD: eaf44f1da65c7e76af2b8196f9b9c42497824519  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 749m

configs tested: 131
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
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                         bigsur_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     rainier_defconfig
mips                      maltasmvp_defconfig
sh                 kfr2r09-romimage_defconfig
sh                           se7206_defconfig
powerpc                     redwood_defconfig
arm                        spear6xx_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         rt305x_defconfig
arm                        mini2440_defconfig
ia64                             alldefconfig
arc                        nsimosci_defconfig
alpha                            alldefconfig
sh                           se7619_defconfig
xtensa                          iss_defconfig
sh                         apsh4a3a_defconfig
um                               alldefconfig
sh                           se7721_defconfig
arc                    vdk_hs38_smp_defconfig
microblaze                          defconfig
sh                         ap325rxa_defconfig
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
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
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
arc                  randconfig-r043-20220124
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
mips                  cavium_octeon_defconfig
powerpc                      ppc64e_defconfig
arm                        vexpress_defconfig
arm                          pxa168_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
mips                           ip28_defconfig
powerpc                   bluestone_defconfig
mips                           mtx1_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
powerpc                      walnut_defconfig
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
i386                 randconfig-a011-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a012-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a016-20220124
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
riscv                randconfig-r042-20220124
s390                 randconfig-r044-20220124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
