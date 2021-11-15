Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3272
	for <mptcp@lists.linux.dev>; Mon, 15 Nov 2021 18:58:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="319719723"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="319719723"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 10:58:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="454137515"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2021 10:58:46 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1mmhBm-000MtZ-1a; Mon, 15 Nov 2021 18:58:46 +0000
Date: Tue, 16 Nov 2021 02:57:44 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: [mptcp:export] BUILD SUCCESS
 5596aef6ebdbbed43dd42253bdc3e5fc959cb1ac
Message-ID: <6192ada8.3CdWr4hWzfw2okDG%lkp@intel.com>
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
branch HEAD: 5596aef6ebdbbed43dd42253bdc3e5fc959cb1ac  DO-NOT-MERGE: mptcp: enabled by default

elapsed time: 750m

configs tested: 206
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211115
arm                            zeus_defconfig
nios2                         10m50_defconfig
arm                          pcm027_defconfig
arm                         assabet_defconfig
arm                           tegra_defconfig
h8300                            alldefconfig
arc                                 defconfig
sh                           se7751_defconfig
arm                        mini2440_defconfig
mips                        bcm63xx_defconfig
sh                           se7721_defconfig
powerpc                      pasemi_defconfig
powerpc                      walnut_defconfig
powerpc                     sequoia_defconfig
arm                        mvebu_v7_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7763rdp_defconfig
mips                          malta_defconfig
powerpc                         wii_defconfig
arm                          collie_defconfig
arm                        multi_v7_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                  audio_kc705_defconfig
arm                          ixp4xx_defconfig
m68k                          multi_defconfig
arm                      jornada720_defconfig
powerpc                    sam440ep_defconfig
nios2                               defconfig
mips                         bigsur_defconfig
sh                        edosk7760_defconfig
um                                  defconfig
riscv                               defconfig
arm                    vt8500_v6_v7_defconfig
mips                           rs90_defconfig
sh                      rts7751r2d1_defconfig
nios2                            alldefconfig
mips                         db1xxx_defconfig
ia64                          tiger_defconfig
mips                         cobalt_defconfig
sh                          r7780mp_defconfig
ia64                                defconfig
arm                            xcep_defconfig
sh                        apsh4ad0a_defconfig
openrisc                 simple_smp_defconfig
m68k                        m5307c3_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc85xx_cds_defconfig
arc                        nsim_700_defconfig
mips                       capcella_defconfig
arm                       netwinder_defconfig
arm                        cerfcube_defconfig
powerpc                      katmai_defconfig
arm                         cm_x300_defconfig
m68k                          atari_defconfig
sh                             espt_defconfig
arm                        vexpress_defconfig
h8300                    h8300h-sim_defconfig
openrisc                  or1klitex_defconfig
mips                     loongson1c_defconfig
powerpc                        warp_defconfig
powerpc                        icon_defconfig
arm                       aspeed_g4_defconfig
powerpc                     tqm8541_defconfig
m68k                            mac_defconfig
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
xtensa                generic_kc705_defconfig
arm                            qcom_defconfig
m68k                        mvme16x_defconfig
sh                        sh7757lcr_defconfig
powerpc                     redwood_defconfig
arc                         haps_hs_defconfig
powerpc                       holly_defconfig
powerpc                       ppc64_defconfig
powerpc                  iss476-smp_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
mips                            e55_defconfig
arm                          pxa910_defconfig
xtensa                  nommu_kc705_defconfig
parisc                           alldefconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        trizeps4_defconfig
sh                          urquell_defconfig
arm                     eseries_pxa_defconfig
powerpc                 xes_mpc85xx_defconfig
x86_64                           allyesconfig
powerpc                     taishan_defconfig
mips                           ip28_defconfig
arm                         socfpga_defconfig
arm                        shmobile_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      ppc64e_defconfig
mips                           ip32_defconfig
arm                         at91_dt_defconfig
m68k                         amcore_defconfig
powerpc                      ppc6xx_defconfig
sh                   sh7770_generic_defconfig
arm                          pxa3xx_defconfig
mips                      malta_kvm_defconfig
arm                      pxa255-idp_defconfig
arm                        multi_v5_defconfig
powerpc                  mpc866_ads_defconfig
arc                      axs103_smp_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                        m5272c3_defconfig
arm                          lpd270_defconfig
xtensa                    xip_kc705_defconfig
mips                  decstation_64_defconfig
powerpc                   bluestone_defconfig
sh                           se7343_defconfig
sh                         apsh4a3a_defconfig
arm                             mxs_defconfig
parisc                generic-64bit_defconfig
arm                        mvebu_v5_defconfig
powerpc                     pseries_defconfig
mips                      maltaaprp_defconfig
sh                          r7785rp_defconfig
m68k                        stmark2_defconfig
arm                           sunxi_defconfig
arm                  randconfig-c002-20211115
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a005-20211115
x86_64               randconfig-a003-20211115
x86_64               randconfig-a002-20211115
x86_64               randconfig-a001-20211115
x86_64               randconfig-a006-20211115
x86_64               randconfig-a004-20211115
i386                 randconfig-a006-20211115
i386                 randconfig-a003-20211115
i386                 randconfig-a005-20211115
i386                 randconfig-a001-20211115
i386                 randconfig-a004-20211115
i386                 randconfig-a002-20211115
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211115
i386                 randconfig-c001-20211115
arm                  randconfig-c002-20211115
riscv                randconfig-c006-20211115
powerpc              randconfig-c003-20211115
s390                 randconfig-c005-20211115
mips                 randconfig-c004-20211115
x86_64               randconfig-a015-20211115
x86_64               randconfig-a013-20211115
x86_64               randconfig-a011-20211115
x86_64               randconfig-a012-20211115
x86_64               randconfig-a016-20211115
x86_64               randconfig-a014-20211115
i386                 randconfig-a014-20211115
i386                 randconfig-a016-20211115
i386                 randconfig-a012-20211115
i386                 randconfig-a013-20211115
i386                 randconfig-a011-20211115
i386                 randconfig-a015-20211115
hexagon              randconfig-r045-20211115
hexagon              randconfig-r041-20211115
s390                 randconfig-r044-20211115
riscv                randconfig-r042-20211115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
