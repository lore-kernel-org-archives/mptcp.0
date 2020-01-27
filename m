Content-Type: multipart/mixed; boundary="===============8262364524607563540=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] kbuild success for export/20200124T170657
Date: Mon, 27 Jan 2020 13:52:29 -0800
Message-ID: <alpine.OSX.2.21.2001271334150.7768@mjmartin-mac01.local>
X-Status: 
X-Keywords:                  
X-UID: 3528

--===============8262364524607563540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Friday I pushed the export branch to git.kernel.org to trigger an =

automated build. This includes:

  * net-next as of the mptcp-part-two merge

  * Topgit commits for multiple subflows

  * A commit to enable CONFIG_MPTCP by default

  * Florian's "do not inherit inet proto ops" fix that was merged to =

net-next over the weekend.

Here's the kbuild success report:

---------- Forwarded message ----------
Date: Sun, 26 Jan 2020 16:19:22
From: kbuild test robot <lkp(a)intel.com>
Subject: [martineau:kbuild-mptcp-enabled] BUILD SUCCESS
     3ffbf6ce9a0ad81d21bf64f4ce2ce2827d337983

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linu=
x.git  kbuild-mptcp-enabled
branch HEAD: 3ffbf6ce9a0ad81d21bf64f4ce2ce2827d337983  mptcp: do not inheri=
t inet proto ops

elapsed time: 2885m

configs tested: 229
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-h001-20200125
x86_64               randconfig-h002-20200125
x86_64               randconfig-h003-20200125
i386                 randconfig-h001-20200125
i386                 randconfig-h002-20200125
i386                 randconfig-h003-20200125
arc                  randconfig-a001-20200125
arm                  randconfig-a001-20200125
arm64                randconfig-a001-20200125
ia64                 randconfig-a001-20200125
powerpc              randconfig-a001-20200125
sparc                randconfig-a001-20200125
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-g001-20200126
x86_64               randconfig-g002-20200126
x86_64               randconfig-g003-20200126
i386                 randconfig-g001-20200126
i386                 randconfig-g002-20200126
i386                 randconfig-g003-20200126
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64               randconfig-b001-20200125
x86_64               randconfig-b002-20200125
x86_64               randconfig-b003-20200125
i386                 randconfig-b001-20200125
i386                 randconfig-b002-20200125
i386                 randconfig-b003-20200125
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
arm                              allmodconfig
arm64                            allmodconfig
csky                 randconfig-a001-20200126
openrisc             randconfig-a001-20200126
s390                 randconfig-a001-20200126
sh                   randconfig-a001-20200126
xtensa               randconfig-a001-20200126
x86_64               randconfig-e001-20200125
x86_64               randconfig-e002-20200125
x86_64               randconfig-e003-20200125
i386                 randconfig-e001-20200125
i386                 randconfig-e002-20200125
i386                 randconfig-e003-20200125
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64               randconfig-c001-20200125
x86_64               randconfig-c002-20200125
x86_64               randconfig-c003-20200125
i386                 randconfig-c001-20200125
i386                 randconfig-c002-20200125
i386                 randconfig-c003-20200125
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
x86_64               randconfig-b001-20200126
x86_64               randconfig-b002-20200126
x86_64               randconfig-b003-20200126
i386                 randconfig-b001-20200126
i386                 randconfig-b002-20200126
i386                 randconfig-b003-20200126
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
x86_64               randconfig-g001-20200125
x86_64               randconfig-g002-20200125
x86_64               randconfig-g003-20200125
i386                 randconfig-g001-20200125
i386                 randconfig-g002-20200125
i386                 randconfig-g003-20200125
x86_64               randconfig-d001-20200125
x86_64               randconfig-d002-20200125
x86_64               randconfig-d003-20200125
i386                 randconfig-d001-20200125
i386                 randconfig-d002-20200125
i386                 randconfig-d003-20200125
c6x                  randconfig-a001-20200126
h8300                randconfig-a001-20200126
microblaze           randconfig-a001-20200126
nios2                randconfig-a001-20200126
sparc64              randconfig-a001-20200126
csky                 randconfig-a001-20200125
openrisc             randconfig-a001-20200125
s390                 randconfig-a001-20200125
xtensa               randconfig-a001-20200125
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
x86_64               randconfig-a001-20200125
x86_64               randconfig-a002-20200125
x86_64               randconfig-a003-20200125
i386                 randconfig-a001-20200125
i386                 randconfig-a002-20200125
i386                 randconfig-a003-20200125
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64               randconfig-f001-20200125
x86_64               randconfig-f002-20200125
x86_64               randconfig-f003-20200125
i386                 randconfig-f001-20200125
i386                 randconfig-f002-20200125
i386                 randconfig-f003-20200125
x86_64               randconfig-c001-20200126
x86_64               randconfig-c002-20200126
x86_64               randconfig-c003-20200126
i386                 randconfig-c001-20200126
i386                 randconfig-c002-20200126
i386                 randconfig-c003-20200126
alpha                randconfig-a001-20200125
m68k                 randconfig-a001-20200125
mips                 randconfig-a001-20200125
nds32                randconfig-a001-20200125
parisc               randconfig-a001-20200125
riscv                randconfig-a001-20200125
c6x                  randconfig-a001-20200125
h8300                randconfig-a001-20200125
microblaze           randconfig-a001-20200125
nios2                randconfig-a001-20200125
sparc64              randconfig-a001-20200125
alpha                randconfig-a001-20200126
m68k                 randconfig-a001-20200126
mips                 randconfig-a001-20200126
nds32                randconfig-a001-20200126
parisc               randconfig-a001-20200126
riscv                randconfig-a001-20200126
x86_64               randconfig-f001-20200126
x86_64               randconfig-f002-20200126
x86_64               randconfig-f003-20200126
i386                 randconfig-f001-20200126
i386                 randconfig-f002-20200126
i386                 randconfig-f003-20200126
x86_64               randconfig-e001-20200126
x86_64               randconfig-e002-20200126
x86_64               randconfig-e003-20200126
i386                 randconfig-e001-20200126
i386                 randconfig-e002-20200126
i386                 randconfig-e003-20200126
x86_64               randconfig-h001-20200126
x86_64               randconfig-h002-20200126
x86_64               randconfig-h003-20200126
i386                 randconfig-h001-20200126
i386                 randconfig-h002-20200126
i386                 randconfig-h003-20200126
sh                   randconfig-a001-20200125
x86_64               randconfig-d001-20200126
x86_64               randconfig-d002-20200126
x86_64               randconfig-d003-20200126
i386                 randconfig-d001-20200126
i386                 randconfig-d002-20200126
i386                 randconfig-d003-20200126
arc                  randconfig-a001-20200126
arm                  randconfig-a001-20200126
arm64                randconfig-a001-20200126
ia64                 randconfig-a001-20200126
powerpc              randconfig-a001-20200126
sparc                randconfig-a001-20200126

---
0-DAY kernel test infrastructure                 Open Source Technology Cen=
ter
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org Intel Corpor=
ation
--===============8262364524607563540==--
