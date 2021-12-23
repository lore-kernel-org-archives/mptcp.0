Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA3168
	for <mptcp@lists.linux.dev>; Thu, 23 Dec 2021 06:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640241632; x=1671777632;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fx3CgJn2qtaljzLK5OkurIv7v140lLEfu5f06ioT/MQ=;
  b=m1UQ1RZvKCmbryH/Uno9JSxGEaMQMqOJDuOwDiH+zCW5bnhKd/dI9gFI
   xmjFpzPTbh9P2w77FVcvKv6LHm7yPiT6V59sMpMqO7mcQ0PvCs2ykcdtg
   n+B7d3j9DOMpg7UWzto3tw94CQ6MPP5c/d+5b9zXTZCY9+qMyvvVZWoem
   TL+oxx2Q+KwQhjYFA7z1CKlwD1F/DtyvFmtQX2NA7JvrYo2SU0rQYHFz7
   YlO5o831Z6BD7aYyqigKIrpYeRZ1u7iYGZicGkcjysGETF/pndRgX5igy
   OUCUMBvRNifmoqyBj30xl+EpkWnAgz7hdm0GJmL2kp30tqVsMVAYAPWEW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="327076610"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="327076610"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 22:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="685279052"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Dec 2021 22:40:30 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n0Hm9-0001TG-F0; Thu, 23 Dec 2021 06:40:29 +0000
Date: Thu, 23 Dec 2021 14:39:58 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 e38029da51a109e067b285fe11d2c07e17495d0b
Message-ID: <61c419be.cTEtlRSzm9eN7GLo%lkp@intel.com>
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
branch HEAD: e38029da51a109e067b285fe11d2c07e17495d0b  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 1456m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
mips                         tb0287_defconfig
arm                      pxa255-idp_defconfig
mips                          ath25_defconfig
arc                        nsimosci_defconfig
mips                     loongson1b_defconfig
mips                         bigsur_defconfig
powerpc                  storcenter_defconfig
powerpc                     taishan_defconfig
powerpc                     tqm5200_defconfig
xtensa                         virt_defconfig
sh                          polaris_defconfig
powerpc                      katmai_defconfig
mips                         tb0226_defconfig
microblaze                      mmu_defconfig
sh                        sh7757lcr_defconfig
arm                             pxa_defconfig
sh                          rsk7203_defconfig
m68k                       m5249evb_defconfig
arm64                            alldefconfig
xtensa                           allyesconfig
powerpc                  mpc866_ads_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                           rs90_defconfig
arm                  colibri_pxa300_defconfig
sh                          landisk_defconfig
xtensa                  audio_kc705_defconfig
sh                            shmin_defconfig
mips                        vocore2_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
ia64                             allyesconfig
powerpc                     kilauea_defconfig
sh                          sdk7786_defconfig
sparc                       sparc64_defconfig
arm                         lpc32xx_defconfig
arm                          pxa168_defconfig
powerpc                      makalu_defconfig
arm                        trizeps4_defconfig
arm                          moxart_defconfig
powerpc                     tqm8555_defconfig
arm                         mv78xx0_defconfig
arm                          lpd270_defconfig
arm                  randconfig-c002-20211222
arm                  randconfig-c002-20211223
ia64                             allmodconfig
ia64                                defconfig
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
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211222
x86_64               randconfig-a003-20211222
x86_64               randconfig-a005-20211222
x86_64               randconfig-a006-20211222
x86_64               randconfig-a004-20211222
x86_64               randconfig-a002-20211222
i386                 randconfig-a006-20211222
i386                 randconfig-a004-20211222
i386                 randconfig-a002-20211222
i386                 randconfig-a003-20211222
i386                 randconfig-a001-20211222
i386                 randconfig-a005-20211222
x86_64               randconfig-a013-20211223
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a016-20211223
arc                  randconfig-r043-20211222
riscv                             allnoconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig

clang tested configs:
i386                 randconfig-a011-20211222
i386                 randconfig-a014-20211222
i386                 randconfig-a016-20211222
i386                 randconfig-a015-20211222
i386                 randconfig-a013-20211222
i386                 randconfig-a012-20211222
hexagon              randconfig-r041-20211222
hexagon              randconfig-r045-20211222
riscv                randconfig-r042-20211222
s390                 randconfig-r044-20211222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
