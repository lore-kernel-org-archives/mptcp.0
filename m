Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF1D168
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 20:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641328835; x=1672864835;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XXTLxmbvEQ4mGbCsB/YqC/+dB2R2w4xkgwSmGyHfhxE=;
  b=Gcw7jdWR24DFeaw3zZCrsHMe6r77YNIKvzJTd0duVPVrLKrCajtD60b6
   DPCNacv9Nmp7SIw5vU9UUbyrPvjd2cHJxjUy8vJBD4rC9Pz5tESZQ+BCb
   GDX70CuHYSvMxZBGOduulaCBXlqITLiYbxNTf9sDQ2XjZCDxwD3+v1qwn
   Jdd1JbNo4u7zU3KSwu1dq/FN3D7xsbf99rxg1zLl9ljTsxfW/yAP93+nK
   qxhuAN/gf7zDJH6dwknQRxvoTKUHc4P2Cx6u2B8nIP6oHNrYjc6bg6jpt
   l+I89b9M3Evv3hb8XLoqpnr9Q00Lv4Uscxr9fGM1iU8N9Z5rlNNbg58Ow
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266567380"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="266567380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 12:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="617686530"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2022 12:40:12 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1n4qbL-000Fqp-Ku; Tue, 04 Jan 2022 20:40:11 +0000
Date: Wed, 05 Jan 2022 04:39:47 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 e61c25868ed1d7543307835b5bcb8312c1c461b8
Message-ID: <61d4b093.Ip4OQqQZUAs2soUJ%lkp@intel.com>
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
branch HEAD: e61c25868ed1d7543307835b5bcb8312c1c461b8  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 836m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
