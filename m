Content-Type: multipart/mixed; boundary="===============0911966864205864805=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP kbuild configuration updated
Date: Fri, 10 Apr 2020 15:48:27 -0700
Message-ID: <alpine.OSX.2.22.394.2004101538590.23941@poovizhi-mobl1.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4150

--===============0911966864205864805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello -

I updated the kbuild configuration for the mptcp export branch to send =

build success message (example forwarded below). I also added Matthieu as =

a co-owner. The current mptcp config is here:

https://github.com/intel/lkp-tests/blob/master/repo/linux/mptcp

To check the turnaround time on build success, I pushed a current snapshot =

of the export branch to my public repo. The success message arrived less =

than 24 hours later, so hopefully we will see a similar message on this =

list shortly after the next export branch update.

Mat


---------- Forwarded message ----------
Date: Fri, 10 Apr 2020 07:16:08
From: kbuild test robot <lkp(a)intel.com>
To: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Subject: [martineau:kbuild-mptcp-enabled] BUILD SUCCESS
     57da6f0185b3f2e1f98fb8bc5c72a30b6d3732e7

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linu=
x.git  kbuild-mptcp-enabled
branch HEAD: 57da6f0185b3f2e1f98fb8bc5c72a30b6d3732e7  kbuild: Enable CONFI=
G_MPTCP for automated kbuild checking

elapsed time: 951m

configs tested: 148
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
s390                          debug_defconfig
m68k                          multi_defconfig
ia64                                defconfig
powerpc                             defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200410
x86_64               randconfig-a002-20200410
x86_64               randconfig-a003-20200410
i386                 randconfig-a001-20200410
i386                 randconfig-a002-20200410
i386                 randconfig-a003-20200410
alpha                randconfig-a001-20200409
m68k                 randconfig-a001-20200409
mips                 randconfig-a001-20200409
nds32                randconfig-a001-20200409
parisc               randconfig-a001-20200409
riscv                randconfig-a001-20200409
mips                 randconfig-a001-20200410
nds32                randconfig-a001-20200410
m68k                 randconfig-a001-20200410
riscv                randconfig-a001-20200410
alpha                randconfig-a001-20200410
parisc               randconfig-a001-20200410
h8300                randconfig-a001-20200410
nios2                randconfig-a001-20200410
c6x                  randconfig-a001-20200410
sparc64              randconfig-a001-20200410
microblaze           randconfig-a001-20200410
csky                 randconfig-a001-20200409
openrisc             randconfig-a001-20200409
s390                 randconfig-a001-20200409
sh                   randconfig-a001-20200409
xtensa               randconfig-a001-20200409
x86_64               randconfig-b001-20200410
x86_64               randconfig-b002-20200410
x86_64               randconfig-b003-20200410
i386                 randconfig-b001-20200410
i386                 randconfig-b002-20200410
i386                 randconfig-b003-20200410
x86_64               randconfig-c001-20200410
x86_64               randconfig-c002-20200410
x86_64               randconfig-c003-20200410
i386                 randconfig-c001-20200410
i386                 randconfig-c002-20200410
i386                 randconfig-c003-20200410
x86_64               randconfig-e001-20200410
x86_64               randconfig-e002-20200410
x86_64               randconfig-e003-20200410
i386                 randconfig-e001-20200410
i386                 randconfig-e002-20200410
i386                 randconfig-e003-20200410
arc                  randconfig-a001-20200409
arm                  randconfig-a001-20200409
arm64                randconfig-a001-20200409
ia64                 randconfig-a001-20200409
powerpc              randconfig-a001-20200409
sparc                randconfig-a001-20200409
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============0911966864205864805==--
