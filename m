Content-Type: multipart/mixed; boundary="===============2679616703181696134=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [mptcp:export] BUILD REGRESSION
 63f83c673fdef4d111c74530abf056c9db3a6465
Date: Sun, 26 Apr 2020 09:25:30 +0800
Message-ID: <5ea4e30a.mr1IYpe9SdiRrFhh%lkp@intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4248

--===============2679616703181696134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://github.com/multipath-tcp/mptcp_net-next.git  export
branch HEAD: 63f83c673fdef4d111c74530abf056c9db3a6465  tcp: mptcp: use mptc=
p receive buffer space to select rcv window

Error/Warning in current branch:

arm-linux-gnueabi-ld: section .data VMA [0000000040008000,0000000040108d27]=
 overlaps section .modinfo VMA [000000003fffe486,000000004004745a]
arm-linux-gnueabi-ld: section __ksymtab VMA [000000004004745c,0000000040056=
f9b] overlaps section .data VMA [0000000040008000,0000000040108d27]
h8300-linux-ld: section .data VMA [0000000000400000,0000000000462d7f] overl=
aps section .text VMA [0000000000000158,000000000078e567]
h8300-linux-ld: section .init.text LMA [0000000000462d80,0000000000495e37] =
overlaps section .text LMA [0000000000000158,000000000078e567]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-a001-20200425
|   |-- arm-linux-gnueabi-ld:section-.data-VMA-00000000400080000040108d27-o=
verlaps-section-.modinfo-VMA-000000003fffe000004004745a
|   `-- arm-linux-gnueabi-ld:section-__ksymtab-VMA-000000004004745c-0000000=
040056f9b-overlaps-section-.data-VMA-00000000400080000040108d27
`-- h8300-randconfig-a001-20200425
    |-- h8300-linux-ld:section-.data-VMA-00000000004000000000462d7f-overlap=
s-section-.text-VMA-0000000000000000000078e567
    `-- h8300-linux-ld:section-.init.text-LMA-0000000000462d0000000495e37-o=
verlaps-section-.text-LMA-0000000000000000000078e567

elapsed time: 1442m

configs tested: 183
configs skipped: 0

arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
arm64                            allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                              allyesconfig
sparc                            allyesconfig
arc                              allyesconfig
m68k                       m5475evb_defconfig
sh                  sh7785lcr_32bit_defconfig
um                           x86_64_defconfig
mips                           ip32_defconfig
h8300                       h8s-sim_defconfig
riscv                    nommu_virt_defconfig
ia64                              allnoconfig
c6x                        evmc6678_defconfig
mips                              allnoconfig
s390                              allnoconfig
ia64                          tiger_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
xtensa                       common_defconfig
powerpc                             defconfig
ia64                                defconfig
nds32                             allnoconfig
nios2                         10m50_defconfig
powerpc                       ppc64_defconfig
riscv                             allnoconfig
parisc                           allyesconfig
ia64                             allyesconfig
parisc                            allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                        generic_defconfig
ia64                         bigsur_defconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                             allmodconfig
mips                malta_kvm_guest_defconfig
mips                         tb0287_defconfig
mips                       capcella_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                          ath79_defconfig
mips                        bcm63xx_defconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allmodconfig
parisc               randconfig-a001-20200426
mips                 randconfig-a001-20200426
alpha                randconfig-a001-20200426
m68k                 randconfig-a001-20200426
nds32                randconfig-a001-20200426
riscv                randconfig-a001-20200426
nios2                randconfig-a001-20200424
c6x                  randconfig-a001-20200424
h8300                randconfig-a001-20200424
sparc64              randconfig-a001-20200424
microblaze           randconfig-a001-20200424
nios2                randconfig-a001-20200426
c6x                  randconfig-a001-20200426
h8300                randconfig-a001-20200426
sparc64              randconfig-a001-20200426
microblaze           randconfig-a001-20200426
nios2                randconfig-a001-20200425
c6x                  randconfig-a001-20200425
h8300                randconfig-a001-20200425
sparc64              randconfig-a001-20200425
microblaze           randconfig-a001-20200425
sh                   randconfig-a001-20200426
csky                 randconfig-a001-20200426
s390                 randconfig-a001-20200426
xtensa               randconfig-a001-20200426
openrisc             randconfig-a001-20200426
sh                   randconfig-a001-20200424
csky                 randconfig-a001-20200424
s390                 randconfig-a001-20200424
xtensa               randconfig-a001-20200424
openrisc             randconfig-a001-20200424
x86_64               randconfig-a001-20200426
i386                 randconfig-a003-20200426
x86_64               randconfig-a003-20200426
i386                 randconfig-a002-20200426
i386                 randconfig-a001-20200426
x86_64               randconfig-a002-20200426
i386                 randconfig-c002-20200426
i386                 randconfig-c001-20200426
x86_64               randconfig-c002-20200426
i386                 randconfig-c003-20200426
i386                 randconfig-a003-20200425
x86_64               randconfig-a001-20200425
x86_64               randconfig-a003-20200425
i386                 randconfig-a001-20200425
i386                 randconfig-a002-20200425
x86_64               randconfig-a001-20200424
i386                 randconfig-a003-20200424
x86_64               randconfig-a003-20200424
i386                 randconfig-a002-20200424
i386                 randconfig-a001-20200424
x86_64               randconfig-a002-20200424
i386                 randconfig-h003-20200426
x86_64               randconfig-h001-20200426
x86_64               randconfig-h003-20200426
x86_64               randconfig-h002-20200426
i386                 randconfig-h001-20200426
i386                 randconfig-h002-20200426
sparc                randconfig-a001-20200426
ia64                 randconfig-a001-20200426
powerpc              randconfig-a001-20200426
arm                  randconfig-a001-20200426
arm64                randconfig-a001-20200426
arc                  randconfig-a001-20200426
sparc                randconfig-a001-20200425
ia64                 randconfig-a001-20200425
powerpc              randconfig-a001-20200425
arm                  randconfig-a001-20200425
arc                  randconfig-a001-20200425
sparc                randconfig-a001-20200424
ia64                 randconfig-a001-20200424
powerpc              randconfig-a001-20200424
arm64                randconfig-a001-20200424
arc                  randconfig-a001-20200424
riscv                               defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============2679616703181696134==--
