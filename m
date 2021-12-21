Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED4168
	for <mptcp@lists.linux.dev>; Tue, 21 Dec 2021 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640117116; x=1671653116;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hSbz2O8chqw36AcPihmylxulkpuyMyBA2P0MIb+OgYA=;
  b=DJKp8/SrAMucCHmV7LO8H9GW3t/g5qx3cHH+Ibh8CgKHyvhIv2eGIo09
   is26uuGOJsmzK0RQLFq4mDiHVO+syoI+SVy3TD4DCZq64Zo6yEk2Vd+9J
   NAaSrM6Lssdo4WQbzTm8WG2bY/JNZVr4a84ZICVg5qzCkPgqCbfglvhVD
   HOxSrk2TqlbstktYNdHhj0xO9Q/tSNHedQrgHO03kACP1QxSJcH08OwZc
   6URrCvhsdn0vNGaPzoufMow/Heo+rH835Y8E/Y8S8swGOW7AhdwW5WhqE
   xRQ2oS3tj4k6J5DKDrX/USdYm7li1BYJNEr4pTL8yN99O/Bk/K/c8of8e
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="220494954"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="220494954"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 12:05:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="607177623"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Dec 2021 12:05:14 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mzlNp-0009Uu-Vg; Tue, 21 Dec 2021 20:05:13 +0000
Date: Wed, 22 Dec 2021 04:04:13 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 80b396a885cda13de64398dd95e698578a02b66e
Message-ID: <61c2333d.PO2VrHcDo9+ewOHx%lkp@intel.com>
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
branch HEAD: 80b396a885cda13de64398dd95e698578a02b66e  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 793m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
powerpc                       maple_defconfig
arm                       imx_v4_v5_defconfig
arm                        vexpress_defconfig
mips                       bmips_be_defconfig
sh                           se7712_defconfig
arc                            hsdk_defconfig
riscv                    nommu_virt_defconfig
arm                         palmz72_defconfig
sh                             shx3_defconfig
mips                       lemote2f_defconfig
arm                         hackkit_defconfig
parisc                generic-64bit_defconfig
powerpc                       eiger_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                             sh03_defconfig
sh                            hp6xx_defconfig
arm                  randconfig-c002-20211220
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a005-20211220
x86_64               randconfig-a006-20211220
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a012-20211221
i386                 randconfig-a011-20211221
i386                 randconfig-a013-20211221
i386                 randconfig-a014-20211221
i386                 randconfig-a016-20211221
i386                 randconfig-a015-20211221
arc                  randconfig-r043-20211220
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a013-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a015-20211220
x86_64               randconfig-a016-20211220
i386                 randconfig-a012-20211220
i386                 randconfig-a011-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a013-20211220
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
s390                 randconfig-r044-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
